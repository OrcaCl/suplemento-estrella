# Suplemento Estrella (repo constructor del plugin)

## Documento de contexto y descubrimientos

**Versión:** 0.10.0
**Última actualización:** 2026-09-11

---

## 1. Problema y objetivo

Suplemento Estrella es un **harness** de desarrollo asistido por agentes de código — desde v0.10.0, multi-runtime — distribuido como marketplace/plugin instalable de Claude Code y, en paralelo, como adaptaciones para otros agentes. Este repo es el **constructor** de ese harness — no un proyecto que lo consume, sino el que lo produce y versiona.

| Fuente | Qué entrega |
|---|---|
| `.claude-plugin/marketplace.json` | Definición del marketplace instalable (Claude Code) |
| `plugins/suplemento-core/` | Skills, comandos y convenciones — runtime de referencia (Claude Code) |
| `runtimes/` | Adaptaciones del mismo harness a otros agentes (Google Gemini en `gemini-antigravity/`, y los que vengan) |
| `docs/` | Documentación conceptual dirigida a quien instala y usa el harness — **incompleta**: ver pendiente en sección 3 |

**Objetivo:** mantener el harness coherente, documentar el porqué de sus propias decisiones de diseño, y que el plugin siga siendo instalable y funcional en proyectos reales.

---

## 2. Estado actual

| Métrica | Valor |
|---|---|
| Skills en `suplemento-core` (Claude Code) | Ver `plugins/suplemento-core/skills/` |
| Runtimes adicionales | `runtimes/gemini-antigravity/` — 13 skills traducidas para Google Gemini (Antigravity) |
| Marketplace | Registrado y `suplemento-core` instalado en el propio Claude Code del autor |
| Versión del plugin `suplemento-core` (Claude Code) | `0.10.0` (fijada en `plugin.json` — primera vez que se fija semver; antes solo hash de commit) |
| Versión del runtime Gemini | `0.1.0` (`runtimes/gemini-antigravity/runtime.json`, nuevo — versiona independiente del plugin de Claude Code, con campo `core_version` de referencia) |
| Última sesión | 2026-09-11 — **v0.10.0: harness multi-runtime**. Primer runtime adicional completado (Gemini/Antigravity). Sistema `brain/` rebautizado como **Brain KMS** (Brain Knowledge Management System) — adoptado en Gemini, pendiente propagar a Claude Code. Terminología "brújula" → "harness" |

---

## 3. Pendientes activos

### 🗓 Próxima sesión

**Prioridad 0 — Continuidad**

- [ ] Revisar `brain/TOASK.md` cuando haya tiempo disponible para las preguntas tipo **S**
- [ ] Evaluar propagar el rebautizo Brain KMS a Claude Code (`plugins/suplemento-core/skills/brain-adr/` → `brain-kms/`), incluyendo referencias en otras skills y en `CLAUDE.md` del proyecto
- [ ] Reconstruir contenido de `docs/` — 8 de 10 archivos están vacíos (`workflow.md`, `principles.md`, `philosophy.md`, `plugins.md`, `decisions.md`, `conventions.md`, `spec.md`, `glossary.md`); quedaron de una sesión de chat con otra instancia de Claude que no se pasó en limpio. Retomar cuando el autor recupere ese material
- [ ] Terminar el launcher de Gemini (en curso por el autor)

---

## 4. Reglas críticas — NO NEGOCIABLE

> _Sin reglas críticas registradas todavía. Agregar aquí la primera vez que una decisión de este tipo se tome._

---

## 5. Decisiones que el agente debe recordar siempre

| Decisión | Detalle |
|---|---|
| Este repo usa `project-init` en modo meta | `brain/` documenta decisiones de la metodología en sí, no código de negocio de un proyecto cliente |
| La instancia de Code en este proyecto se llama Tomás | Convención de comunicación (INT-000), no regla técnica. `project-init` ofrece esta elección a todo proyecto nuevo en su Paso 3a |
| Versionado por capas, independiente por runtime, desde 2026-09-11 | Core (`SPEC.md`) / Claude Code (`plugin.json`) / Gemini (`runtime.json`) versionan cada uno por su cuenta; cada runtime referencia `core_version`. Antes: solo hash de commit. Ver ADR-001 en `brain/` |
| Punto de partida de semver: `0.10.0`, no `1.0.0` ni `2.0.0` | Semver se adoptó ~1.5 semanas antes de este hito, sin serie 0.x/1.x previa real; `0.10.0` refleja pre-1.0/desarrollo activo. No es cálculo retroactivo estricto — ver ADR-001 |
| `CHANGELOG.md` vive en `plugins/suplemento-core/` | No en la raíz del repo — el versionado real es del plugin distribuido, no del repo constructor |
| `plugins/suplemento-core/` es el runtime de referencia (Claude Code); otros agentes van en `runtimes/` | Decisión explícita: no se reorganizó Claude Code por simetría — evita romper la instalación activa y la ruta que espera `marketplace.json` |
| Sistema `brain/` se llama formalmente **Brain KMS** (Brain Knowledge Management System) | Adoptado en el runtime de Gemini (`01-brain-kms.md`); pendiente evaluar propagar el renombre a `plugins/suplemento-core/skills/brain-adr/` |
| Terminología: "harness", no "brújula" | El eufemismo quedó corto para comunicar qué es la herramienta; se usa el término técnico en documentación de cara al usuario |

---

## 6. Stack tecnológico

| Componente | Tecnología | Versión |
|---|---|---|
| Formato | Markdown (skills, docs) + JSON (manifests de plugin) | — |
| Distribución | Claude Code plugin marketplace | — |
| Control de versiones | Git + GitHub (`OrcaCl/suplemento-estrella`) | — |

---

## 7. Componentes / módulos implementados

| Componente | Módulo | Estado |
|---|---|---|
| Marketplace | `.claude-plugin/marketplace.json` | Registrado |
| Plugin core (Claude Code) | `plugins/suplemento-core/` | Instalado y activo — v0.10.0 |
| Skill project-init | `plugins/suplemento-core/skills/project-init/` | Vigente — usada para inicializar este mismo repo |
| Runtime Gemini (Antigravity) | `runtimes/gemini-antigravity/` | Vigente — 13 skills traducidas, incluye `01-brain-kms.md` |

---

## 8. Referencias a spec/

| Archivo | Contenido |
|---|---|
| [`spec/roadmap-skills.md`](spec/roadmap-skills.md) | Backlog vivo de la metodología — lo que el autor necesita + lo que el agente sugiere |
| [`spec/datos.md`](spec/datos.md) | Convenciones, diccionarios, anexos |
| [`spec/historial.md`](spec/historial.md) | Retirado — ver `brain/sesiones.md` |
| [`spec/completado.md`](spec/completado.md) | Checklist plano de tareas completadas |

---

_SPEC.md  — v0.10.0. Última actualización: 2026-09-11._
