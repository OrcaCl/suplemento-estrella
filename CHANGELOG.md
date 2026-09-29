# Changelog

Registro único de hitos del harness Suplemento Estrella — Core y todos sus runtimes (Claude Code, Google Gemini, y los que vengan). Formato inspirado en [Keep a Changelog](https://keepachangelog.com/), adaptado: **no hay una versión única de proyecto** — cada entrada cita explícitamente la versión del componente que cambió (`[Core vX.Y.Z]`, `[Runtime Claude Code vX.Y.Z]`, `[Runtime Gemini vX.Y.Z]`), porque cada capa versiona de forma independiente (ver ADR-002 en `brain/`). Este archivo registra hitos relevantes, no cada commit individual.

Versionado semántico (semver) desde 2026-09-11 — antes cada componente versionaba solo por hash de commit git, sin relación con semver. El punto de partida `0.10.0` para Claude Code no es un cálculo retroactivo estricto: es una estimación de madurez relativa (pre-1.0, desarrollo activo) al momento de adoptar semver — ver ADR-001 en `brain/`.

## 2026-09-29

### Fixed
- **[Runtime Claude Code v0.10.1]** `SPEC.md` crecía sin límite en proyectos reales (5 KB → 126 KB en dos meses en un proyecto consumidor). Causa raíz: las instrucciones decían *qué* actualizar pero no que había que **reemplazar en vez de acumular**, no ponían tope de tamaño ni decían adónde iban los ítems cerrados. Cada checkpoint agregaba bloques "Antes (fecha) — …" al header y filas "Sesión anterior" a la §2 sin borrar los anteriores; los `[x]` se quedaban en la §3; y el footer ("conteo de tests") se usaba como bitácora en proyectos sin tests. Cambios:
  - `spec-driven-development`: nuevas secciones "Árbitro de destino" (qué va en `SPEC.md` y qué no), "Reemplazar, no acumular" y "Tope de tamaño" (~15 KB, ninguna línea > 600 caracteres, chequeo con `wc -c` y `awk` antes del commit).
  - `commands/checkpoint.md`: el paso 3 pasa a reemplazar-no-acumular y se agrega un paso obligatorio de chequeo de tamaño antes del commit.
  - `documentation-convention`, `brain-adr`, `project-init` (`spec-md-template.md`, `claude-md-template.md`) y `CLAUDE.md` de este repo: alineados con la regla. El footer deja de pedir "conteo de tests" y pasa a "métricas clave del dominio (conteo de tests solo si el proyecto tiene tests)".
  - `spec-md-template.md`: el template abre con un comentario HTML con los límites, para que aparezca en todo `SPEC.md` nuevo.
- **[Runtime Gemini v0.1.1]** Misma corrección con paridad: `11-spec-driven-development.md` (nueva sección 3b), `06-documentation-convention.md`, `01-brain-kms.md` y `references/gemini-template.md`. `core_version` sube a `0.10.1`.

### Changed
- **[Runtime Claude Code v0.11.0]** La skill `brain-adr` se renombra a **`brain-kms`** (`plugins/suplemento-core/skills/brain-kms/`), propagando el rebautizo Brain KMS que ADR-001 dejó pendiente para Claude Code. Se actualizan las referencias en `checkpoint.md`, `documentation-convention`, `spec-driven-development`, `depuracion-sistematica`, `project-init` (y sus `references/`) y en el runtime de Gemini. **Cambio visible para el usuario:** cualquier proyecto que invoque o cite la skill por nombre debe usar `brain-kms`. `brain-adr-template.md` conserva su nombre — sigue siendo la plantilla de los registros ADR.
- **[Runtime Claude Code v0.11.0 / Runtime Gemini v0.1.2]** El mensaje de confirmación de contexto ya no incluye `[N] tests` por defecto — no aplica a proyectos sin tests. Si el proyecto tiene tests, el segmento se agrega; si no, se omite. Afecta `spec-driven-development`, `claude-md-template.md`, `GEMINI-RUNTIME.md`, `11-spec-driven-development.md` y `gemini-template.md`. `core_version` del runtime de Gemini sube a `0.11.0`.

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
