---
description: DEPRECADO desde suplemento-core 0.14.0 — renombrado a "keepit" (cierra la sesión con commit y push).
---

## Comando deprecado

`listeilor` pasó a llamarse **`keepit`** en 0.14.0. El procedimiento es el mismo; solo cambió la palabra. Ver `commands/keepit.md`.

Al recibir la palabra "listeilor":

1. Avisar al humano que el comando fue renombrado a `keepit`.
2. Ejecutar `keepit` (`commands/keepit.md`) tal cual.

Este archivo se conserva solo por compatibilidad con proyectos que aún usan la palabra anterior y se retirará en una versión futura. Si el proyecto tiene además un `.claude/commands/listeilor.md` propio, ese archivo tapa a este.
