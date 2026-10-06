# Migración a suplemento-core 0.12.0

Para proyectos que venían de 0.11 o anterior. **No se borra nada del contenido existente**: lo viejo se deprecia con aviso.

## Qué cambió

| Antes (≤ 0.11) | Ahora (0.12.0) |
|---|---|
| Comando `checkpoint` (registra + commit + push) | `ward` (registra + commit, **sin push**) y `keepit` (llamado `listeilor` en 0.12 y 0.13; cierre de sesión: verifica, revisa pendientes, commit + push). `checkpoint` fue retirado en 0.15.0 |
| `SPEC.md` ≤ ~15 KB | `SPEC.md` ≤ 1000 líneas (configurable), controlado al leerlo y en `ward`/`keepit` |
| Ítems cerrados → `spec/completado.md` (1 línea con fecha) | `spec/cerrados.md`: ID original + fecha + evidencia, **ordenado por ID** |
| Sin filas "Sesión anterior" | Configurable: `sesiones_anteriores_en_spec: N` (por defecto 0) |
| Pendientes podían repartirse en varias secciones | §3 es la **lista única**, con ID en cada ítem; `- [ ]` fuera de §3 está prohibido |
| "Registro inmediato" (`spec-driven-development`) vs "diferido" (`documentation-convention`) | Declarado por proyecto: `registro: diferido` (defecto) o `inmediato` |
| `spec/historial.md` | Retirado de las plantillas; la narrativa va a `brain/sesiones.md` |

## Pasos de migración

1. **Actualizar el plugin** (marketplace `suplemento-estrella` → `suplemento-core` 0.12.0) y reiniciar Claude Code. Comandos en el `README.md` del repo.
2. **Buscar un checkpoint local que tape al del plugin:** `ls .claude/commands/`. Un `checkpoint.md` local sigue respondiendo a "checkpoint" y suele seguir el modelo antiguo (marcar `[x]`, actualizar footer con conteos), que es el que hace crecer `SPEC.md`. Compara sus pasos con `commands/ward.md`; cuando el plugin los cubra, retira el local (renómbralo a `.bak` o bórralo tú — el plugin no lo hace).
3. **Revisar `CLAUDE.md` del proyecto:** si su checklist pide "2–4 líneas por sesión en Estado actual" o "marcar ítems como `[x]`", contradice 0.12. Reemplázalo por: "cerrar ítems = borrar de §3 + insertar en `spec/cerrados.md` con su ID + fecha + evidencia".
4. **Agregar la configuración** en `CLAUDE.md` (solo lo que quieras cambiar del defecto):
   ```
   ## Configuración de SPEC
   - registro: diferido
   - spec_tope_lineas: 1000
   - sesiones_anteriores_en_spec: 0
   ```
5. **Archivo de cerrados — el nombre es siempre `spec/cerrados.md`:**
   - Si ya tienes un archivo único de cerrados con otro nombre (p. ej. `spec/catastro-historico.md`), renómbralo: `git mv spec/catastro-historico.md spec/cerrados.md`, y corrige los enlaces que lo citen. Verifica que quede **ordenado por ID**.
   - Si tienes `spec/completado.md` (0.11 o anterior), no lo borres: agrega al inicio `> ⚠️ DEPRECATED desde suplemento-core 0.12.0. Los ítems cerrados viven en spec/cerrados.md, con ID, fecha y evidencia. Este archivo se conserva solo como histórico.` y crea `spec/cerrados.md` con el formato de `spec-driven-development` ("Regla de cierre de un ítem").
6. **Revisar el `SPEC.md` contra los topes** (lista en `spec-driven-development`, "Tope de tamaño"). Si está degradado, seguir `normalizacion-spec.md`.

## Qué revisar después

- `ward` en un proyecto con `checkpoint.md` local produce el aviso de colisión antes de escribir nada.
- Tras un `ward`: el `SPEC.md` cumple la lista de topes; ningún `- [ ]` fuera de §3; el ítem que cerraste está en `spec/cerrados.md` con **su ID original**, fecha y evidencia, en su posición por ID, y **ya no** está en §3.
- Si `SPEC.md` ya excede 1000 líneas, sube `spec_tope_lineas` a un valor acorde **como paso transitorio** y normaliza; no lo dejes inflado.
