# ADR-019 — Los boletines viven en `brain/reports/`

**Estado:** Vigente
**Fecha:** 2026-11-18

## Contexto

En proyectos grandes, la carpeta `brain/` se llena de decenas de boletines (ADR, INT, NOC, DEP, REF, REFX), todos sueltos junto a `index.md` y `sesiones.md`. Este mismo repo ya tenía 23 en la raíz de `brain/`, y el autor reportó que en sus proyectos grandes la carpeta se vuelve difícil de recorrer.

## Decisión

1. **Los boletines viven en `brain/reports/`**, con el mismo nombre de archivo de siempre (`ADR-NNN-slug.md`, etc.). El nombre `reports` mantiene la consistencia con las plantillas de `trackers/`.
2. **La raíz de `brain/` solo conserva dos archivos:** `index.md` y `sesiones.md`. Las carpetas `reports/`, `trackers/` y `files/` no cambian de función.
3. **`project-init` crea la carpeta `reports/`** en los proyectos nuevos; `brain-kms`, `ward`, `keepit`, `housekeeping` y las plantillas apuntan a la nueva ruta.
4. **Los proyectos anteriores a la 0.16.0 no se migran solos.** Su diseño plano sigue siendo válido (igual que un `TOASK.md` dentro de `brain/`); en un mismo proyecto los boletines van todos en un solo lugar, sin mezclar. `housekeeping` detecta los boletines sueltos en la raíz y propone la migración como un hallazgo mecánico; la guía `migracion-0.16.md` trae los comandos.
5. **Los enlaces de `brain/index.md` llevan el prefijo `reports/`.** Es el único cambio de contenido que necesita el índice; los boletines no se editan.

## Alternativas descartadas

- **Una subcarpeta por tipo (`reports/adr/`, `reports/int/`…):** agrega un nivel más y obliga a elegir carpeta en cada boletín; con el prefijo del nombre ya se distinguen.
- **Migrar automáticamente los proyectos existentes:** mueve archivos que el humano no pidió mover y puede romper enlaces que el plugin no ve. Se propone, no se impone.

## Consecuencias

- Los boletines históricos de este repo cambian de ruta; su historial de git se conserva (`git mv`). Los textos antiguos que citan rutas como `brain/ADR-006` no se editan: son historia.
- Las referencias externas a la ruta antigua (por ejemplo un enlace en un README) deben actualizarse a mano.
- El diseño plano y el nuevo conviven; las skills indican cuál aplica según lo que el proyecto ya tenga.

## Commit

Ver entrada "Sesión — 2026-11-18 — boletines en `brain/reports/`" en `brain/sesiones.md`.
