---
description: DEPRECADO desde suplemento-core 0.12.0 — renombrado a "ward" (guarda sin push) y "keepit" (cierra sesión con push).
---

## Comando deprecado

`checkpoint` se dividió en dos comandos en 0.12.0:

- **`ward`** — hace todo lo que hacía `checkpoint` (brain/, SPEC.md, commit) **pero sin push**. Ver `commands/ward.md`.
- **`keepit`** — cierre de sesión: verifica que no falte nada, revisa los pendientes y hace commit + push final. Ver `commands/keepit.md`.

Al recibir la palabra "checkpoint":

1. Avisar al humano que el comando fue renombrado y que **el comportamiento cambió: ya no hace push**.
2. Ejecutar `ward` (`commands/ward.md`) tal cual.
3. Preguntar si también quiere cerrar la sesión con `keepit` (que es el que hace el push).

Este archivo se conserva solo por compatibilidad y se retirará en una versión futura. Si el proyecto tiene además un `.claude/commands/checkpoint.md` propio, ese archivo tapa a este: ver `skills/spec-driven-development/references/migracion-0.12.md`.
