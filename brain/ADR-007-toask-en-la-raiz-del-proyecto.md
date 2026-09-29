# ADR-007 — TOASK.md vive en la raíz del proyecto, no dentro de brain/

**Estado:** Vigente
**Fecha:** 2026-09-29

## Contexto

Al completar los 4 documentos que seguían vacíos en `docs/` (`principles.md`, `decisions.md`, `glossary.md`, `conventions.md`), el autor aportó el esquema que se había definido originalmente para la estructura de un proyecto: `SHAME.md` y `TOASK.md` en la raíz, junto a `README.md`, `SPEC.md` y `CLAUDE.md`, como archivos **operativos** del proyecto; `docs/` reservado a la documentación conceptual.

La implementación real había derivado de ese esquema: `TOASK.md` vivía en `brain/TOASK.md`, y `project-init` (Claude Code y Gemini) lo creaba ahí. `SHAME.md`, en cambio, ya estaba en la raíz. `docs/getting-started.md` ya listaba `TOASK.md` entre los documentos base de la raíz, lo que dejaba la documentación en contradicción con la estructura que generaba el harness.

**Opciones evaluadas:**
1. Dejar `TOASK.md` en `brain/` y corregir `getting-started.md` para que coincida.
2. Mover `TOASK.md` a la raíz, propagando el cambio a `project-init`, las skills, las plantillas y los docs de ambos runtimes.
3. Mover solo el `TOASK.md` de este repo, sin tocar `project-init`.

## Decisión

Se adopta la opción 2:

1. **`TOASK.md` vive en la raíz del proyecto**, junto a `SPEC.md` y `SHAME.md`. No es un registro de Brain KMS: no tiene numeración, ni estado de vigencia, ni entrada en `brain/index.md`; es una lista operativa de preguntas pendientes.
2. **`project-init` lo crea en la raíz** en ambos runtimes (Claude Code y Gemini). Se actualizan las skills `spec-driven-development` y `brain-kms`, la plantilla `brain-adr-template.md`, y sus equivalentes de Gemini (`01`, `02`, `11`).
3. **Compatibilidad hacia atrás:** los proyectos existentes que tienen `brain/TOASK.md` siguen siendo válidos — la skill `brain-kms` lo indica explícitamente y no hace falta moverlo.
4. Se actualizan `docs/brain.md` (el árbol de `brain/` ya no lista `TOASK.md`) y `docs/glossary.md`. Este repo mueve su propio `TOASK.md` con `git mv`, conservando el historial.

## Razones

1. La opción 3 dejaba a `project-init` creando `brain/TOASK.md` en cada proyecto nuevo, contradiciendo la estructura que el autor definió y creando una divergencia entre este repo y los proyectos que genera.
2. La opción 1 habría cambiado la documentación para que refleje una desviación, no una decisión: el esquema original era deliberado y `SHAME.md` ya lo seguía.
3. `TOASK.md` responde a una pregunta operativa ("¿qué falta por preguntar?"), igual que `SHAME.md` responde a "¿dónde quedó el trabajo?". Ambos se consultan al iniciar o cerrar una sesión; ninguno documenta una decisión. Ubicarlos juntos en la raíz los hace visibles.
4. Mover solo la ubicación, sin renumerar ni reestructurar el contenido, mantiene el cambio pequeño y reversible.

## Consecuencias

- Plugin `suplemento-core` y runtime Gemini incluyen el cambio en las versiones `0.11.0` y `0.1.2` (aún sin publicar al momento de decidirlo, por lo que no requirió otro bump).
- **Cambio de estructura visible:** un proyecto nuevo tiene `TOASK.md` en la raíz; uno anterior a v0.11.0 puede tener `brain/TOASK.md`. Ambas ubicaciones son válidas — no se migra automáticamente.
- `docs/getting-started.md` queda coherente con la estructura real sin cambios.
- No cambia la regla de uso de `TOASK.md` (categorías A/D/S, no es backlog, no promover a registro formal sin confirmación).

## Commit

Ver entrada "Sesión — 2026-09-29 (continuación) — Brain KMS en Claude Code, docs completos y TOASK.md en la raíz" en `brain/sesiones.md`. Cambios de código en el commit `93ace15`.
