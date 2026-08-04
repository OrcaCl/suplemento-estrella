## Confirmación de contexto

Al iniciar cada sesión, después de leer SPEC.md y brain/index.md, confirmar con este mensaje exacto en consola antes de cualquier acción:

✅ Contexto cargado — SPEC.md v[VERSION]
| Próximo paso: [PRIMER_ITEM_PENDIENTE]

---

## Contexto del proyecto

Este repo es el constructor de la metodología Suplemento Estrella — un plugin/marketplace de Claude Code, no un proyecto que la consume. `SPEC.md` y `brain/` documentan las decisiones de diseño de la metodología en sí.

---

## Stack tecnológico

| Componente | Tecnología | Versión |
|---|---|---|
| Distribución | Claude Code plugin marketplace | — |
| Formato | Markdown (skills, docs) + JSON (manifests) | — |
| Control de versiones | Git + GitHub (`OrcaCl/suplemento-estrella`) | — |

Estructuras principales: `plugins/suplemento-core/skills/`, `plugins/suplemento-core/commands/`, `.claude-plugin/marketplace.json`.

---

## Regla(s) crítica(s) — NO NEGOCIABLE

> _Sin reglas críticas registradas todavía. Se agregan aquí en cuanto una decisión de este tipo se identifique — no esperar a que el proyecto crezca para empezar a documentarlas._

---

## Modo de trabajo

Trabajar siempre en modo secuencial — una tarea a la vez, **cero subagentes por defecto**. Cualquier paralelismo requiere que Code se lo pida explícitamente al humano y este lo apruebe para esa tarea puntual — nunca una decisión autónoma de Code (ver skill `sequential-mode`).

---

## Convención de documentación

Commits de código con normalidad según avanza el trabajo. El registro de `brain/` y `SPEC.md` queda diferido hasta un checkpoint explícito (invocado por el humano) o hasta el cierre de sesión, que es obligatorio (ver skill `documentation-convention`).

- `brain/sesiones.md` — hitos y descubrimientos de la sesión
- `SPEC.md` — marcar ítems completados, actualizar footer con estado
- `brain/ADR-*.md` / `INT-*.md` / `NOC-*.md` / `DEP-*.md` / `REF*-*.md` — si se tomó una decisión de ese tipo

**No esperar instrucción explícita al cerrar sesión** — proponer qué registrar.

---

## Plugins

Este repo instala y usa su propio plugin (`suplemento-core`) además de Superpowers y claude-mem. Ver `docs/getting-started.md` para el ecosistema recomendado.
