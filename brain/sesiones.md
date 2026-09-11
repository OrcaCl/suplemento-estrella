# Registro de sesiones

Hitos relevantes por sesión de trabajo. Las entradas más recientes van arriba.


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
- Re-sincronizar `SPEC.md` con la versión corregida (0.10.0, no 2.0.0) y agregar el hallazgo de `docs/` incompleta a los pendientes.
- Evaluar propagar el renombre Brain KMS a `plugins/suplemento-core/skills/brain-adr/` (Claude Code).
- Reconstruir contenido de `docs/` (8 archivos vacíos) cuando el usuario recupere el material de la sesión de chat no traspasada.
- Terminar el launcher de Gemini (en curso por el usuario, fuera de esta sesión de sincronización).
- Revisar `brain/TOASK.md` cuando haya tiempo para las preguntas tipo S.

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
