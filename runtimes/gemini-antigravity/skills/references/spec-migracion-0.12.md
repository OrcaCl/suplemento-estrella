# Migración a core 0.12.0 (runtime Gemini 0.1.3) y normalización de SPEC.md

Para proyectos que venían de core 0.11 o anterior. **No se borra nada del contenido existente**: lo viejo se depreca con aviso.

## Qué cambió

| Antes | Ahora |
|---|---|
| Comando `checkpoint` (registra + commit + push) | `ward` (registra + commit, **sin push**) y `listeilor` (cierre de sesión: verifica, revisa pendientes, commit + push). `checkpoint` queda deprecado |
| `SPEC.md` ≤ ~15 KB, chequeo con `wc -c` (prosa) | `SPEC.md` ≤ 1000 líneas (configurable), chequeo con `.gemini/scripts/check_spec.sh` (sale ≠ 0) |
| Cerrados → `spec/completado.md` (1 línea con fecha) | Archivo **único** `spec/cerrados.md`: ID + fecha + evidencia |
| Sin filas "Sesión anterior" | Configurable: `sesiones_anteriores_en_spec: N` (defecto 0) |
| Pendientes podían repartirse en varias secciones | §3 es la **lista única**; `- [ ]` fuera de §3 prohibido |
| "Registro inmediato" vs "diferido" sin reconciliar | `registro: diferido` (defecto) o `inmediato`, declarado por proyecto |

## Pasos de migración

1. **Actualizar el runtime:** volver a correr el instalador (`curl -fsSL https://raw.githubusercontent.com/OrcaCl/suplemento-estrella/main/install-gemini.sh | bash`). Sobrescribe `.gemini/` con la versión 0.1.3; no toca `SPEC.md`, `brain/` ni `spec/`.
2. **Buscar un `checkpoint` local que tape al runtime:** reglas, workflows o comandos propios del proyecto con nombre `checkpoint`, `ward` o `listeilor`. Comparar sus pasos con `06-documentation-convention.md`; retirarlo cuando el runtime los cubra (lo decide el humano).
3. **Revisar `GEMINI.md` (y `CLAUDE.md` si existe):** si su checklist pide "2–4 líneas por sesión en Estado actual" o "marcar `[x]`", contradice 0.12. Cerrar un ítem = borrar de §3 + pegar en el archivo de cerrados con ID + fecha + evidencia.
4. **Agregar la configuración** en `GEMINI.md` (solo lo que quieras cambiar): `registro: diferido`, `spec_tope_lineas: 1000`, `sesiones_anteriores_en_spec: 0`, `archivo_cerrados: spec/cerrados.md`, `ids_en_pendientes: false`. Si ya tienes un archivo único de cerrados con otro nombre, decláralo en `archivo_cerrados`.
5. **Deprecar `spec/completado.md`** (no borrarlo): agregar al inicio `> ⚠️ DEPRECATED desde core 0.12.0. Los ítems cerrados viven en spec/cerrados.md, con ID, fecha y evidencia.` y crear `spec/cerrados.md`.
6. **Auditar:** `bash .gemini/scripts/check_spec.sh --report SPEC.md` (solo informa).
7. **Hook `pre-commit` opcional:**
   ```
   cat > .git/hooks/pre-commit <<'HOOK'
   #!/bin/sh
   git diff --cached --name-only | grep -qx 'SPEC.md' || exit 0
   bash .gemini/scripts/check_spec.sh SPEC.md || { echo "pre-commit: SPEC.md excede los topes"; exit 1; }
   HOOK
   chmod +x .git/hooks/pre-commit
   ```
   `.git/hooks/` no se versiona: cada clon debe instalarlo.

## Normalizar un SPEC.md ya degradado

Para un `SPEC.md` con cientos de KB, decenas de filas de sesión, footer atrasado y pendientes dispersos (caso real: 133 KB → 56 KB). Ejecutarlo con el humano, no en silencio; partir de `check_spec.sh --report`.

1. **Mover, verbatim, lo que sale:** el catastro original y los planes de sesión pasados van tal cual al archivo de cerrados/histórico. Primero se preserva, después se ordena.
2. **Reescribir §3 como lista única por prioridad** (Alta / Media / Baja / Externo), una línea de contexto por ítem, **conservando los IDs**; las colas que solo estaban en narrativa reciben ID nuevo (nunca reutilizar uno cerrado).
3. **Verificar cada ítem "abierto" contra código o datos reales** (en el caso de referencia: ≥ 5 cerrados sin marcar y 1 marcado cerrado que no lo estaba). Los que se cierran llevan evidencia verificable.
4. **Antes de borrar filas de sesión o párrafos de footer, comprobar que cada una exista en `brain/sesiones.md`** (por fecha o contenido); lo que falte se agrega ahí primero.
5. **Convertir cada `- [ ]` suelto** en "→ ítem N" o en ✅ con fecha.
6. **Reducir el footer a una línea** y el header a versión + fecha; ambas versiones coinciden.
7. **Aplicar el límite de sesiones** (`sesiones_anteriores_en_spec`, 0 por defecto), cada fila ≤ 600 caracteres.
8. **Correr `check_spec.sh`** sin `--report`: debe salir con código 0. Ajustar `spec_tope_lineas` solo si el defecto no calza con el proyecto — no para "hacer pasar" un archivo degradado.

**Regla de oro:** ningún dato se pierde; todo lo que sale de `SPEC.md` existe en el archivo de cerrados, el histórico o `brain/sesiones.md` antes de borrarse.
