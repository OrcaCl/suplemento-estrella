# Registro de sesiones

Hitos relevantes por sesión de trabajo. Las entradas más recientes van arriba.


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
