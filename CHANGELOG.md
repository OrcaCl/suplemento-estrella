# Changelog

Registro único de hitos del harness Suplemento Estrella — Core y todos sus runtimes (Claude Code, Google Gemini, y los que vengan). Formato inspirado en [Keep a Changelog](https://keepachangelog.com/), adaptado: **no hay una versión única de proyecto** — cada entrada cita explícitamente la versión del componente que cambió (`[Core vX.Y.Z]`, `[Runtime Claude Code vX.Y.Z]`, `[Runtime Gemini vX.Y.Z]`), porque cada capa versiona de forma independiente (ver ADR-002 en `brain/`). Este archivo registra hitos relevantes, no cada commit individual.

Versionado semántico (semver) desde 2026-09-11 — antes cada componente versionaba solo por hash de commit git, sin relación con semver. El punto de partida `0.10.0` para Claude Code no es un cálculo retroactivo estricto: es una estimación de madurez relativa (pre-1.0, desarrollo activo) al momento de adoptar semver — ver ADR-001 en `brain/`.

## 2026-09-11

### Added
- **[Runtime Gemini v0.1.0]** Primera adaptación de Suplemento Estrella + Brain KMS a Google Gemini (Antigravity IDE): 13 skills traducidas, `GEMINI.md`, `GEMINI-RUNTIME.md`, `.geminirules`, templates propios en `runtimes/gemini-antigravity/`.
- **[Runtime Gemini v0.1.0]** `install-gemini.sh` — instalador de una línea en la raíz del repo: descarga el runtime a `.gemini/` dentro del proyecto del usuario sin clonar el repo completo.
- **[Runtime Gemini v0.1.0]** `skills/02-project-init.md` completado (estaba vacío) — incluye modo adopción para proyectos ya inicializados con otro agente (Claude Code): detecta `SPEC.md`/`brain/` existentes, los adopta sin recrearlos, genera solo `GEMINI.md`/`.geminiignore`. Ver ADR-005.
- **[Core]** `docs/philosophy.md`, `docs/workflow.md`, `docs/spec.md`, `docs/plugins.md` — nuevo contenido, reorganizado desde el `README.md` original. Ver ADR-004.
- **[Core]** `runtimes/README.md` — documenta la convención: Claude Code permanece en `plugins/suplemento-core/` (runtime de referencia), `runtimes/` aloja adaptaciones a otros agentes.
- **[Core]** Sistema `brain/` rebautizado formalmente como **Brain KMS** (Brain Knowledge Management System) — adoptado en Gemini (`01-brain-kms.md`); pendiente propagar el renombre a la skill `brain-adr` de Claude Code.

### Changed
- **[Core / Runtime Claude Code v0.10.0]** Terminología: se deja el eufemismo "brújula" y se adopta el término técnico "harness" (`marketplace.json`, `plugin.json`).
- **[Runtime Claude Code v0.10.0]** Primera vez que `plugin.json` fija versión semver, dejando atrás el versionado exclusivo por hash de commit.
- **[Core]** `CHANGELOG.md` se consolida en la raíz del repo — antes vivía solo en `plugins/suplemento-core/CHANGELOG.md`. Ver ADR-002.
- **[Core / Runtime Gemini v0.1.0]** Licencia MIT adoptada para todo el repo — `LICENSE` en la raíz, declarada por igual en `plugin.json` y `runtime.json`. `runtime.json` de Gemini corregido: `author` a la persona real (no "Suplemento Estrella"), agrega `display_name` y bloque `architecture`; se descarta `target_model` por atarse a una versión de modelo específica. Ver ADR-003.
- **[Core]** `README.md` reducido a landing page (~65 líneas) — contenido extenso movido a `docs/`. Ver ADR-004.
- **[Core]** `docs/getting-started.md` y `docs/brain.md` actualizados (terminología, instalación con ambos runtimes).

### Fixed
- **[Runtime Gemini v0.1.0]** `install-gemini.sh` — corregidos nombres de archivo incorrectos en la lista de templates a descargar (`references/`), que hacían fallar la instalación en cualquier uso real.

### Known issues / pendientes
- `docs/conventions.md` y `docs/glossary.md` siguen sin contenido — sin fuente clara para reconstruirlos, no se inventó nada.
- `docs/principles.md` y `docs/decisions.md` quedan sin usar tras el reparto de contenido — pendiente decidir si se fusionan o se retiran.
- Causa raíz registrada sin resolver: bajo Claude Code v5, Superpowers + `claude-mem` disparaban consumo de tokens al inyectar contexto completo (incluido `SPEC.md`) en cada sesión — ver ADR-001.

## 2026-09-01

- **[Runtime Claude Code]** 3 skills nuevas que reemplazan las de Superpowers sin cobertura propia, con el objetivo de poder desinstalar ese plugin:
  - `disenar-antes-de-implementar` — diseño colaborativo antes de código (clasificar spike/acotado/arquitectónico → entender → proponer → aprobar). Equivale a `brainstorming`, integrada con `spec-driven-development` y el sistema `brain/`.
  - `planificacion-por-fases` — plan de implementación con tareas del tamaño de un bocado. Equivale a `writing-plans`, pero ejecución secuencial por defecto (sin ofrecer subagentes como recomendación) y rutas de guardado según la estructura del proyecto.
  - `depuracion-sistematica` — causa raíz antes que fix, método de 4 fases. Equivale a `systematic-debugging`, integrada con `tdd-workflow` (alcance quirúrgico) y `brain/trackers/`.
- `sequential-mode`: nota de que `planificacion-por-fases` es el reemplazo propio de `writing-plans` y ya ejecuta secuencial.
- Pendiente en su momento: validar las 3 bajo presión (baseline con subagentes) según `writing-skills` antes de dar por seguro que Superpowers se puede quitar (ver `spec/roadmap-skills.md`).

## 2026-08-04

- **[Runtime Claude Code]** Relanzamiento como Suplemento Estrella: nombres corregidos, plugin instalable, sin versión fija.
- Reglas endurecidas (subagentes, TDD, checkpoint) + `brain/` ampliado a 6 categorías (ADR, INT, NOC, DEP, REF, REFX) + comando `/checkpoint`.
