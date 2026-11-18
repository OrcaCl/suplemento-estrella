# ADR-004 — README.md breve, docs/ como fuente detallada; instalador de Gemini corregido

**Estado:** Vigente
**Fecha:** 2026-09-11

## Contexto

El usuario terminó el launcher de Gemini (`install-gemini.sh`, instalador de una línea que descarga el runtime a `.gemini/` sin clonar el repo completo) y trajo un borrador de sección de README con el comando de instalación. Pidió revisar si `README.md` (272 líneas, con contenido desactualizado: terminología "Brújula"/"Star Supplement", instalación con nombre de repo incorrecto `star-supplement`, una nota `// EDIT:` cruda sobre Superpowers/claude-mem que ya se había resuelto según `CHANGELOG.md`) podía reorganizarse, moviendo contenido extenso a `docs/` — que ya tenía 8 de 10 archivos vacíos, varios calzando temáticamente con secciones del README.

Al revisar `install-gemini.sh` antes de tocar el README, se detectó un bug bloqueante: la lista `REFERENCES` del script pedía `gitignore-template.md`, `geminiignore-template.md` y `spec-md-template.md`, nombres que no existen en `runtimes/gemini-antigravity/skills/references/` (los reales: `ignore-template.md`, `spec-folder-template.md`, `gemini-template.md`, `trackers-templates.md`). Con `curl -f`, el script fallaría en cualquier instalación real.

## Decisión

1. **Se corrige el bug de `install-gemini.sh`** antes de continuar — la lista `REFERENCES` ahora usa los nombres de archivo reales.
2. **`README.md` se reduce a landing page** (~65 líneas): TL;DR, instalación de ambos runtimes (Claude Code y Gemini, incluyendo el comando de una línea del instalador), un índice con enlaces a `docs/`, estado del proyecto, y licencia.
3. **Se reparte el contenido movido** a los archivos vacíos de `docs/` que ya existían, evitando duplicación:
   - `docs/philosophy.md` — Filosofía + Principio de Integración + "¿Qué problema busca resolver?" (se fusionaron por ser variaciones del mismo tema; `docs/principles.md` queda sin usar, ver Consecuencias).
   - `docs/workflow.md` — Flujo de trabajo completo (inicializar → contexto → desarrollar → cerrar sesión).
   - `docs/spec.md` — Rol de `SPEC.md` y cuándo escalar a `spec/`.
   - `docs/plugins.md` — Ecosistema de plugins + qué incluye la metodología + nota de multi-runtime. Aquí se corrigió también la nota `// EDIT:` obsoleta del README, reemplazándola por el estado real (Superpowers retirado 2026-09-01, según `CHANGELOG.md`).
   - `docs/getting-started.md` (ya tenía contenido) — actualizado: nombre de repo correcto, instalación de ambos runtimes, terminología harness/Brain KMS.
   - `docs/brain.md` (ya tenía contenido, el mejor material de todo el reparto) — solo se corrigió terminología ("Star Supplement" → "Suplemento Estrella") y se agregó la nota de que el nombre formal es Brain KMS.
4. **`docs/conventions.md` y `docs/glossary.md` quedan sin contenido** — no había material claro del README que calzara ahí. Se registra como pendiente explícito en `SPEC.md`, sin inventar contenido.
5. **`docs/principles.md` y `docs/decisions.md` quedan sin usar en este reparto** — su contenido esperado terminó fusionado en `philosophy.md` (principles) o no tenía fuente clara en el README (decisions). Queda pendiente evaluar si se retiran formalmente (`DEP`) o se les da un propósito propio más adelante.
6. Se agrega al final del README una línea informal reconociendo el origen del proyecto — "Hecho en Chile 🇨🇱, con mucho cariño, para todos los amigos y amigas de la sobreingeniería" — a pedido explícito del usuario.

## Razones

1. Un README de 272 líneas mezclaba landing page con manual completo — dificulta que alguien nuevo entienda en 30 segundos qué es el harness y cómo instalarlo.
2. Reutilizar los archivos vacíos ya existentes en `docs/` en vez de crear nuevos evita otro hallazgo de "documentación fantasma" — varios de esos huecos databan de la sesión de chat no traspasada mencionada en ADR-001.
3. Corregir el bug del instalador antes de tocar el README es la secuencia correcta: documentar un comando que falla en producción sería peor que no documentarlo.
4. La nota `// EDIT:` en el README era honesta en su momento pero quedó desactualizada — dejarla habría comunicado incertidumbre sobre una decisión que ya está tomada y registrada.

## Consecuencias

- `README.md` — reescrito, ~65 líneas.
- `docs/philosophy.md`, `docs/workflow.md`, `docs/spec.md`, `docs/plugins.md` — nuevos, con contenido.
- `docs/getting-started.md`, `docs/brain.md` — actualizados (terminología, instalación).
- `install-gemini.sh` — bug de nombres de archivo en `REFERENCES` corregido.
- `SPEC.md` — pendiente actualizado: solo `conventions.md`/`glossary.md` quedan vacíos; nota sobre `principles.md`/`decisions.md` sin usar.
- **Pendiente explícito, no resuelto en esta sesión:** contenido de `docs/conventions.md` y `docs/glossary.md`; decisión sobre `docs/principles.md` y `docs/decisions.md` (fusionar, dar propósito propio, o retirar formalmente).

## Commit

Ver entrada "Sesión — 2026-09-11 (continuación 3) — Launcher de Gemini terminado, README reorganizado" en `brain/sesiones.md`.
