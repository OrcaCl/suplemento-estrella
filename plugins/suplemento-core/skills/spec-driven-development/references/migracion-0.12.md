# Migración a suplemento-core 0.12.0

Para proyectos que venían de 0.11 o anterior. **No se borra nada del contenido existente**: lo viejo se deprecia con aviso.

## Qué cambió

| Antes (≤ 0.11) | Ahora (0.12.0) |
|---|---|
| Comando `checkpoint` (registra + commit + push) | `ward` (registra + commit, **sin push**) y `listeilor` (cierre de sesión: verifica, revisa pendientes, commit + push). `checkpoint` queda como alias deprecado |
| `SPEC.md` ≤ ~15 KB, chequeo con `wc -c` (prosa) | `SPEC.md` ≤ 1000 líneas (configurable), chequeo con `scripts/check_spec.sh` (sale ≠ 0) |
| Ítems cerrados → `spec/completado.md` (1 línea con fecha) | Ítems cerrados → archivo **único** de cerrados (`spec/cerrados.md`) con ID + fecha + evidencia |
| Sin filas "Sesión anterior" | Configurable: `sesiones_anteriores_en_spec: N` (por defecto 0) |
| Pendientes podían repartirse en varias secciones | §3 es la **lista única**; `- [ ]` fuera de §3 está prohibido |
| "Registro inmediato" (`spec-driven-development`) vs "diferido" (`documentation-convention`) | Declarado por proyecto: `registro: diferido` (defecto) o `inmediato` |

## Pasos de migración

1. **Actualizar el plugin** (marketplace `suplemento-estrella` → `suplemento-core` 0.12.0) y reiniciar Claude Code.
2. **Buscar un checkpoint local que tape al del plugin:** `ls .claude/commands/checkpoint.md .claude/commands/ward.md .claude/commands/listeilor.md`. Un `checkpoint.md` local responde a "checkpoint" en lugar del comando del plugin y suele seguir el modelo antiguo (marcar `[x]`, actualizar footer con conteos), que es el que hace crecer `SPEC.md`. Compara sus pasos con `commands/ward.md`; cuando el plugin los cubra, retira el local (renómbralo a `.bak` o bórralo tú — el plugin no lo hace).
3. **Revisar `CLAUDE.md` del proyecto:** si su checklist pide "2–4 líneas por sesión en Estado actual" o "marcar ítems como `[x]`", contradice 0.12. Reemplázalo por: "cerrar ítems = borrar de §3 + pegar en el archivo de cerrados con ID + fecha + evidencia".
4. **Agregar la configuración** en `CLAUDE.md` (solo lo que quieras cambiar del defecto):
   ```
   ## Configuración de SPEC
   - registro: diferido
   - spec_tope_lineas: 1000
   - sesiones_anteriores_en_spec: 0
   - archivo_cerrados: spec/cerrados.md
   - ids_en_pendientes: false
   ```
   Si ya tienes un archivo único de cerrados con otro nombre (p. ej. `spec/catastro-historico.md`), decláralo en `archivo_cerrados` y no hace falta renombrarlo.
5. **Deprecar `spec/completado.md`** (no borrarlo): agregar al inicio
   ```
   > ⚠️ DEPRECATED desde suplemento-core 0.12.0. Los ítems cerrados viven en `spec/cerrados.md`, con ID, fecha y evidencia. Este archivo se conserva solo como histórico.
   ```
   y crear `spec/cerrados.md` con el formato de `spec-driven-development` ("Regla de cierre de un ítem").
6. **Auditar el `SPEC.md`:** `bash <ruta al plugin>/scripts/check_spec.sh --report SPEC.md`. Solo informa, no modifica nada. Si sale un `SPEC.md` degradado, seguir `normalizacion-spec.md`.
7. **Hook `pre-commit` (opcional):** copiar el script al proyecto y bloquear commits de un `SPEC.md` que falla.
   ```
   mkdir -p scripts
   cp "$(find ~/.claude/plugins -path '*suplemento-core*/scripts/check_spec.sh' | head -1)" scripts/check_spec.sh
   cat > .git/hooks/pre-commit <<'EOF'
   #!/bin/sh
   # Solo verifica si el commit toca SPEC.md
   git diff --cached --name-only | grep -qx 'SPEC.md' || exit 0
   bash scripts/check_spec.sh SPEC.md || { echo "pre-commit: SPEC.md excede los topes (ver salida arriba)"; exit 1; }
   EOF
   chmod +x .git/hooks/pre-commit
   ```
   `.git/hooks/` no se versiona: cada clon debe instalarlo. Si actualizas el plugin, vuelve a copiar `check_spec.sh` para que el proyecto no quede con una copia vieja.

## Qué revisar después

- `ward` en un proyecto con `checkpoint.md` local produce el aviso de colisión antes de escribir nada.
- Tras un `ward`: `SPEC.md` pasa `check_spec.sh`; ningún `- [ ]` fuera de §3; el ítem que cerraste está en el archivo de cerrados con ID, fecha y evidencia y **ya no** está en §3.
- Tu tope realista: si `SPEC.md` ya excede 1000 líneas, sube `spec_tope_lineas` a un valor acorde **como paso transitorio** y normaliza; no lo dejes inflado.
