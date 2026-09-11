# ADR-005 — Modo adopción en project-init de Gemini para proyectos ya iniciados con otro agente

**Estado:** Vigente
**Fecha:** 2026-09-11

## Contexto

El usuario preguntó cómo manejar retomar, con Gemini + Antigravity IDE, un proyecto que ya se inicializó con Claude Code en la misma carpeta (`SPEC.md`, `brain/`, `CLAUDE.md` ya existentes) — un escenario distinto a simplemente cambiar de carpeta dentro del mismo editor: cambia el agente y el IDE, no solo la ubicación.

Al revisar cómo Claude Code resuelve esto, se confirmó que `plugins/suplemento-core/skills/project-init/SKILL.md` ya tiene un **Paso 0** que detecta proyecto existente (`SPEC.md`/`brain/` ya presentes → modo "revisar/completar", no "crear desde cero").

Al buscar el equivalente en Gemini, se encontró que **`runtimes/gemini-antigravity/skills/02-project-init.md` estaba completamente vacío (0 líneas)** — la skill central para exactamente este escenario no tenía contenido, más allá del bug de nombres de archivo ya corregido en `install-gemini.sh` y `GEMINI-RUNTIME.md`.

`install-gemini.sh` ya maneja razonablemente bien un `GEMINI.md` existente (no lo sobreescribe, solo vincula el `@import` si falta), pero no distingue el caso "proyecto con `SPEC.md`/`brain/` ya creados por otro agente" — ese trabajo de detección y adopción de contexto no le corresponde al instalador (que solo copia archivos del runtime), sino a la skill `project-init` cuando se ejecuta.

**Opciones evaluadas:**
1. Portar el Paso 0 de Claude Code a `02-project-init.md` de Gemini, agregando un caso especial de "modo adopción" explícito — la skill, al ejecutarse en un proyecto ya inicializado, detecta el contexto existente y genera solo lo que falta (`GEMINI.md`, `.geminiignore`), sin tocar `SPEC.md`/`brain/`.
2. Crear un script de transición dedicado (`adopt-gemini.sh` o similar), separado del instalador normal, específico para este caso.

## Decisión

1. **Se completa `runtimes/gemini-antigravity/skills/02-project-init.md`** (antes vacío) portando el Paso 0 de detección de Claude Code, con un **modo adopción** explícito: si `SPEC.md`/`brain/` ya existen y `GEMINI.md` no, la skill confirma con el usuario, adopta el contexto existente sin recrearlo, y genera solo `GEMINI.md` + `.geminiignore` (leyendo `SPEC.md`/`brain/` reales para poblar el `GEMINI.md`, no una plantilla en blanco).
2. **No se crea un script de transición separado.** El mismo `install-gemini.sh` sigue sirviendo para traer los archivos del runtime a `.gemini/`; la lógica de detectar y adoptar contexto existente vive en la skill `project-init`, que es donde ya vivía el mismo tipo de lógica en Claude Code — mantiene el patrón "una sola fuente de verdad para esta decisión" en vez de duplicarla en un artefacto nuevo.
3. `SPEC.md` y `brain/` se tratan como **agnósticos de agente** — nunca se recrean ni se reescriben al adoptar un proyecto desde un runtime distinto. `CLAUDE.md` se deja intacto si existe (Claude Code lo sigue necesitando si se retoma más adelante).
4. Si el proyecto ya tiene un nombre humano asignado a la instancia de Claude Code (`CLAUDE.md`, INT-000/Paso 3a), la skill de Gemini **pregunta explícitamente** si se reutiliza el mismo nombre o se asigna uno distinto — no asume ninguna de las dos por defecto.

## Razones

1. `SPEC.md`/`brain/` ya fueron diseñados como markdown plano, sin nada específico de Claude Code — tratar de "transpilarlos" a un formato distinto por agente sería trabajo innecesario y una fuente de desincronización entre agentes trabajando sobre el mismo proyecto.
2. Un script de transición dedicado duplicaría lógica que ya existe (y funciona) como Paso 0 de `project-init` en Claude Code — mejor portar el patrón ya probado que inventar un artefacto nuevo con su propio mantenimiento.
3. Generar un `GEMINI.md` poblado con el contexto real (leído de `SPEC.md`/`brain/`) en vez de una plantilla vacía evita que la primera sesión de Gemini en el proyecto empiece "en blanco" a pesar de que el proyecto ya tiene historial real.
4. Preguntar por el nombre de instancia en vez de asumir reutilizarlo (o no) respeta que es una convención de comunicación, no una regla técnica — corresponde al usuario decidir, no al agente.

## Consecuencias

- `runtimes/gemini-antigravity/skills/02-project-init.md` — completado (antes vacío), incluye Paso 0 con modo adopción.
- `install-gemini.sh` no requiere cambios adicionales — su comportamiento actual (no sobreescribir `GEMINI.md` existente) ya es compatible con este flujo.
- Verificado (`wc -l` sobre las 13 skills de Gemini): `02-project-init.md` era la única vacía — las 12 restantes ya tenían contenido. No queda ninguna skill vacía oculta en el runtime de Gemini.
- No cambia ninguna regla técnica de `sequential-mode`, `tdd-workflow`, ni la disciplina general — esta decisión es de contenido de skill y flujo de adopción, no de arquitectura del harness.

## Commit

Ver entrada "Sesión — 2026-09-11 (continuación 5) — Modo adopción en project-init de Gemini" en `brain/sesiones.md`.
