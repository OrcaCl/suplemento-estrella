# Brain — Índice de decisiones y contexto acumulado

Este directorio complementa el `SPEC.md`. Documenta el **por qué** de las decisiones sobre la metodología Suplemento Estrella en sí — no código de negocio de un proyecto cliente — y el historial de sesiones de trabajo.

---

## Registros

| ID | Título | Categoría | Estado |
|---|---|---|---|
| [INT-000](reports/INT-000-nombre-humano-para-la-instancia.md) | Adoptar un nombre humano para la instancia de Code en el proyecto | INT | Vigente |
| [INT-001](reports/INT-001-checkpoint-spec-reemplazar-no-acumular.md) | Pedido de corrección: checkpoint y SPEC.md reemplazar, no acumular (origen: proyecto "paciente cero") | INT | Implementado (ver ADR-008) |
| [ADR-001](reports/ADR-001-harness-multi-runtime-y-brain-kms.md) | Harness multi-runtime (v0.10.0) y rebautizo de brain/ como Brain KMS | ADR | Vigente |
| [ADR-002](reports/ADR-002-changelog-unico-en-la-raiz.md) | CHANGELOG.md único en la raíz, versionado por capa preservado | ADR | Vigente |
| [ADR-003](reports/ADR-003-licencia-mit-y-estructura-runtime-json.md) | Licencia MIT del repo y estructura de runtime.json (Gemini) | ADR | Vigente |
| [ADR-004](reports/ADR-004-readme-breve-y-docs-como-fuente-detallada.md) | README.md breve, docs/ como fuente detallada; instalador de Gemini corregido | ADR | Vigente |
| [ADR-005](reports/ADR-005-adopcion-de-proyecto-existente-en-runtime-gemini.md) | Modo adopción en project-init de Gemini para proyectos ya iniciados con otro agente | ADR | Vigente |
| [ADR-006](reports/ADR-006-spec-md-se-reemplaza-no-se-acumula.md) | SPEC.md se reemplaza, no se acumula: árbitro de destino y tope de tamaño | ADR | Vigente |
| [ADR-007](reports/ADR-007-toask-en-la-raiz-del-proyecto.md) | TOASK.md vive en la raíz del proyecto, no dentro de brain/ | ADR | Vigente |
| [ADR-008](reports/ADR-008-ward-listeilor-y-spec-con-tope-por-lineas.md) | ward y listeilor reemplazan a checkpoint; SPEC.md con tope por líneas y cerrados ordenados por ID | ADR | Vigente |
| [ADR-009](reports/ADR-009-code-comment-convention-tercera-capa.md) | `code-comment-convention`: el código fuente como tercera capa de conocimiento | ADR | Vigente |
| [ADR-010](reports/ADR-010-keepit-reemplaza-a-listeilor.md) | `keepit` reemplaza a `listeilor` como comando de cierre de sesión (alias deprecado) | ADR | Vigente |
| [ADR-011](reports/ADR-011-tamano-de-spec-organico-solo-avisos.md) | Tamaño de `SPEC.md`: criterio orgánico, solo avisos (reemplaza el tope duro de ADR-006/008) | ADR | Vigente |
| [ADR-012](reports/ADR-012-registro-por-umbral.md) | Registro de `brain/` y `SPEC.md` por umbral: Code registra al terminar una tarea con conocimiento nuevo (reemplaza "Code nunca decide") | ADR | Vigente |
| [ADR-013](reports/ADR-013-comando-housekeeping.md) | Comando `housekeeping`: lint de documentación con informe y aprobación | ADR | Vigente |
| [ADR-014](reports/ADR-014-skill-seguridad-por-diseno.md) | Skill `seguridad-por-diseno`: guía de seguridad por tipo de cambio (OWASP, ASVS, ASI, STRIDE, SSDF) | ADR | Vigente |
| [ADR-015](reports/ADR-015-modern-web-guidance-como-plugin-no-vendorizado.md) | Modern Web Guidance: plugin del ecosistema, no vendorizado | ADR | Reemplazada por ADR-021 |
| [ADR-016](reports/ADR-016-plugins-de-terceros-sin-actualizacion-automatica.md) | Plugins de terceros sin actualización automática por defecto; `ketchup` revisa | ADR | Vigente |
| [ADR-017](reports/ADR-017-runtime-gemini-congelado.md) | Runtime Gemini congelado: sin mantenimiento ni paridad con el núcleo | ADR | Reemplazado por DEP-002 |
| [ADR-018](reports/ADR-018-reglas-deny-en-vez-de-claudeignore.md) | Reglas `deny` en `.claude/settings.json` en vez de `.claudeignore` (que no tiene efecto) | ADR | Vigente |
| [ADR-019](reports/ADR-019-boletines-en-brain-reports.md) | Los boletines viven en `brain/reports/`; la raíz de `brain/` solo conserva `index.md` y `sesiones.md` | ADR | Vigente |
| [ADR-020](reports/ADR-020-frontend-conventions-capas-y-plataforma-moderna.md) | `frontend-conventions`: estilos con parcial y `@layer`, BEM solo para nombres, plataforma web moderna | ADR | Vigente |
| [ADR-021](reports/ADR-021-guias-de-frontend-propias-sin-plugin-externo.md) | Guías de frontend propias, sin depender del plugin Modern Web Guidance; atribución Apache-2.0 | ADR | Vigente |
| [DEP-001](reports/DEP-001-retiro-de-checkpoint-y-listeilor.md) | Retiro de los comandos `checkpoint` y `listeilor` (0.15.0) | DEP | Vigente |
| [DEP-002](reports/DEP-002-retiro-del-runtime-gemini.md) | Retiro del runtime Gemini (0.16.0), con respaldo y etiqueta | DEP | Vigente |
| [NOC-001](reports/NOC-001-claude-mem-presion-comercial-y-captura-global.md) | claude-mem: presión hacia el plan Pro y captura global de proyectos | NOC | Monitoreo activo |

---

## Registro de sesiones

Ver [sesiones.md](sesiones.md) para el historial completo con hitos y descubrimientos.

---

## Documentos de referencia externos

Ver carpeta [files/](files/) para documentos de referencia externos.
