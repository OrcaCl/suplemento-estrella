# Changelog — suplemento-core

Versionado por hash de commit git (ver `SPEC.md` del repo raíz, sección 5). Este archivo registra hitos relevantes del plugin, no cada commit individual.

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
