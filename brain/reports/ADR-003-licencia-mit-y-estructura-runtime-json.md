# ADR-003 — Licencia MIT del repo y estructura de runtime.json (Gemini)

**Estado:** Vigente
**Fecha:** 2026-09-11

## Contexto

Al preparar el launcher de Gemini, el usuario le pidió a Gemini un `runtime.json` de ejemplo para `runtimes/gemini-antigravity/`. Gemini devolvió un archivo con varios campos nuevos respecto al `runtime.json` creado en ADR-001, incluyendo `license: "MIT"` y `author: "Suplemento Estrella"`.

Ninguna de las dos cosas estaba decidida en el repo: no existía archivo `LICENSE` en la raíz, `plugin.json` de Claude Code no declaraba campo `license`, y el autor real de la metodología es una persona (Orlando/OrcaCl), no "Suplemento Estrella" como entidad — ese campo en la propuesta de Gemini era una regresión respecto al `author` ya correcto en `plugin.json` y en el `runtime.json` original.

Gemini también agregó `target_model: "Gemini 1.5 Pro / Ultra"` y un bloque `architecture` (`type`, `master_spec`, `entry_point`, `skills_dir`).

## Decisión

1. **Se adopta licencia MIT para el repo completo.** Se crea `LICENSE` en la raíz (copyright Orlando/OrcaCl, 2026) y se declara `"license": "MIT"` tanto en `plugin.json` (Claude Code) como en `runtime.json` (Gemini) — consistente en ambos manifests, no solo en el que lo propuso.
2. **`author` se mantiene como el autor real** (`{"name": "Orlando (OrcaCl)"}`) en `runtime.json`, igual que en `plugin.json` — se descarta el `"author": "Suplemento Estrella"` propuesto por Gemini.
3. **Se incorpora el bloque `architecture`** de la propuesta de Gemini (`type: modular-lazy-loading`, `entry_point: GEMINI.md`, `master_spec: GEMINI-RUNTIME.md`, `skills_dir: skills/`) — aporta valor real: documenta en el propio manifest cómo se ensambla este runtime en particular, algo que `plugin.json` de Claude Code no necesita porque esa estructura la define el host, pero que un runtime adaptado a mano sí debe dejar explícito.
4. **Se agrega `display_name`** (`"Gemini Runtime for Antigravity IDE"`) — útil como nombre legible además del slug técnico `gemini-antigravity`.
5. **Se descarta `target_model`** (`"Gemini 1.5 Pro / Ultra"`). Atar el manifest a una versión específica de modelo genera falsa precisión que se desactualiza sola apenas Google libere un modelo nuevo — ni `plugin.json` de Claude Code fija una versión de Claude en ningún campo, por la misma razón. Si en el futuro hace falta declarar compatibilidad, usar una referencia sin versión de modelo (ej. `"target": "Gemini (Antigravity IDE)"`).

## Razones

1. El repo se distribuye vía marketplace — terceros podrían instalarlo. No tener licencia declarada deja esa relación legal ambigua; MIT es la convención estándar para herramientas de desarrollador y no impone fricción a quien lo use, incluso en proyectos cerrados.
2. Declarar la licencia en un solo manifest (`runtime.json`) y no en el otro (`plugin.json`) habría creado inconsistencia entre runtimes del mismo repo — se corrige aplicándola a ambos a la vez.
3. `author` debe identificar a la persona real, no reinventar el nombre del proyecto como si fuera una organización — mantiene coherencia con la decisión ya tomada en `plugin.json` desde su creación.
4. El bloque `architecture` es información que ya existe de forma dispersa (en `GEMINI-RUNTIME.md`, `GEMINI.md`) pero no estaba resumida en el manifest — consolidarla ahí facilita que cualquier agente (o persona) entienda la forma del runtime sin leer los documentos completos primero.
5. Fijar una versión de modelo específica en un archivo de configuración de larga vida es una fuente de deuda de documentación silenciosa — mejor evitarlo desde el origen.

## Consecuencias

- `LICENSE` (nuevo, raíz) — texto MIT estándar, copyright Orlando (OrcaCl) 2026.
- `plugins/suplemento-core/.claude-plugin/plugin.json` — agrega `"license": "MIT"`.
- `runtimes/gemini-antigravity/runtime.json` — corregido: `author` a la persona real, `license: "MIT"`, agrega `display_name` y `architecture`, sin `target_model`.
- `SPEC.md` — pendiente agregar la licencia como dato de estado del proyecto (ver Próximo en `brain/sesiones.md`).
- Si en el futuro se agregan más runtimes, su `runtime.json` (o equivalente) debe declarar `license` y `author` de forma consistente con este patrón.

## Commit

Ver entrada "Sesión — 2026-09-11 (continuación 2) — Licencia MIT y ajuste de runtime.json" en `brain/sesiones.md`.
