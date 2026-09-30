#!/usr/bin/env bash
# check_spec.sh — verifica que SPEC.md cumpla los topes de higiene (suplemento-core >= 0.12.0).
#
# Uso:   check_spec.sh [--report] [ruta/a/SPEC.md]
# Salida: 0 = ok (puede haber WARN) · 1 = hay ERROR · 2 = uso incorrecto.
#         Con --report siempre sale 0: solo informa, no bloquea.
#
# Configuración (opcional): líneas "clave: valor" en el CLAUDE.md (o GEMINI.md) que está junto al SPEC.md.
#   spec_tope_lineas: 1000              tope de líneas (ERROR al superarlo, WARN al 80 %)
#   sesiones_anteriores_en_spec: 0      cuántas filas "Sesión anterior" se permiten en §2
#   ids_en_pendientes: false            true = cada ítem de §3 debe llevar ID estable y único
# Sin CLAUDE.md/GEMINI.md o sin las claves se usan los valores por defecto de arriba.

report=0
if [ "${1:-}" = "--report" ]; then report=1; shift; fi
spec="${1:-SPEC.md}"
[ -f "$spec" ] || { echo "check_spec: no existe $spec" >&2; exit 2; }
dir="$(dirname "$spec")"

# Lee una clave de CLAUDE.md (o GEMINI.md); imprime el valor sin backticks ni comentarios, o el default.
cfg() {
  local v="" f
  for f in "$dir/CLAUDE.md" "$dir/GEMINI.md"; do
    [ -f "$f" ] || continue
    v=$(grep -E "^[-*[:space:]]*$1:" "$f" | head -1 \
      | sed -E "s/^[-*[:space:]]*$1:[[:space:]]*//; s/[\`]//g; s/[[:space:]]*(#|—).*$//; s/[[:space:]]+$//")
    [ -n "$v" ] && break
  done
  echo "${v:-$2}"
}

tope=$(cfg spec_tope_lineas 1000)
n_sesiones=$(cfg sesiones_anteriores_en_spec 0)
ids=$(cfg ids_en_pendientes false)
case "$tope$n_sesiones" in *[!0-9]*) echo "check_spec: spec_tope_lineas y sesiones_anteriores_en_spec deben ser enteros" >&2; exit 2;; esac

errs=0; warns=0
err()  { echo "ERROR: $*"; errs=$((errs+1)); }
# Acorta una lista de números de línea: primeros 8 + cuántos más.
corta() { echo "$1" | awk '{n=NF; for(i=1;i<=n&&i<=8;i++) printf "%s ", $i; if(n>8) printf "… (+%d más)", n-8}'; }
warn() { echo "WARN:  $*"; warns=$((warns+1)); }

# 1. Tamaño por líneas
lineas=$(wc -l < "$spec")
if   [ "$lineas" -gt "$tope" ]; then err  "SPEC.md tiene $lineas líneas (tope $tope)"
elif [ "$lineas" -ge $((tope*80/100)) ]; then warn "SPEC.md tiene $lineas líneas (80% del tope $tope) — condensar pronto"
fi

# 2. Líneas > 600 caracteres
largas=$(awk 'length>600{printf "%s ", NR}' "$spec")
[ -n "$largas" ] && err "líneas de más de 600 caracteres: $(corta "$largas")"

# 3. Filas "Sesión anterior" vs límite configurado
filas=$(grep -cE '^\|[^|]*Sesión anterior' "$spec")
[ "$filas" -gt "$n_sesiones" ] && err "$filas filas 'Sesión anterior' (permitidas: $n_sesiones)"

# 4. Fila "Última sesión" ≤ ~400 caracteres (la celda, sin el rótulo)
ult=$(awk -F'|' '/^\|[^|]*Última sesión/{print length($3); exit}' "$spec")
[ -n "$ult" ] && [ "$ult" -gt 450 ] && warn "fila 'Última sesión' de $ult caracteres (objetivo ≤ ~400)"

# 5. Footer: línea(s) tras el último '---' → una sola línea de ≤ 300 caracteres
footer=$(awk '/^---[[:space:]]*$/{buf=""; next} {buf=buf $0 "\n"} END{printf "%s", buf}' "$spec" | sed '/^[[:space:]]*$/d')
if [ -n "$footer" ]; then
  fl=$(printf '%s\n' "$footer" | wc -l); fc=$(printf '%s' "$footer" | wc -c)
  [ "$fl" -gt 1 ] && err "footer de $fl líneas (debe ser una sola)"
  [ "$fc" -gt 300 ] && err "footer de $fc caracteres (máximo ~300)"
fi

# 6. Versión de cabecera vs footer
vh=$(grep -m1 -E '^\*\*Versión:\*\*' "$spec" | grep -oE '[0-9]+(\.[0-9]+)+' | head -1)
vf=$(printf '%s\n' "$footer" | grep -m1 -oE 'v?[0-9]+(\.[0-9]+)+' | head -1 | sed 's/^v//')
[ -n "$vh" ] && [ -n "$vf" ] && [ "$vh" != "$vf" ] && err "versión de cabecera ($vh) distinta a la del footer ($vf)"

# 7. Pendientes: solo existen en §3 (sección que empieza con '## 3.')
fuera=$(awk '/^## /{en3=($0 ~ /^## 3[.[:space:]]/)} /^[[:space:]]*- \[ \]/ && !en3{printf "%s ", NR}' "$spec")
[ -n "$fuera" ] && err "checkboxes '- [ ]' fuera de §3 (líneas: $(corta "$fuera")) — la lista única de pendientes es §3"
prohibidas=$(grep -nEi '^#{2,4} .*(próxima sesión|prioridad [0-9]|pendientes de )' "$spec" | cut -d: -f1 | tr '\n' ' ')
[ -n "$prohibidas" ] && warn "secciones de pendientes paralelas a §3 (líneas: $(corta "$prohibidas"))"

# 8. Ítems ya cerrados que siguen en §3
cerr=$(awk '/^## /{en3=($0 ~ /^## 3[.[:space:]]/)} en3 && /^[[:space:]]*- \[[xX]\]/{printf "%s ", NR}' "$spec")
[ -n "$cerr" ] && err "ítems '[x]' que siguen en §3 (líneas: $(corta "$cerr")) — moverlos al archivo de cerrados"

# 9. IDs estables y únicos en §3 (solo si el proyecto los declara)
if [ "$ids" = "true" ]; then
  items=$(awk '/^## /{en3=($0 ~ /^## 3[.[:space:]]/)} en3 && /^[[:space:]]*- \[[ xX]\]/' "$spec")
  sin=$(printf '%s\n' "$items" | grep -vE '^[[:space:]]*- \[[ xX]\] \**([A-Za-z]+-)?[0-9]+\**[[:space:].:—-]' | sed '/^$/d' | wc -l)
  [ "$sin" -gt 0 ] && err "$sin ítems de §3 sin ID (ids_en_pendientes: true)"
  dup=$(printf '%s\n' "$items" | grep -oE '^[[:space:]]*- \[[ xX]\] \**([A-Za-z]+-)?[0-9]+' \
        | grep -oE '([A-Za-z]+-)?[0-9]+$' | sort | uniq -d | tr '\n' ' ')
  [ -n "$dup" ] && err "IDs duplicados en §3: $dup"
fi

echo "check_spec: $lineas líneas · $errs error(es) · $warns advertencia(s)"
[ "$report" -eq 1 ] && exit 0
[ "$errs" -gt 0 ] && exit 1
exit 0
