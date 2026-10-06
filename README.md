# ⭐ Suplemento Estrella

**TL;DR:** Suplemento Estrella es un **harness** de desarrollo asistido por agentes de código, con esteroides IA.

Permite orientar y definir **cómo colaboran un desarrollador humano y su agente de IA** durante todo el ciclo de vida de un proyecto: desde la planificación inicial hasta el cierre de cada sesión de trabajo.

**No es un framework. No es un boilerplate. No es una plantilla de proyecto.**

Claude Code es el runtime de referencia, pero el harness es multi-runtime desde v0.10.0 — ver [Instalación](#instalación) para Google Gemini (Antigravity).

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

Actualizar el plugin **no modifica los archivos de tus proyectos** (`SPEC.md`, `brain/`, `spec/`, `CLAUDE.md`). Si la versión trae cambios de convención, cada proyecto necesita una migración manual: revisa las entradas del [`CHANGELOG.md`](CHANGELOG.md) entre tu versión y la nueva. Para la 0.12.0, la guía está en `plugins/suplemento-core/skills/spec-driven-development/references/migracion-0.12.md`. Para la 0.13.0 (convención de comentarios en el código, opcional), en `plugins/suplemento-core/skills/code-comment-convention/references/migracion-0.13.md`; además, `ward` y `keepit` te la ofrecen una vez si el `CLAUDE.md` del proyecto no la menciona. Para la 0.14.0 (`listeilor` pasa a llamarse `keepit`), no hay migración de archivos: si tu `CLAUDE.md` o tus notas mencionan `listeilor`, cámbialo por `keepit`. En la 0.15.0 se retiraron los comandos `listeilor` y `checkpoint`: si tu proyecto aún los usa, cambia a `keepit` y `ward` antes de actualizar.

### 🟢 Gemini (Antigravity IDE)

Desde la terminal integrada de tu espacio de trabajo:

```bash
curl -fsSL https://raw.githubusercontent.com/OrcaCl/suplemento-estrella/main/install-gemini.sh | bash
```

Instala el runtime en `.gemini/` dentro de tu proyecto, sin necesidad de clonar el repo completo. Ver `runtimes/gemini-antigravity/` para el detalle del runtime.

#### Actualizar el runtime en un proyecto que ya está funcionando

El runtime vive dentro de cada proyecto, así que se actualiza proyecto por proyecto: vuelve a correr el mismo comando de instalación desde la raíz del proyecto. Sobrescribe el contenido de `.gemini/` con la versión nueva; no toca `SPEC.md`, `brain/`, `spec/` ni tu `GEMINI.md`. Como con Claude Code, si la versión trae cambios de convención, revisa el [`CHANGELOG.md`](CHANGELOG.md); para la 0.12.0, la guía está en `.gemini/skills/references/spec-migracion-0.12.md`.

### Después de instalar (cualquier runtime)

Dile al agente que inicie el proyecto:

```
project-init
```

Y sigue los pasos que te va preguntando para dejar todo listo.

Durante el trabajo, dos comandos cuidan el registro de la sesión:

- **`ward`** — guarda en `brain/` y `SPEC.md` lo pendiente y hace commit local, sin push. Úsalo a mitad de sesión.
- **`keepit`** — cierra la sesión: verifica que no falte nada por respaldar, revisa que no queden pendientes sin anotar, y hace el commit y push finales.

(`checkpoint` y `listeilor`, el nombre anterior de `keepit`, fueron retirados en 0.15.0 y ya no existen como comandos.)

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
| [`docs/plugins.md`](docs/plugins.md) | Ecosistema recomendado, qué incluye la metodología, multi-runtime |
| [`docs/principles.md`](docs/principles.md) | Principios concretos: KISS, DRY, TDD, SDD, diseño previo, modo secuencial |
| [`docs/decisions.md`](docs/decisions.md) | Cómo se registran y mantienen las decisiones dentro de Brain KMS |
| [`docs/conventions.md`](docs/conventions.md) | Convenciones de nombres, estructura, documentación, versionado y commits |
| [`docs/glossary.md`](docs/glossary.md) | Diccionario de los conceptos propios (ADR, INT, NOC, ward, keepit, SHAME…) |
| [`CHANGELOG.md`](CHANGELOG.md) | Historial de hitos, todas las capas (Core + runtimes) |

---

## Estado del proyecto

Suplemento Estrella se encuentra en **desarrollo activo** (v0.14.0 — pre-1.0). La implementación de referencia está orientada a Claude Code; el harness fue diseñado para poder adaptarse a otros agentes, y Google Gemini ya es el primer runtime adicional.

Los forks y contribuciones son bienvenidos.

---

## Licencia

MIT — ver [`LICENSE`](LICENSE).

**Comparte metodología. No deuda técnica.**

---

Hecho en Chile 🇨🇱, con mucho cariño, para todos los amigos y amigas de la sobreingeniería.
