# Changelog

Registro único de hitos del harness Suplemento Estrella — Core y todos sus runtimes (Claude Code, Google Gemini, y los que vengan). Formato inspirado en [Keep a Changelog](https://keepachangelog.com/), adaptado: **no hay una versión única de proyecto** — cada entrada cita explícitamente la versión del componente que cambió (`[Core vX.Y.Z]`, `[Runtime Claude Code vX.Y.Z]`, `[Runtime Gemini vX.Y.Z]`), porque cada capa versiona de forma independiente (ver ADR-002 en `brain/`). Este archivo registra hitos relevantes, no cada commit individual.

Versionado semántico (semver) desde 2026-09-11 — antes cada componente versionaba solo por hash de commit git, sin relación con semver. El punto de partida `0.10.0` para Claude Code no es un cálculo retroactivo estricto: es una estimación de madurez relativa (pre-1.0, desarrollo activo) al momento de adoptar semver — ver ADR-001 en `brain/`.

## 2026-10-06

### Removed
- **[Runtime Claude Code v0.15.0]** Se retiran los comandos `checkpoint` (deprecado desde 0.12.0) y `listeilor` (renombrado a `keepit` en 0.14.0). Ya no existen `commands/checkpoint.md` ni `commands/listeilor.md`. Si el humano dice una de esas palabras, `documentation-convention` indica el comando vigente (`checkpoint` → `ward`, `listeilor` → `keepit`) y lo ejecuta. **Cambio incompatible:** los proyectos que aún usan esas palabras deben pasar a `ward`/`keepit` antes de actualizar. El aviso de colisión sigue buscando `checkpoint.md` y `listeilor.md` locales, porque un `checkpoint` heredado puede seguir acumulando en `SPEC.md`. Decisión en DEP-001.
- **[Runtime Gemini v0.1.6]** Paridad con core 0.15.0 (`core_version` = 0.15.0): `06-documentation-convention` y `spec-migracion-0.12` marcan `checkpoint` y `listeilor` como retirados. Para actualizar, volver a correr el instalador.

### Changed
- **[Runtime Claude Code v0.14.0]** `listeilor` se renombra a **`keepit`**: una palabra corta, fácil de recordar y sin chilenismo para pedir el cierre de sesión (verifica respaldo en `brain/` y `SPEC.md`, revisa pendientes, commit + push). El procedimiento no cambia; solo la palabra. Decisión en ADR-010.
  - Nuevo `commands/keepit.md`. `commands/listeilor.md` queda como **alias deprecado**: avisa del cambio y ejecuta `keepit`, igual que `checkpoint` desde 0.12.0; se retirará en una versión futura.
  - `ward`, `documentation-convention`, `spec-driven-development`, `brain-kms`, `tdd-workflow`, `project-init` (incluida la plantilla de `CLAUDE.md`) y las guías de migración usan `keepit`. El aviso de colisión también busca `listeilor` entre los comandos y skills locales.
  - **Proyectos ya instalados:** actualizar el plugin no modifica su `CLAUDE.md`. Si menciona `listeilor`, cambiarlo por `keepit` a mano; mientras tanto la palabra anterior sigue funcionando. Sin migración de archivos.
  - Las entradas históricas de este changelog, `brain/` y `spec/cerrados.md` conservan "listeilor": documentan el nombre vigente en su momento.
- **[Runtime Gemini v0.1.5]** Paridad con core 0.14.0 (`core_version` = 0.14.0): `listeilor` pasa a `keepit` en `06-documentation-convention` (con `listeilor` como nombre deprecado), `01-brain-kms`, `11-spec-driven-development`, `14-code-comment-convention`, `GEMINI-RUNTIME`, `gemini-template` y `spec-migracion-0.12`. Para actualizar, volver a correr el instalador.
- **[Core]** `README.md`, `docs/`, `spec/datos.md` y el `CLAUDE.md` de este repo usan `keepit`.

### Added
- **[Runtime Claude Code v0.13.0]** Nueva skill `code-comment-convention`: dirección para los comentarios "in-code", que hasta ahora no tenían ninguna. El código explica QUÉ y CÓMO, los comentarios explican POR QUÉ; contratos con la convención del lenguaje (JSDoc, PHPDoc, docstrings); `TODO`/`FIXME`/`HACK`/`NOTE` con significados distintos; y una **regla de no destrucción** — una limpieza o refactorización no elimina comentarios de decisión, regla de negocio, workaround, seguridad o rendimiento solo porque el código parece claro. Complementa a `documentation-convention`, `spec-driven-development` y `brain-kms`.
  - `project-init`: el `CLAUDE.md` de los proyectos nuevos incluye la sección `## Comentarios en el código` (plantilla y Paso 3, ítem 9).
  - **Proyectos ya instalados:** actualizar el plugin no modifica su `CLAUDE.md`. `ward` y `listeilor` (paso 0a) ofrecen **una sola vez** agregar la sección si el proyecto no menciona la skill; si el humano la rechaza queda constancia en `CLAUDE.md` y no se vuelve a ofrecer. Guía en `skills/code-comment-convention/references/migracion-0.13.md`. Es opcional y no exige tocar código existente.
- **[Runtime Gemini v0.1.4]** Paridad con core 0.13.0 (`core_version` = 0.13.0): nueva `14-code-comment-convention.md` (traducción condensada; incluye la sección de adopción), `06-documentation-convention` (paso 0a de `ward`, oferta única de la convención), `02-project-init` y `gemini-template` (sección `## Comentarios en el código`). `install-gemini.sh` descarga la skill nueva (14 skills). Para actualizar, volver a correr el instalador.

## 2026-09-30

### Changed
- **[Runtime Claude Code v0.12.0]** `SPEC.md` volvió a degradarse en un proyecto real (134 KB, 55 filas de sesión, footer atrasado meses, 18+ `- [ ]` fuera de §3) pese al fix de 0.10.1. Causas: un `checkpoint` local tapaba al del plugin, las reglas del plugin se contradecían, y el control de tamaño no se cumplía. Ver INT-001 en `brain/` (nació como INT-004 en el proyecto de origen).
  - **`checkpoint` se divide en dos comandos:** `ward` (todo lo que hacía `checkpoint`, **sin push**) y `listeilor` (cierre de sesión: verifica respaldo en `brain/` y `SPEC.md`, revisa pendientes faltantes, commit + push). `checkpoint` queda como alias deprecado que avisa y ejecuta `ward`. **Cambio de comportamiento:** ya no hace push.
  - **Aviso de colisión** con comandos/skills locales `ward`/`listeilor`/`checkpoint`, en `documentation-convention` y en los comandos (un comando local que tapa al del plugin impide que este se ejecute para avisar).
  - **Tope de `SPEC.md` por líneas** (1000 por defecto, `spec_tope_lineas`; aviso al 80 %), reemplaza el tope de ~15 KB de ADR-006. Se controla **al leer el archivo** y en `ward`/`listeilor` antes del commit, con una lista de verificación (líneas, líneas > 600 caracteres, filas de sesión, footer, pendientes fuera de §3, `[x]` en §3, IDs duplicados). El plugin **no incluye scripts**.
  - **`spec/cerrados.md`** (nombre fijo) reemplaza a `spec/completado.md`, que se depreca con aviso sin borrarse. Cada ítem cerrado conserva **el mismo ID que tenía en la lista de pendientes**, con fecha y evidencia verificable, y se inserta **ordenado por ID**, no por orden de llegada.
  - **Lista única de pendientes:** §3 es el único lugar de ítems abiertos, con ID en cada ítem; los IDs son estables y no se reutilizan.
  - **Configuración por proyecto** (líneas `clave: valor` en `CLAUDE.md`): `registro`, `spec_tope_lineas`, `sesiones_anteriores_en_spec`.
  - **Contradicción reconciliada:** `spec-driven-development` ("registro inmediato") vs `documentation-convention` ("diferido") → `registro: diferido | inmediato`, con `diferido` por defecto. También se corrige la plantilla de `CLAUDE.md` de `project-init`, que traía una "Regla de registro inmediato — NO NEGOCIABLE".
  - `project-init`: las plantillas de `SPEC.md`, `spec/` y `CLAUDE.md` nacen con `cerrados.md`, lista única con IDs y bloque de configuración; se retira `spec/historial.md` de las plantillas (ya estaba deprecado; la narrativa va a `brain/sesiones.md`).
  - Nuevas guías dentro de la skill `spec-driven-development`: `references/migracion-0.12.md` (nota de migración, incluido el caso de un `checkpoint` local propio y de un archivo de cerrados con otro nombre) y `references/normalizacion-spec.md` (cómo normalizar un `SPEC.md` degradado).
- **[Runtime Gemini v0.1.3]** Paridad con core 0.12.0 (`core_version` = 0.12.0): `06-documentation-convention` (ward/listeilor, aviso de colisión), `11-spec-driven-development` (configuración, regla de cierre, lista única, control de tamaño por líneas), `01-brain-kms`, plantillas `gemini-template` y `spec-folder-template`, y nueva `references/spec-migracion-0.12.md`. `install-gemini.sh` descarga la referencia nueva. Para actualizar, volver a correr el instalador.
- **[Core]** `docs/` y `README.md` actualizados a `ward`/`listeilor`, tope por líneas y `cerrados.md`. El tope por líneas retoma la regla original del autor (~1000 líneas), que la v0.10.1 había cambiado a ~15 KB. El `README.md` incorpora cómo **actualizar** el plugin (Claude Code) y el runtime (Gemini) en un proyecto que ya está en funcionamiento.

## 2026-09-29

### Fixed
- **[Runtime Claude Code v0.10.1]** `SPEC.md` crecía sin límite en proyectos reales (5 KB → 126 KB en dos meses en un proyecto consumidor). Causa raíz: las instrucciones decían *qué* actualizar pero no que había que **reemplazar en vez de acumular**, no ponían tope de tamaño ni decían adónde iban los ítems cerrados. Cada checkpoint agregaba bloques "Antes (fecha) — …" al header y filas "Sesión anterior" a la §2 sin borrar los anteriores; los `[x]` se quedaban en la §3; y el footer ("conteo de tests") se usaba como bitácora en proyectos sin tests. Cambios:
  - `spec-driven-development`: nuevas secciones "Árbitro de destino" (qué va en `SPEC.md` y qué no), "Reemplazar, no acumular" y "Tope de tamaño" (~15 KB, ninguna línea > 600 caracteres, chequeo con `wc -c` y `awk` antes del commit).
  - `commands/checkpoint.md`: el paso 3 pasa a reemplazar-no-acumular y se agrega un paso obligatorio de chequeo de tamaño antes del commit.
  - `documentation-convention`, `brain-adr`, `project-init` (`spec-md-template.md`, `claude-md-template.md`) y `CLAUDE.md` de este repo: alineados con la regla. El footer deja de pedir "conteo de tests" y pasa a "métricas clave del dominio (conteo de tests solo si el proyecto tiene tests)".
  - `spec-md-template.md`: el template abre con un comentario HTML con los límites, para que aparezca en todo `SPEC.md` nuevo.
- **[Runtime Gemini v0.1.1]** Misma corrección con paridad: `11-spec-driven-development.md` (nueva sección 3b), `06-documentation-convention.md`, `01-brain-kms.md` y `references/gemini-template.md`. `core_version` sube a `0.10.1`.

### Added
- **[Core]** `docs/principles.md`, `docs/decisions.md`, `docs/glossary.md` y `docs/conventions.md` — los últimos 4 archivos de `docs/` que seguían vacíos. Redactados a partir de las skills, los ADR y las convenciones que el repo ya aplicaba, sin contenido nuevo inventado. `decisions.md` explica cómo se gestionan las decisiones dentro de Brain KMS y se distingue de `brain.md`, que explica el sistema. El README los lista en su tabla de documentación.

### Changed
- **[Runtime Claude Code v0.11.0 / Runtime Gemini v0.1.2]** `TOASK.md` se mueve de `brain/TOASK.md` a la **raíz del proyecto**, junto a `SPEC.md` y `SHAME.md`: es un archivo operativo, no un registro de Brain KMS. `project-init` (ambos runtimes) lo crea ahora en la raíz. Actualizados `spec-driven-development`, `brain-kms`, `project-init`, `brain-adr-template.md` y los equivalentes de Gemini, más `docs/brain.md` y `docs/glossary.md`. Los proyectos existentes con `brain/TOASK.md` siguen siendo válidos, no hace falta moverlo.
- **[Core / Runtime Claude Code v0.11.0]** Se marca como ejecutada la decisión de retirar Superpowers y reemplazar sus skills por las 3 propias de `suplemento-core` (2026-09-01): los 2 ítems **S** de `TOASK.md` pasan a "Resueltas" y `spec/roadmap-skills.md` los pasa a "Hecho"/"Descartado". `code-simplicity` deja de hablar de Superpowers en su sección sobre YAGNI.
- **[Core]** `docs/spec.md` corregido: decía que `SPEC.md` no debería pasar de ~1000 líneas, lo que contradecía el tope de ~15 KB de ADR-006. `README.md` sube su versión de estado a v0.11.0.
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
