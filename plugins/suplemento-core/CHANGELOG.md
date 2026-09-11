# Changelog — suplemento-core

Versionado semántico (semver) desde 2026-09-11, cuando se fijó por primera vez una versión explícita en `plugin.json` (`0.10.0`) — antes se versionaba solo por hash de commit git, sin relación con semver. Este archivo registra hitos relevantes del plugin, no cada commit individual.

**Nota sobre el punto de partida 0.10.0:** no es un cálculo retroactivo estricto de cada cambio histórico desde el origen del proyecto — es una estimación de madurez relativa (pre-1.0, desarrollo activo) al momento de adoptar semver. Hitos anteriores a esta fecha (incluido el cambio de versión de Claude Code a v5, hace ~2 semanas a esta entrada, que impactó reglas del harness) no quedaron registrados con número de versión propio porque el proyecto no llevaba semver todavía — ver pendiente en `SPEC.md` sobre reconstruir ese tramo si el material de esa sesión aparece.

## 2026-09-11 — v0.10.0

- **Metodología multi-runtime**: Suplemento Estrella deja de ser exclusivo de Claude Code. Primera adaptación a otro agente completada: `runtimes/gemini-antigravity/` (Google Gemini / Antigravity), con las 13 skills traducidas al formato y ubicación que ese agente espera. `plugins/suplemento-core/` (Claude Code) se mantiene como harness de referencia — no se movió ni reorganizó.
- **Rebautizo del sistema `brain/`**: pasa a llamarse formalmente **Brain KMS (Brain Knowledge Management System)**, reconociendo que ya cubre más que ADR (también INT, NOC, DEP, REF/REFX). Por ahora el nombre nuevo se adoptó en el runtime de Gemini (`01-brain-kms.md`); la skill `brain-adr` de Claude Code no se renombra todavía — queda pendiente de propagar.
- **Terminología**: se deja el eufemismo "brújula" y se adopta el término técnico "harness" en la documentación de cara al usuario (`marketplace.json`, `plugin.json`).
- Primera vez que `plugin.json` fija una versión semver (`0.10.0`) en lugar de versionarse solo por hash de commit. Cada runtime (Claude Code, Gemini) versiona de forma independiente desde ahora — ver `runtimes/gemini-antigravity/runtime.json`.

## 2026-09-01

- 3 skills nuevas que reemplazan las de Superpowers sin cobertura propia, con el objetivo de poder desinstalar ese plugin:
  - `disenar-antes-de-implementar` — diseño colaborativo antes de código (clasificar spike/acotado/arquitectónico → entender → proponer → aprobar). Equivale a `brainstorming`, integrada con `spec-driven-development` y el sistema `brain/`.
  - `planificacion-por-fases` — plan de implementación con tareas del tamaño de un bocado. Equivale a `writing-plans`, pero ejecución secuencial por defecto (sin ofrecer subagentes como recomendación) y rutas de guardado según la estructura del proyecto.
  - `depuracion-sistematica` — causa raíz antes que fix, método de 4 fases. Equivale a `systematic-debugging`, integrada con `tdd-workflow` (alcance quirúrgico) y `brain/trackers/`.
- `sequential-mode`: nota de que `planificacion-por-fases` es el reemplazo propio de `writing-plans` y ya ejecuta secuencial.
- Pendiente: validar las 3 bajo presión (baseline con subagentes) según `writing-skills` antes de dar por seguro que Superpowers se puede quitar (ver `spec/roadmap-skills.md`).

## 2026-08-04

- Relanzamiento como Suplemento Estrella: nombres corregidos, plugin instalable, sin versión fija.
- Reglas endurecidas (subagentes, TDD, checkpoint) + `brain/` ampliado a 6 categorías (ADR, INT, NOC, DEP, REF, REFX) + comando `/checkpoint`.
