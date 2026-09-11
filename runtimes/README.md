# runtimes/

Adaptaciones de la metodología Suplemento Estrella para agentes de código distintos de Claude Code.

## Convención

- **Claude Code** es el runtime original y de referencia. Su plugin vive en `plugins/suplemento-core/` (no en esta carpeta) — es la fuente de verdad de la metodología y la ruta que espera `.claude-plugin/marketplace.json`.
- **`runtimes/`** aloja las adaptaciones a otros agentes, una carpeta por runtime. Cada adaptación traduce el mismo reglamento (spec-driven development, `brain/` KMS, modo secuencial, TDD quirúrgico, diseño antes de implementar, etc.) al formato y las convenciones de ubicación que ese agente espera — sin cambiar el espíritu ni las reglas de fondo.

## Runtimes disponibles

| Carpeta | Agente | Estado |
|---|---|---|
| [`gemini-antigravity/`](gemini-antigravity/) | Google Gemini (Antigravity) | Vigente |

## Por qué no se movió Claude Code también a `runtimes/`

Se evaluó por simetría estructural y se descartó: `plugins/suplemento-core/` es la ruta que instala el propio autor y la que referencia `marketplace.json`; moverla exige actualizar el marketplace y reinstalar el plugin local sin beneficio real. `runtimes/` queda reservada para agentes adicionales (Gemini y los que vengan después).
