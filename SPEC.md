# Suplemento Estrella (repo constructor del plugin)

## Documento de contexto y descubrimientos

<!-- TAMAÑO (ADR-011, reemplaza el tope duro de ADR-006/ADR-008): referencia de 1000 líneas, solo avisa; sin límite por línea. Criterio: ¿lo necesita el agente al abrir la sesión? REEMPLAZAR, no acumular.
     Narrativa → brain/sesiones.md · cerrados → spec/cerrados.md (ID original, ordenado por ID) · header = solo fecha · "Última sesión" = 1 fila ≤ 400 car. · footer = 1 línea ≤ 300 car.
     Pendientes: SOLO en §3. Antes de commitear: revisar consistencia (lista en la skill spec-driven-development); el tamaño solo avisa. -->

**Versión:** 0.16.0
**Última actualización:** 2026-11-18

---

## 1. Problema y objetivo

Suplemento Estrella es un **harness** de desarrollo asistido por agentes de código, distribuido como marketplace/plugin instalable de Claude Code. Este repo es el **constructor** de ese harness — no un proyecto que lo consume, sino el que lo produce y versiona. Existió un runtime para Google Gemini (v0.10.0 a v0.15.0); se retiró en la 0.16.0 (DEP-002).

| Fuente | Qué entrega |
|---|---|
| `.claude-plugin/marketplace.json` | Definición del marketplace instalable (Claude Code) |
| `plugins/suplemento-core/` | Skills, comandos y convenciones — runtime de referencia (Claude Code) |
| `CHANGELOG.md` (raíz) | Registro único de hitos y versiones — ver ADR-002 |
| `LICENSE` (raíz) | MIT — ver ADR-003 |
| `docs/` | Documentación conceptual dirigida a quien instala y usa el harness — completa (`principles`, `decisions`, `glossary`, `conventions` incluidos) |

**Objetivo:** mantener el harness coherente, documentar el porqué de sus propias decisiones de diseño, y que el plugin siga siendo instalable y funcional en proyectos reales.

---

## 2. Estado actual

| Métrica | Valor |
|---|---|
| Skills en `suplemento-core` (Claude Code) | Ver `plugins/suplemento-core/skills/` |
| Marketplace | Registrado y `suplemento-core` instalado en el propio Claude Code del autor |
| Versión del plugin `suplemento-core` (Claude Code) | `0.16.0` (fijada en `plugin.json`; semver desde 0.10.0, antes solo hash de commit) |
| Última sesión | 2026-11-18 — **Cierre de la 0.16.0 (sin publicar): runtime Gemini retirado, reglas `deny` en vez de `.claudeignore`, boletines en `brain/reports/`, `frontend-conventions` con guías propias de accesibilidad, formularios y componentes (ADR-021), skill de seguridad y `housekeeping`.** Urgente: ítem 23 (migrar proyectos) y 24 (publicar). |

---

## 3. Pendientes activos

> Lista única: los ítems abiertos existen **solo aquí**. Un ítem conserva su ID hasta cerrarse y el ID no se reutiliza. Al cerrarlo: borrar la fila → insertarla en `spec/cerrados.md` con su mismo ID + fecha + evidencia, en su posición por ID → agregar el ID a "Cerrados".

**Alta**

- _(vacío)_

**Media**

- [ ] **3** — Observar si el control de tamaño sin script basta en uso real; si `SPEC.md` vuelve a degradarse, reabrir la decisión del script (ADR-008)
- [ ] **6** — Probar la oferta de `code-comment-convention` (paso 0a de `ward`/`keepit`) en un proyecto real ya instalado: que se ofrezca una sola vez y que respete el rechazo (ADR-009); puede hacerse junto con el ítem 2
- [ ] **19** — Probar `seguridad-por-diseno` en un proyecto real que maneje login o datos personales y ajustar la tabla de controles (ADR-014). Pendiente menor: revisar el proyecto OWASP Agentic Skills Top 10 (repo `OWASP/www-project-agentic-skills-top-10`), que no se leyó. La lista ASI ya se verificó contra el PDF original; los hallazgos de la lectura de los 4 documentos OWASP están en `brain/sesiones.md` (entrada "lectura de documentos OWASP") y esperan decisión del autor
- [ ] **18** — Diseñar el comando **`ketchup`**: revisa en solo lectura las versiones de plugins, skills externas y dependencias (compara `PLUGINS.md` con `claude plugin list` y lo que haya de proyecto), informa lo desactualizado o en riesgo y actualiza solo lo que el humano apruebe, igual que `housekeeping`; es también el mecanismo de actualización de plugins de terceros (ADR-016): informa qué cambió y pide aprobación. El nombre juega con *catch up* (ponerse al día). Decidir si consulta internet o solo lo local, y cómo se relaciona con la skill de seguridad del ítem 10 (dependencias comprometidas) y con NOC-001
- [ ] **23** — **Migrar los proyectos ya inicializados** con el harness: tienen un `.claudeignore` sin efecto, así que `brain/files/secure/` y cualquier secreto dependen solo de `.gitignore` y el agente puede leerlos. En cada proyecto: crear `.claude/settings.json` con las reglas `deny` de la plantilla (fusionando si ya existe), eliminar `.claudeignore`, agregar `.claude/settings.local.json` al `.gitignore`, y revisar con `gitleaks` o a mano que no haya secretos versionados (ADR-018). Es la acción más urgente de la revisión
- [ ] **24** — **Publicar la 0.16.0:** correr `keepit` (commit y push), empujar la etiqueta `runtime-gemini-0.1.6` (`git push origin runtime-gemini-0.1.6`, hoy solo local) y crear la etiqueta de versión; luego `claude plugin marketplace update` y `claude plugin update suplemento-core@suplemento-estrella`, reiniciar Claude Code y confirmar con `claude plugin list`. Después, migrar los proyectos uno a uno (ítem 23)
- [ ] **26** — Mantener al día las referencias adaptadas de Modern Web Guidance: la tabla `madurez-funciones.md` (159 funciones) y las listas de `frontend-conventions` y `seguridad-web-navegador.md` son una instantánea de noviembre de 2026 y envejecen (una función "newly" pasa a "widely" a los 30 meses). Definir cómo revisarlas (`housekeeping` o `ketchup`), y decidir si se adaptan las categorías que no se tomaron (IA integrada, WebMCP, WebAssembly, PWA, efectos de nicho) si el trabajo las pide (ADR-022)
- [ ] **21** — Evaluar una receta opcional de hooks de Claude Code para bloquear de forma determinista lo destructivo (`rm -rf`, `git push --force`, `reset --hard`, escritura de `.env`), con falla cerrada. Según OWASP una guía sin control es "documentación, no defensa". El plugin no incluye scripts (ADR-008): sería una receta documentada que el humano instala con la skill `update-config`; decidir si va en `seguridad-por-diseno` o en `docs/`
- [ ] **14** — Revisar docs y skills a la luz de los cambios recientes de Claude Code (por ejemplo la skill `doctor`): detectar pasos manuales o trabas que las herramientas nuevas hacen innecesarias

**Baja / Externo**

- [ ] **5** — `docs/getting-started.md` dice que `project-init` prepara "una estructura simple o una completa según el tamaño", pero hoy crea siempre la estructura completa: corregir el texto
- [ ] **9** — Diseñar una memoria propia local para reemplazar a claude-mem: por proyecto (sin mezclar proyectos personales, laborales y privados), con respaldo local en un NVMe de 500 GB (a montar) y/o respaldo externo opcional. Requiere diseño previo (NOC-001)
- [ ] **15** — Revisar con calma (idealmente en un `housekeeping`) skills externas de referencia de ingenieros reconocidos, y dejar el harness pensado para el uso del autor sin volverlo inutilizable si un tercero o un equipo quisiera adoptarlo

Cerrados: 1, 2, 4, 7, 8, 10, 11, 12, 13, 16, 17, 20, 22, 25 _(detalle en `spec/cerrados.md`)_

---

## 4. Reglas críticas — NO NEGOCIABLE

> _Sin reglas críticas registradas todavía. Agregar aquí la primera vez que una decisión de este tipo se tome._

---

## 5. Decisiones que el agente debe recordar siempre

| Decisión | Detalle |
|---|---|
| Este repo usa `project-init` en modo meta | `brain/` documenta decisiones de la metodología en sí, no código de negocio de un proyecto cliente |
| La instancia de Code en este proyecto se llama Tomás | Convención de comunicación (INT-000), no regla técnica. `project-init` ofrece esta elección a todo proyecto nuevo en su Paso 3a |
| Versionado por capas desde 2026-09-11 (histórico) | Core (`SPEC.md`) y Claude Code (`plugin.json`) versionan por su cuenta; hasta la 0.15.0 también el runtime Gemini (`runtime.json`, con `core_version`), retirado en la 0.16.0. Antes: solo hash de commit. Ver ADR-001 y DEP-002 |
| Punto de partida de semver: `0.10.0`, no `1.0.0` ni `2.0.0` | Semver se adoptó ~1.5 semanas antes de este hito, sin serie 0.x/1.x previa real; `0.10.0` refleja pre-1.0/desarrollo activo. No es cálculo retroactivo estricto — ver ADR-001 |
| `CHANGELOG.md` vive en la raíz del repo (único, todas las capas) | Antes vivía en `plugins/suplemento-core/` — decisión obsoleta y reemplazada por ADR-002. Cada entrada cita la versión de su propia capa; el versionado en sí sigue siendo independiente por capa, no lockstep |
| Licencia del repo: MIT | `LICENSE` en la raíz, declarada en `plugin.json`. Excepción: lo derivado de OWASP en `seguridad-por-diseno/references/` va bajo CC BY-SA 4.0 (ver `NOTICE.md`). Ver ADR-003 |
| `plugins/suplemento-core/` es el único runtime mantenido (Claude Code) | Decisión explícita: no se reorganizó Claude Code por simetría — evita romper la instalación activa y la ruta que espera `marketplace.json`. El runtime Gemini se retiró en la 0.16.0 (DEP-002) |
| Sistema `brain/` se llama formalmente **Brain KMS** (Brain Knowledge Management System) | Skill `brain-kms` en Claude Code (desde v0.11.0); el `01-brain-kms.md` de Gemini se retiró con ese runtime. Ver ADR-001 |
| `SPEC.md` se reemplaza, no se acumula; tamaño orgánico | Narrativa → `brain/sesiones.md`, cerrados → `spec/cerrados.md`, "Última sesión" = 1 fila que se sobrescribe. Referencia de 1000 líneas que solo avisa, sin límite por línea; el plugin no incluye scripts. Ver ADR-006, ADR-008 y ADR-011 |
| `ward` guarda (commit local, sin push); `keepit` cierra sesión (commit + push) | Reemplazan a `checkpoint` (deprecado en 0.12.0). `keepit` se llamó `listeilor` hasta 0.13 (ADR-010); `checkpoint` y `listeilor` fueron retirados en 0.15.0 (DEP-001). Un comando local con el mismo nombre tapa al del plugin: revisar `.claude/commands/`. Ver ADR-008 |
| `spec/cerrados.md`: ID original del pendiente, ordenado por ID | Nombre fijo; reemplaza a `spec/completado.md` (deprecado, se conserva). Cerrar por "ya estaba hecho" exige evidencia verificable. Ver ADR-008 |
| `TOASK.md` vive en la raíz del proyecto, no en `brain/` | Archivo operativo junto a `SPEC.md` y `SHAME.md`; `project-init` lo crea ahí. Proyectos anteriores con `brain/TOASK.md` siguen válidos. Ver ADR-007 |
| `code-comment-convention`: el código fuente es la tercera capa de conocimiento | Brain KMS (desarrollador) · `SPEC.md` (agente) · código fuente (ambos). Una limpieza nunca elimina comentarios de decisión, regla de negocio, workaround o seguridad solo porque el código "parece claro". Los proyectos instalados la reciben por oferta única de `ward`/`keepit`, no por migración automática. El ejemplo ExtJS + Supabase de la skill es el origen del problema: no quitarlo. Ver ADR-009 |
| Registro por umbral (`registro: umbral`, por defecto) | Code registra en `brain/` y `SPEC.md` al terminar una tarea que cierre un ítem, tome una decisión registrable o deje conocimiento no recuperable del código; commit local, sin push, avisando después. `keepit` sigue obligatorio y es el único que hace push. Ver ADR-012 |
| `housekeeping` limpia con calma, con informe y aprobación | Lo dispara solo el humano; revisa en solo lectura `SPEC.md`/`spec/`, `brain/` y plugin/docs/runtimes, y aplica solo lo aprobado (commit local, sin push). Ver ADR-013 |
| `seguridad-por-diseno` es una guía, no una puerta | Aplica controles por tipo de cambio (OWASP Top 10:2025, ASVS 5.0, ASI 2026, STRIDE, SSDF) y avisa al terminar lo que no pudo cumplir; no bloquea commits. Nivel `asvs_nivel` en `CLAUDE.md` (1 por defecto). La lista ASI se contrastó con tres fuentes secundarias; falta el PDF original (ítem 19). Ver ADR-014 |
| Runtime Gemini retirado (2026-11-18) | `runtimes/gemini-antigravity/` e `install-gemini.sh` se borraron del repo; respaldo local en `brain/files/secure/runtime-gemini-antigravity-0.1.6.tar.gz` (no se versiona) y etiqueta git `runtime-gemini-0.1.6`. Ver DEP-002 (reemplaza al congelamiento de ADR-017) |
| `.claudeignore` no sirve; se usan reglas `deny` | Claude Code ignora `.claudeignore` (documentación oficial de permisos). Los secretos se protegen con `.gitignore` y con `permissions.deny` de `Read` en `.claude/settings.json`, que cubre las herramientas de archivos y comandos como `cat`, pero no scripts (para eso, el sandbox). Ver ADR-018 |
| Guías de frontend propias; sin depender de Modern Web Guidance (2026-11-18) | `frontend-conventions/references/` (8 archivos) y `seguridad-por-diseno/references/seguridad-web-navegador.md` adaptan todas las categorías útiles de esa fuente (Apache-2.0, atribuida en `NOTICE.md`); el plugin ya no se recomienda: ejecuta `npx @latest` en cada consulta y recopila telemetría. La tabla de madurez envejece (ítem 26). Ver ADR-021 y ADR-022 |
| `frontend-conventions`: parcial de template + `@layer`, BEM solo para nombres (2026-11-18) | Se dejó de mandar un `styles.css` de `@import` (cadena de requests) y BEM ya no se usa para controlar la especificidad; se agregó la sección de plataforma web moderna. Contraste con Modern Web Guidance. Ver ADR-020 |
| Los boletines viven en `brain/reports/` (2026-11-18) | La raíz de `brain/` solo guarda `index.md` y `sesiones.md`; los proyectos anteriores a la 0.16.0 pueden seguir con el diseño plano (no mezclar en un mismo proyecto). `housekeeping` propone la migración. Ver ADR-019 |
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
| Plugin core (Claude Code) | `plugins/suplemento-core/` | v0.16.0 en el repo, sin publicar (instalado localmente: 0.15.0) |
| Skill project-init | `plugins/suplemento-core/skills/project-init/` | Vigente — usada para inicializar este mismo repo |

---

## 8. Referencias a spec/

| Archivo | Contenido |
|---|---|
| [`spec/roadmap-skills.md`](spec/roadmap-skills.md) | Backlog vivo de la metodología — lo que el autor necesita + lo que el agente sugiere |
| [`spec/datos.md`](spec/datos.md) | Convenciones, diccionarios, anexos |
| [`spec/historial.md`](spec/historial.md) | Retirado — ver `brain/sesiones.md` |
| [`spec/cerrados.md`](spec/cerrados.md) | Archivo único de ítems cerrados: ID original + fecha + evidencia, ordenado por ID |

---

_SPEC.md — v0.16.0. Última actualización: 2026-11-18._
