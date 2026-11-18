# ⭐ Suplemento Estrella

**TL;DR:** Suplemento Estrella es un **harness** de desarrollo asistido por agentes de código, con esteroides IA.

Permite orientar y definir **cómo colaboran un desarrollador humano y su agente de IA** durante todo el ciclo de vida de un proyecto: desde la planificación inicial hasta el cierre de cada sesión de trabajo.

**No es un framework. No es un boilerplate. No es una plantilla de proyecto.**

Está construido para **Claude Code**. Ver [Instalación](#instalación).

---

## Instalación

**No clones este repo directamente para usar el plugin.**

### 🔵 Claude Code

```
/plugin marketplace add OrcaCl/suplemento-estrella
/plugin install suplemento-core@suplemento-estrella
```

Esto instala únicamente el contenido del plugin (`plugins/suplemento-core/`), no el repo constructor completo.

Si quieres explorar el código fuente sin instalarlo, usa `git clone` con sparse checkout apuntando solo a `plugins/suplemento-core/`.

#### Actualizar el plugin en un proyecto que ya está funcionando

El plugin se instala una vez por usuario, no por proyecto: al actualizarlo, todos tus proyectos pasan a la versión nueva. Desde la terminal:

```bash
claude plugin marketplace update suplemento-estrella
claude plugin update suplemento-core@suplemento-estrella
```

Reinicia Claude Code para que cargue la versión nueva y confirma con `claude plugin list`.

Actualizar el plugin **no modifica los archivos de tus proyectos** (`SPEC.md`, `brain/`, `spec/`, `CLAUDE.md`). Si la versión trae cambios de convención, cada proyecto necesita una migración manual: revisa las entradas del [`CHANGELOG.md`](CHANGELOG.md) entre tu versión y la nueva.

> ### ⚠️ Si vienes de una versión anterior a la 0.16.0: revisa `.claudeignore`
>
> Hasta la 0.15.0, `project-init` generaba un archivo **`.claudeignore`** y las skills lo presentaban como protección para que el agente no leyera secretos (`brain/files/secure/`, `.env`…). **Claude Code no reconoce ese archivo**: su documentación oficial dice que "no tiene efecto". Es un patrón difundido en tutoriales que parece oficial, y este plugin lo adoptó.
>
> No es una puerta trasera ni da acceso a terceros, pero **el agente sí podía leer** esos archivos. En cada proyecto ya inicializado: crea `.claude/settings.json` con reglas `deny`, borra el `.claudeignore`, revisa que no haya secretos versionados y rota cualquier credencial que haya estado al alcance del agente. La guía paso a paso está en [`migracion-0.16.md`](plugins/suplemento-core/skills/project-init/references/migracion-0.16.md).

Guías de migración por versión:

| Versión | Qué cambia | Guía |
|---|---|---|
| **0.16.0** | Protección de secretos con reglas `deny` (no `.claudeignore`), boletines en `brain/reports/`, registro por umbral, skill de seguridad, `housekeeping`, runtime Gemini retirado | `plugins/suplemento-core/skills/project-init/references/migracion-0.16.md` |
| 0.15.0 | Se retiran `listeilor` y `checkpoint`: cambia a `keepit` y `ward` antes de actualizar | — |
| 0.14.0 | `listeilor` pasa a llamarse `keepit` | Si tu `CLAUDE.md` o tus notas lo mencionan, cámbialo |
| 0.13.0 | Convención de comentarios en el código (opcional); `ward` y `keepit` te la ofrecen una vez | `plugins/suplemento-core/skills/code-comment-convention/references/migracion-0.13.md` |
| 0.12.0 | `ward`, `SPEC.md` que se reemplaza y no se acumula | `plugins/suplemento-core/skills/spec-driven-development/references/migracion-0.12.md` |

### Novedades de la 0.16.0

- **Seguridad por diseño:** nueva skill `seguridad-por-diseno`, una guía por tipo de cambio basada en OWASP Top 10:2025, ASVS 5.0, los riesgos de agentes de OWASP (ASI 2026), STRIDE y NIST SSDF. Avisa lo que no pudo cumplir; no bloquea commits.
- **Secretos protegidos de verdad:** reglas `deny` en `.claude/settings.json` y un `.gitignore` ampliado; el primer commit revisa el estado y busca secretos antes de empujar.
- **`housekeeping`:** limpieza y lint con calma, con informe y aprobación.
- **Registro por umbral:** Code registra en `brain/` y `SPEC.md` al terminar una tarea con conocimiento nuevo, sin esperar un `ward`. `registro: diferido` conserva el comportamiento anterior.
- **`SPEC.md` con criterio orgánico:** el tamaño solo avisa.
- **`brain/` más ordenado:** los boletines (ADR, INT, NOC, DEP…) van en `brain/reports/`; la raíz de `brain/` solo guarda `index.md` y `sesiones.md`. Migrarlo en proyectos existentes es opcional.
- **Retirado:** el runtime de Gemini (ver [`DEP-002`](brain/reports/DEP-002-retiro-del-runtime-gemini.md)).

### Después de instalar

Dile al agente que inicie el proyecto:

```
project-init
```

Y sigue los pasos que te va preguntando para dejar todo listo.

Durante el trabajo, tres comandos cuidan el registro y el orden:

- **`ward`** — guarda en `brain/` y `SPEC.md` lo pendiente y hace commit local, sin push. Úsalo a mitad de sesión.
- **`keepit`** — cierra la sesión: verifica que no falte nada por respaldar, revisa que no queden pendientes sin anotar, y hace el commit y push finales.
- **`housekeeping`** — limpieza con calma, fuera de una sesión intensa: revisa `SPEC.md`, `brain/` y el plugin en solo lectura, te muestra un informe y aplica solo lo que apruebes (commit local, sin push).

---

## Documentación

Este README es intencionalmente breve. El detalle vive en `docs/`:

| Documento | Contenido |
|---|---|
| [`docs/getting-started.md`](docs/getting-started.md) | Primeros pasos, instalación en detalle, crear un proyecto nuevo |
| [`docs/workflow.md`](docs/workflow.md) | Flujo de trabajo completo: inicializar → construir contexto → desarrollar → cerrar sesión |
| [`docs/philosophy.md`](docs/philosophy.md) | Filosofía, qué se reutiliza y qué nunca, principio de integración |
| [`docs/brain.md`](docs/brain.md) | Brain KMS — sistema de memoria persistente del proyecto (ADR, INT, NOC, DEP, REF/REFX) |
| [`docs/spec.md`](docs/spec.md) | `SPEC.md` como panel de control, cuándo escalar a `spec/` |
| [`docs/plugins.md`](docs/plugins.md) | Ecosistema recomendado y qué incluye la metodología |
| [`docs/principles.md`](docs/principles.md) | Principios concretos: KISS, DRY, TDD, SDD, diseño previo, modo secuencial |
| [`docs/decisions.md`](docs/decisions.md) | Cómo se registran y mantienen las decisiones dentro de Brain KMS |
| [`docs/conventions.md`](docs/conventions.md) | Convenciones de nombres, estructura, documentación, versionado y commits |
| [`docs/glossary.md`](docs/glossary.md) | Diccionario de los conceptos propios (ADR, INT, NOC, ward, keepit, SHAME…) |
| [`CHANGELOG.md`](CHANGELOG.md) | Historial de hitos y versiones |
| [`NOTICE.md`](NOTICE.md) | Avisos de terceros: material de OWASP bajo CC BY-SA 4.0 |

---

## Estado del proyecto

Suplemento Estrella se encuentra en **desarrollo activo** (v0.16.0 — pre-1.0) y está orientado a Claude Code. Existió un runtime para Google Gemini; se retiró en la 0.16.0.

Los forks y contribuciones son bienvenidos.

---

## Créditos y licencias de terceros

Este proyecto se apoya en trabajo abierto de otras personas y organizaciones, y lo declara:

| Fuente | Licencia | Dónde se usa |
|---|---|---|
| OWASP (Top 10:2025, ASVS 5.0, riesgos de agentes, seguridad de datos) | CC BY-SA 4.0 | `skills/seguridad-por-diseno/references/` |
| Modern Web Guidance (GoogleChrome) — accesibilidad, formularios, componentes, CSS, rendimiento, HTML y JS, y seguridad del navegador | Apache-2.0 | `skills/frontend-conventions/references/` y `skills/seguridad-por-diseno/references/seguridad-web-navegador.md` |

Lo adaptado se traduce, resume y reorganiza con redacción propia, conserva la atribución y la licencia de origen, e indica los cambios; no implica respaldo de los autores originales. El detalle de cada fuente, versión y cambio está en [`NOTICE.md`](NOTICE.md), y la regla para sumar material de terceros, en [`docs/conventions.md`](docs/conventions.md#material-de-terceros).

---

## Licencia

MIT — ver [`LICENSE`](LICENSE). Los archivos de `plugins/suplemento-core/skills/seguridad-por-diseno/references/` que adaptan material de OWASP se distribuyen bajo CC BY-SA 4.0 — ver [`NOTICE.md`](NOTICE.md).

**Comparte metodología. No deuda técnica.**

---

Hecho en Chile 🇨🇱, con mucho cariño, para todos los amigos y amigas de la sobreingeniería.
