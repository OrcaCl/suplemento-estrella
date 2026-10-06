# Suplemento Estrella (repo constructor del plugin)

## Documento de contexto y descubrimientos

<!-- LÍMITES DE ESTE ARCHIVO (ADR-006, ADR-008): ≤ 1000 líneas, ninguna línea > 600 caracteres. REEMPLAZAR, no acumular.
     Narrativa → brain/sesiones.md · cerrados → spec/cerrados.md (ID original, ordenado por ID) · header = solo fecha · "Última sesión" = 1 fila ≤ 400 car. · footer = 1 línea ≤ 300 car.
     Pendientes: SOLO en §3. Antes de commitear: revisar líneas (≤ 1000) y que ninguna supere 600 caracteres (lista en la skill spec-driven-development). -->

**Versión:** 0.15.0
**Última actualización:** 2026-10-06

---

## 1. Problema y objetivo

Suplemento Estrella es un **harness** de desarrollo asistido por agentes de código — desde v0.10.0, multi-runtime — distribuido como marketplace/plugin instalable de Claude Code y, en paralelo, como adaptaciones para otros agentes. Este repo es el **constructor** de ese harness — no un proyecto que lo consume, sino el que lo produce y versiona.

| Fuente | Qué entrega |
|---|---|
| `.claude-plugin/marketplace.json` | Definición del marketplace instalable (Claude Code) |
| `plugins/suplemento-core/` | Skills, comandos y convenciones — runtime de referencia (Claude Code) |
| `runtimes/` | Adaptaciones del mismo harness a otros agentes (Google Gemini en `gemini-antigravity/`, y los que vengan) |
| `CHANGELOG.md` (raíz) | Registro único de hitos de todas las capas (Core + runtimes), versionado independiente por capa — ver ADR-002 |
| `LICENSE` (raíz) | MIT — ver ADR-003 |
| `docs/` | Documentación conceptual dirigida a quien instala y usa el harness — completa (`principles`, `decisions`, `glossary`, `conventions` incluidos) |

**Objetivo:** mantener el harness coherente, documentar el porqué de sus propias decisiones de diseño, y que el plugin siga siendo instalable y funcional en proyectos reales.

---

## 2. Estado actual

| Métrica | Valor |
|---|---|
| Skills en `suplemento-core` (Claude Code) | Ver `plugins/suplemento-core/skills/` |
| Runtimes adicionales | `runtimes/gemini-antigravity/` — 14 skills traducidas para Google Gemini (Antigravity) |
| Marketplace | Registrado y `suplemento-core` instalado en el propio Claude Code del autor |
| Versión del plugin `suplemento-core` (Claude Code) | `0.15.0` (fijada en `plugin.json`; semver desde 0.10.0, antes solo hash de commit) |
| Versión del runtime Gemini | `0.1.6` (`runtimes/gemini-antigravity/runtime.json` — versiona independiente del plugin, con campo `core_version` de referencia = `0.15.0`) |
| Última sesión | 2026-10-06 — **v0.15.0: `listeilor` pasa a `keepit` (ADR-010) y se retiran los comandos `checkpoint` y `listeilor` sin período de transición (DEP-001; cambio incompatible).** Runtime Gemini 0.1.6 en paridad. Ítems 2 y 8 cerrados |

---

## 3. Pendientes activos

> Lista única: los ítems abiertos existen **solo aquí**. Un ítem conserva su ID hasta cerrarse y el ID no se reutiliza. Al cerrarlo: borrar la fila → insertarla en `spec/cerrados.md` con su mismo ID + fecha + evidencia, en su posición por ID → agregar el ID a "Cerrados".

**Alta**

- _(vacío)_

**Media**

- [ ] **3** — Observar si el control de tamaño sin script basta en uso real; si `SPEC.md` vuelve a degradarse, reabrir la decisión del script (ADR-008)
- [ ] **6** — Probar la oferta de `code-comment-convention` (paso 0a de `ward`/`keepit`) en un proyecto real ya instalado: que se ofrezca una sola vez y que respete el rechazo (ADR-009); puede hacerse junto con el ítem 2

**Baja / Externo**

- [ ] **5** — `docs/getting-started.md` dice que `project-init` prepara "una estructura simple o una completa según el tamaño", pero hoy crea siempre la estructura completa: corregir el texto
- [ ] **7** — Runtime Gemini: `06-documentation-convention.md` manda a `keepit` a ejecutar "los pasos 1 a 7" de `ward`, que ahora tiene los pasos 0 a 8 y un paso 0a nuevo; revisar si el desfase es intencional

Cerrados: 1, 2, 4, 8 _(detalle en `spec/cerrados.md`)_

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
| `CHANGELOG.md` vive en la raíz del repo (único, todas las capas) | Antes vivía en `plugins/suplemento-core/` — decisión obsoleta y reemplazada por ADR-002. Cada entrada cita la versión de su propia capa; el versionado en sí sigue siendo independiente por capa, no lockstep |
| Licencia del repo: MIT | `LICENSE` en la raíz, declarada en `plugin.json` y `runtime.json` (Gemini) por igual. Ver ADR-003 |
| `plugins/suplemento-core/` es el runtime de referencia (Claude Code); otros agentes van en `runtimes/` | Decisión explícita: no se reorganizó Claude Code por simetría — evita romper la instalación activa y la ruta que espera `marketplace.json` |
| Sistema `brain/` se llama formalmente **Brain KMS** (Brain Knowledge Management System) | Adoptado en ambos runtimes: `01-brain-kms.md` (Gemini) y skill `brain-kms` (Claude Code, desde v0.11.0). Ver ADR-001 |
| `SPEC.md` se reemplaza, no se acumula; tope 1000 líneas | Narrativa → `brain/sesiones.md`, cerrados → `spec/cerrados.md`, "Última sesión" = 1 fila que se sobrescribe. Se controla al leer y antes de cada commit; el plugin no incluye scripts. Ver ADR-006 y ADR-008 |
| `ward` guarda (commit local, sin push); `keepit` cierra sesión (commit + push) | Reemplazan a `checkpoint` (deprecado en 0.12.0). `keepit` se llamó `listeilor` hasta 0.13 (ADR-010); `checkpoint` y `listeilor` fueron retirados en 0.15.0 (DEP-001). Un comando local con el mismo nombre tapa al del plugin: revisar `.claude/commands/`. Ver ADR-008 |
| `spec/cerrados.md`: ID original del pendiente, ordenado por ID | Nombre fijo; reemplaza a `spec/completado.md` (deprecado, se conserva). Cerrar por "ya estaba hecho" exige evidencia verificable. Ver ADR-008 |
| `TOASK.md` vive en la raíz del proyecto, no en `brain/` | Archivo operativo junto a `SPEC.md` y `SHAME.md`; `project-init` lo crea ahí en ambos runtimes. Proyectos anteriores con `brain/TOASK.md` siguen válidos. Ver ADR-007 |
| `code-comment-convention`: el código fuente es la tercera capa de conocimiento | Brain KMS (desarrollador) · `SPEC.md` (agente) · código fuente (ambos). Una limpieza nunca elimina comentarios de decisión, regla de negocio, workaround o seguridad solo porque el código "parece claro". Los proyectos instalados la reciben por oferta única de `ward`/`keepit`, no por migración automática. El ejemplo ExtJS + Supabase de la skill es el origen del problema: no quitarlo. Ver ADR-009 |
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
| Plugin core (Claude Code) | `plugins/suplemento-core/` | Publicado v0.15.0 (instalado localmente en 0.13.0: actualizar) |
| Skill project-init | `plugins/suplemento-core/skills/project-init/` | Vigente — usada para inicializar este mismo repo |
| Runtime Gemini (Antigravity) | `runtimes/gemini-antigravity/` | Vigente — 14 skills traducidas, incluye `01-brain-kms.md` y `14-code-comment-convention.md` |

---

## 8. Referencias a spec/

| Archivo | Contenido |
|---|---|
| [`spec/roadmap-skills.md`](spec/roadmap-skills.md) | Backlog vivo de la metodología — lo que el autor necesita + lo que el agente sugiere |
| [`spec/datos.md`](spec/datos.md) | Convenciones, diccionarios, anexos |
| [`spec/historial.md`](spec/historial.md) | Retirado — ver `brain/sesiones.md` |
| [`spec/cerrados.md`](spec/cerrados.md) | Archivo único de ítems cerrados: ID original + fecha + evidencia, ordenado por ID |

---

_SPEC.md — v0.15.0. Última actualización: 2026-10-06._
