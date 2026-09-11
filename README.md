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

### 🟢 Gemini (Antigravity IDE)

Desde la terminal integrada de tu espacio de trabajo:

```bash
curl -fsSL https://raw.githubusercontent.com/OrcaCl/suplemento-estrella/main/install-gemini.sh | bash
```

Instala el runtime en `.gemini/` dentro de tu proyecto, sin necesidad de clonar el repo completo. Ver `runtimes/gemini-antigravity/` para el detalle del runtime.

### Después de instalar (cualquier runtime)

Dile al agente que inicie el proyecto:

```
project-init
```

Y sigue los pasos que te va preguntando para dejar todo listo.

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
| [`CHANGELOG.md`](CHANGELOG.md) | Historial de hitos, todas las capas (Core + runtimes) |

> **Nota:** `docs/conventions.md` y `docs/glossary.md` están pendientes de contenido — ver `SPEC.md` para el seguimiento.

---

## Estado del proyecto

Suplemento Estrella se encuentra en **desarrollo activo** (v0.10.0 — pre-1.0). La implementación de referencia está orientada a Claude Code; el harness fue diseñado para poder adaptarse a otros agentes, y Google Gemini ya es el primer runtime adicional.

Los forks y contribuciones son bienvenidos.

---

## Licencia

MIT — ver [`LICENSE`](LICENSE).

**Comparte metodología. No deuda técnica.**

---

Hecho en Chile 🇨🇱, con mucho cariño, para todos los amigos y amigas de la sobreingeniería.
