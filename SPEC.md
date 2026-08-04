# Suplemento Estrella (repo constructor del plugin)

## Documento de contexto y descubrimientos

**Versión:** 0.1
**Última actualización:** 4 ago 2026

---

## 1. Problema y objetivo

Suplemento Estrella es una metodología de desarrollo asistido por agentes de código, distribuida como marketplace/plugin instalable de Claude Code. Este repo es el **constructor** de esa metodología — no un proyecto que la consume, sino el que la produce y versiona.

| Fuente | Qué entrega |
|---|---|
| `.claude-plugin/marketplace.json` | Definición del marketplace instalable |
| `plugins/suplemento-core/` | Skills, comandos y convenciones distribuidas a proyectos cliente |
| `docs/` | Documentación conceptual dirigida a quien instala y usa la metodología |

**Objetivo:** mantener la metodología coherente, documentar el porqué de sus propias decisiones de diseño, y que el plugin siga siendo instalable y funcional en proyectos reales.

---

## 2. Estado actual

| Métrica | Valor |
|---|---|
| Skills en `suplemento-core` | Ver `plugins/suplemento-core/skills/` |
| Marketplace | Registrado y `suplemento-core` instalado en el propio Claude Code del autor |
| Última sesión | 4 ago 2026 — **Inicialización meta de SPEC.md + brain/**: se detectó que este repo requería `project-init` en modo uso meta (constructor de plugin, no consumidor) |

---

## 3. Pendientes activos

### 🗓 Próxima sesión

**Prioridad 0 — Continuidad**

- [ ] Revisar `brain/TOASK.md` cuando haya tiempo disponible para las preguntas tipo **S**

---

## 4. Reglas críticas — NO NEGOCIABLE

> _Sin reglas críticas registradas todavía. Agregar aquí la primera vez que una decisión de este tipo se tome._

---

## 5. Decisiones que el agente debe recordar siempre

| Decisión | Detalle |
|---|---|
| Este repo usa `project-init` en modo meta | `brain/` documenta decisiones de la metodología en sí, no código de negocio de un proyecto cliente |
| Versionado del plugin por hash de commit | `plugin.json` no fija versión — habilita seguimiento en vivo durante el desarrollo |
| `CHANGELOG.md` vive en `plugins/suplemento-core/` | No en la raíz del repo — el versionado real es del plugin distribuido, no del repo constructor |

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
| Plugin core | `plugins/suplemento-core/` | Instalado y activo |
| Skill project-init | `plugins/suplemento-core/skills/project-init/` | Vigente — usada para inicializar este mismo repo |

---

## 8. Referencias a spec/

| Archivo | Contenido |
|---|---|
| [`spec/roadmap-skills.md`](spec/roadmap-skills.md) | Backlog vivo de la metodología — lo que el autor necesita + lo que el agente sugiere |
| [`spec/datos.md`](spec/datos.md) | Convenciones, diccionarios, anexos |
| [`spec/historial.md`](spec/historial.md) | Retirado — ver `brain/sesiones.md` |
| [`spec/completado.md`](spec/completado.md) | Checklist plano de tareas completadas |

---

_SPEC.md  — v0.1._
