# Registro de sesiones

Hitos relevantes por sesión de trabajo. Las entradas más recientes van arriba.


## Sesión — 2026-09-11 (continuación 5) — Modo adopción en project-init de Gemini

**Contexto:** el usuario preguntó cómo manejar retomar, con Gemini + Antigravity IDE, un proyecto ya inicializado con Claude Code en la misma carpeta (`SPEC.md`/`brain/`/`CLAUDE.md` ya existentes) — un cambio real de agente e IDE, no solo de carpeta, así que "project-init" ya no aplicaría en modo "crear desde cero".

- **Hallazgo:** `runtimes/gemini-antigravity/skills/02-project-init.md` estaba completamente vacío (0 líneas) — la skill central para este escenario no tenía contenido. Verificado que las 12 skills restantes de Gemini sí tienen contenido (`wc -l` sobre todas).
- **ADR-005 (nuevo):** completa `02-project-init.md` portando el Paso 0 de detección de proyecto existente de Claude Code, agregando un **modo adopción** explícito: si `SPEC.md`/`brain/` ya existen y `GEMINI.md` no, la skill confirma con el usuario, adopta el contexto real (lee `SPEC.md`/`brain/` para poblar `GEMINI.md`, no plantilla en blanco) sin recrear nada, y pregunta si reutilizar el nombre de instancia ya asignado a Claude Code o asignar uno distinto.
- Se descartó crear un script de transición separado — `install-gemini.sh` ya no sobreescribe `GEMINI.md` existente; la lógica de adopción vive en la skill, no en el instalador.

### Archivos modificados
- runtimes/gemini-antigravity/skills/02-project-init.md (completado, antes vacío)
- brain/ADR-005-adopcion-de-proyecto-existente-en-runtime-gemini.md, brain/index.md, brain/sesiones.md
- SPEC.md

### Próximo
- (Pendientes heredados sin cambios: `docs/conventions.md`/`glossary.md`, destino de `docs/principles.md`/`decisions.md`, renombre Brain KMS en Claude Code, `brain/TOASK.md`.)

---

## Sesión — 2026-09-11 (continuación 4) — GEMINI-RUNTIME.md reescrito y aceptado

**Contexto:** el usuario reescribió `runtimes/gemini-antigravity/GEMINI-RUNTIME.md` completo (estructura más formal: target/compatibility/versión en encabezado, misión y principios del agente, mapa de arquitectura, protocolo de apertura de sesión, matriz de enrutamiento de skills, estrategia de git/changelog) y pidió aceptarlo.

- Documento ya alineado con lo decidido en la sesión: SemVer independiente por runtime, Changelog único con etiqueta de capa, Conventional Commits con scope.
- **Corregido antes de aceptar:** el árbol de archivos en §2 repetía el mismo error de nombres ya corregido en `install-gemini.sh` (`gitignore-template.md`, `geminiignore-template.md`, `spec-md-template.md`, `references/trackers/` no existen) — ajustado a los nombres reales.
- **Corregido antes de aceptar:** el encabezado fijaba `Runtime Target: Gemini 1.5 Pro / Ultra`, contradiciendo ADR-003 (que descartó atar el manifest a una versión de modelo específica). Cambiado a `Gemini (Antigravity IDE)`, sin versión.

### Archivos modificados
- runtimes/gemini-antigravity/GEMINI-RUNTIME.md
- brain/sesiones.md

### Próximo
- (Pendientes heredados sin cambios: `docs/conventions.md`/`glossary.md`, destino de `docs/principles.md`/`decisions.md`, renombre Brain KMS en Claude Code, `brain/TOASK.md`.)

---

## Sesión — 2026-09-11 (continuación 3) — Launcher de Gemini terminado, README reorganizado

**Contexto:** el usuario terminó `install-gemini.sh` (instalador de una línea, descarga el runtime a `.gemini/` sin clonar el repo) y trajo un borrador de sección de README con el comando de instalación. Pidió revisar y reorganizar `README.md` (272 líneas, desactualizado) moviendo contenido extenso a `docs/`, que tenía 8 de 10 archivos vacíos.

- **Bug encontrado y corregido en `install-gemini.sh`:** la lista `REFERENCES` pedía nombres de archivo que no existen en `skills/references/` (`gitignore-template.md`, `geminiignore-template.md`, `spec-md-template.md` en vez de `ignore-template.md`, `spec-folder-template.md`, `gemini-template.md`, `trackers-templates.md`) — el script habría fallado en cualquier instalación real (`curl -f`). Corregido antes de seguir.
- **ADR-004 (nuevo):** documenta la reorganización completa — README reducido a landing page (~65 líneas: TL;DR, instalación de ambos runtimes, índice a `docs/`, licencia); contenido movido y repartido en `docs/philosophy.md`, `docs/workflow.md`, `docs/spec.md`, `docs/plugins.md` (nuevos) y `docs/getting-started.md`, `docs/brain.md` (actualizados). Corrige también la nota `// EDIT:` obsoleta sobre Superpowers/claude-mem con el estado real (Superpowers retirado 2026-09-01).
- `docs/conventions.md` y `docs/glossary.md` quedan sin contenido — sin fuente clara en el README, no se inventó nada; pendiente explícito.
- `docs/principles.md` y `docs/decisions.md` quedan sin usar — su contenido esperado se fusionó en `philosophy.md` o no tenía fuente; pendiente evaluar si se fusionan formalmente o se retiran.
- A pedido del usuario, se agregó al final del README: "Hecho en Chile 🇨🇱, con mucho cariño, para todos los amigos y amigas de la sobreingeniería."

### Archivos modificados
- README.md (reescrito)
- docs/philosophy.md, docs/workflow.md, docs/spec.md, docs/plugins.md (nuevos)
- docs/getting-started.md, docs/brain.md (actualizados)
- install-gemini.sh (bug corregido)
- brain/ADR-004-readme-breve-y-docs-como-fuente-detallada.md, brain/index.md, brain/sesiones.md
- SPEC.md

### Próximo
- Completar `docs/conventions.md` y `docs/glossary.md`.
- Decidir destino de `docs/principles.md` y `docs/decisions.md`.
- (Pendientes heredados sin cambios: renombre Brain KMS en Claude Code, `brain/TOASK.md`.)

---

## Sesión — 2026-09-11 — v0.10.0: harness multi-runtime + Brain KMS

**Contexto:** formalización del hito iniciado en la sesión anterior (conversión completa de las 13 skills a `runtimes/gemini-antigravity/`). El usuario pidió registrar el hito, el rebautizo de `brain/` como Brain KMS (nombre sugerido por Gemini), y documentar la decisión de mantener `plugins/suplemento-core/` (Claude Code) en su ubicación actual en vez de reorganizarlo bajo `runtimes/`. A mitad de sesión el usuario corrigió el número de versión propuesto inicialmente (2.0.0 → 0.10.0, semver recién adoptado ~1.5 semanas atrás, sin serie previa real) y pidió reemplazar el eufemismo "brújula" por el término técnico "harness".

- **ADR-001 (nuevo):** primer ADR del proyecto — documenta la decisión multi-runtime, la no-reorganización de Claude Code, el rebautizo a Brain KMS (adoptado en Gemini, pendiente en Claude Code), la fijación de versión `0.10.0` (no `2.0.0`) en `plugin.json`, el versionado independiente por capa (Core/Claude Code/Gemini), y tres hallazgos: `docs/` con 8 de 10 archivos vacíos (sesión de chat no pasada en limpio); el cambio de Claude Code a v5 hace ~2 semanas sin registro de versión propio en su momento; y su causa raíz — al retirar Superpowers, el usuario detectó que Superpowers y `claude-mem` generaban consumo excesivo de tokens porque v5 espera recibir el contexto completo de la tarea de una vez (no una secuencia de tareas chicas), lo que llevaba a `claude-mem` a inyectar automáticamente todo el contexto disponible (incluido `SPEC.md` completo) en cada sesión.
- **`runtimes/README.md`** — documenta la convención: Claude Code queda en `plugins/`, `runtimes/` es para otros agentes.
- **`runtimes/gemini-antigravity/runtime.json`** (nuevo) — versiona el runtime de Gemini de forma independiente (`0.1.0`), con campo `core_version` apuntando a qué versión del Core implementa.
- **`plugin.json`** — primera vez que fija `"version"` (`0.10.0`), antes solo hash de commit; descripción usa "harness".
- **`marketplace.json`** y **`CHANGELOG.md`** de `suplemento-core` — actualizados con "harness", multi-runtime, Brain KMS, y nota sobre el punto de partida de semver.
- **`SPEC.md`** — pendiente de re-sincronizar con 0.10.0 (ver Próximo).

### Archivos modificados
- runtimes/README.md, runtimes/gemini-antigravity/runtime.json
- plugins/suplemento-core/.claude-plugin/plugin.json
- plugins/suplemento-core/CHANGELOG.md
- .claude-plugin/marketplace.json
- brain/ADR-001-harness-multi-runtime-y-brain-kms.md, brain/index.md, brain/sesiones.md

### Próximo
- Evaluar propagar el renombre Brain KMS a `plugins/suplemento-core/skills/brain-adr/` (Claude Code).
- Reconstruir contenido de `docs/` (8 archivos vacíos) cuando el usuario recupere el material de la sesión de chat no traspasada.
- Terminar el launcher de Gemini (en curso por el usuario, fuera de esta sesión de sincronización).
- Revisar `brain/TOASK.md` cuando haya tiempo para las preguntas tipo S.

---

## Sesión — 2026-09-11 (continuación) — CHANGELOG.md único en la raíz

**Contexto:** el usuario consultó a Gemini sobre cómo estructurar el changelog en escenario multi-runtime. Gemini recomendó un único `CHANGELOG.md` en la raíz con entradas etiquetadas por runtime, respaldado por Conventional Commits con scope — pero asumía versionado SemVer lockstep (una sola versión de proyecto compartida), lo que contradice el versionado independiente por capa recién decidido en ADR-001.

- **ADR-002 (nuevo):** adopta el CHANGELOG único en la raíz y Conventional Commits con scope por runtime; **descarta explícitamente** la parte lockstep del consejo de Gemini — se preserva el versionado independiente por capa de ADR-001.
- **`CHANGELOG.md`** (raíz, nuevo) — reemplaza a `plugins/suplemento-core/CHANGELOG.md` (eliminado), migra el historial completo y reestructura la entrada de hoy con etiquetas `[Core]` / `[Runtime Claude Code vX.Y.Z]` / `[Runtime Gemini vX.Y.Z]`.
- **`SPEC.md`** — fila §5 sobre ubicación del changelog actualizada (obsoleta, reemplazada por ADR-002); tabla §1 agrega `CHANGELOG.md` como fuente de la raíz.

### Archivos modificados
- CHANGELOG.md (nuevo, raíz)
- plugins/suplemento-core/CHANGELOG.md (eliminado)
- brain/ADR-002-changelog-unico-en-la-raiz.md, brain/index.md, brain/sesiones.md
- SPEC.md

### Próximo
- Adoptar prefijo de scope por runtime en commits futuros donde aplique (`feat(runtime-gemini)`, `fix(core)`), sin reescribir historial pasado.
- (Pendientes heredados de la sesión anterior, sin cambios: renombre Brain KMS en Claude Code, reconstrucción de `docs/`, launcher de Gemini, `brain/TOASK.md`.)

---

## Sesión — 2026-09-11 (continuación 2) — Licencia MIT y ajuste de runtime.json

**Contexto:** el usuario está armando el launcher de Gemini. Gemini le propuso un `runtime.json` con campos nuevos (`license: MIT`, `author: "Suplemento Estrella"`, `target_model`, `architecture`). El usuario pidió revisar si calzaba con lo ya decidido antes de aceptarlo.

- **ADR-003 (nuevo):** adopta licencia MIT para todo el repo (antes no declarada en ningún lado); corrige `author` de `runtime.json` a la persona real (coherente con `plugin.json`); incorpora el bloque `architecture` de la propuesta de Gemini (aporta valor real); descarta `target_model` (ata el manifest a una versión de modelo que se desactualiza sola).
- **`LICENSE`** (nuevo, raíz) — texto MIT, copyright Orlando (OrcaCl) 2026.
- **`plugin.json`** y **`runtime.json`** — ambos declaran `"license": "MIT"` por igual.
- **`runtime.json`** (Gemini) — agrega `display_name` y `architecture`; corrige `author`; sin `target_model`.

### Archivos modificados
- LICENSE (nuevo)
- plugins/suplemento-core/.claude-plugin/plugin.json
- runtimes/gemini-antigravity/runtime.json
- brain/ADR-003-licencia-mit-y-estructura-runtime-json.md, brain/index.md, brain/sesiones.md
- SPEC.md, CHANGELOG.md

### Próximo
- El usuario continúa armando el launcher de Gemini; sincronizar de nuevo cuando lo tenga.

---

## Sesión — 2026-09-10 — Auditoría y estandarización de 13 Skills (Gemini Runtime)

**Contexto:** Sincronización e integración de la metodología Suplemento Estrella + Brain KMS para el runtime de Gemini en Antigravity IDE.

- **Skill 01 (brain-kms):** Mapeo explícito a plantillas base en `skills/references/` (lectura bajo demanda).
- **Skill 02 (project-init):** Onboarding con regla del par `.gitignore` + `.geminiignore`, doble protección de `brain/files/secure/` y nombrado humano.
- **Skills de Código y Ejecución (03 - 10):** Integración de `code-simplicity`, `depuracion-sistematica` (límite 3 fixes), `disenar-antes-de-implementar` (compuerta dura), `documentation-convention` (checkpoints diferidos), `frontend-conventions` (puente `data-*`), `planificacion-por-fases` (cero placeholders), `raw-data-audit-trail` y `sequential-mode` (tolerancia cero a subagentes autónomos).
- **Skills de Flujo Diario y Stack (11 - 13):** Estandarización de `spec-driven-development` (rutas de enrutamiento sin emojis), `tdd-workflow` (alcance quirúrgico de tests) y `tooling-roles` (matriz agnóstica de stack).
- **Catálogo:** Finalizada la revisión de las 13 skills principales del sistema.

### Archivos modificados
- `skills/01-brain-kms.md` hasta `skills/13-tooling-roles.md`
- `skills/references/*` (Templates estáticos)

### Próximo
- Construir el archivo consolidado `GEMINI-RUNTIME.md` (rework unificado) al retomar en la siguiente sesión.
---

## Sesión — 2026-09-09 — Nombre humano para la instancia en project-init

**Contexto:** el usuario creó `brain/INT-000` documentando por qué le importa darle un nombre humano a la instancia de Code (humanizar y simplificar el trabajo entre los dos miembros del equipo). Pidió incorporar esa práctica al proceso de `project-init` para que todo proyecto nuevo bajo la metodología la ofrezca desde el inicio.

**Hitos:**
- **`project-init/SKILL.md`** — nuevo **Paso 3a** que ofrece al usuario 4 opciones para nombrar la instancia:
  1. Code elige su propio nombre (nombres humanos o referencia popular; nunca grosero/soez).
  2. El usuario asigna el nombre.
  3. Mantener el default: **Tomás**.
  4. Sin nombre — seguir con "Claude Code" / "Code" por omisión.
  El nombre elegido se registra en `CLAUDE.md → ## Contexto del proyecto`. Se agregó el punto 8 al checklist del Paso 3.
- **`references/claude-md-template.md`** — placeholder de la línea del nombre en `## Contexto del proyecto` + nota de uso (origen en Paso 3a, default Tomás, qué hacer con la opción 4).
- **`brain/index.md`** — INT-000 agregado a la tabla de registros (antes vacía).
- **`brain/INT-000...md`** — corregida la sección `## Commit`: apuntaba a una entrada "2026-08-19/20" de `sesiones.md` que nunca existió; ahora apunta a esta sesión. También se ajustó la nota de alcance que referenciaba un INT-001 inexistente.

### Archivos modificados
- plugins/suplemento-core/skills/project-init/SKILL.md
- plugins/suplemento-core/skills/project-init/references/claude-md-template.md
- brain/INT-000-nombre-humano-para-la-instancia.md
- brain/index.md, brain/sesiones.md, SPEC.md

### Próximo
- Revisar `brain/TOASK.md` cuando haya tiempo para las preguntas tipo S.

---

## Sesión — 4 ago 2026 — Inicialización meta de SPEC.md + brain/

**Contexto:** el usuario pidió iniciar el proyecto; se detectó que este repo es el constructor del plugin (no un consumidor), por lo que se aplicó `project-init` en modo uso meta.

- **Estructura creada:** `SPEC.md`, `CLAUDE.md`, `.claudeignore`, `spec/` (completado, datos, historial retirado con easter-egg, roadmap-skills), `brain/` (index, sesiones, TOASK migrado desde la raíz, trackers/, files/).
- **CHANGELOG.md** se ubicó dentro de `plugins/suplemento-core/`, no en la raíz del repo, porque el versionado real es del plugin, no del repo constructor.

### Archivos modificados
- spec/*, brain/*, SPEC.md, CLAUDE.md, .claudeignore, .gitignore, plugins/suplemento-core/CHANGELOG.md

### Próximo
- Completar la Sección 4 (reglas críticas) de SPEC.md/CLAUDE.md a medida que surjan.

---
