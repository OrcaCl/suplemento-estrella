# Migración a suplemento-core 0.13.0 — convención de comentarios en el código

Para proyectos que ya estaban en funcionamiento y solo actualizan el plugin. **Es opcional y no modifica código**: la skill `code-comment-convention` queda disponible apenas se actualiza el plugin (se activa por su descripción al crear, modificar, revisar o limpiar código), pero el proyecto no la "adopta" formalmente hasta que su `CLAUDE.md` la declara.

## Qué cambió

| Antes (≤ 0.12) | Ahora (0.13.0) |
|---|---|
| Los comentarios en el código no tenían dirección: cada sesión decidía por su cuenta qué documentar y qué limpiar | `code-comment-convention`: el código explica QUÉ y CÓMO, los comentarios explican POR QUÉ; contratos con JSDoc/PHPDoc/docstrings; marcadores `TODO`/`FIXME`/`HACK`/`NOTE` con significado propio |
| Una limpieza o refactorización podía eliminar comentarios "porque el código parece claro" | **Regla de no destrucción:** antes de eliminar un comentario se clasifica; los de decisión, regla de negocio, workaround, seguridad o rendimiento se conservan |
| `project-init` no decía nada sobre comentarios | Los proyectos nuevos nacen con la sección `## Comentarios en el código` en `CLAUDE.md` |

## Pasos de migración

1. **Actualizar el plugin** (marketplace `suplemento-estrella` → `suplemento-core` 0.13.0) y reiniciar Claude Code. Comandos en el `README.md` del repo.
2. **Agregar la sección a `CLAUDE.md`** (la misma que traen los proyectos nuevos, ver `skills/project-init/references/claude-md-template.md`, sección "Comentarios en el código"):
   ```markdown
   ## Comentarios en el código

   El código explica QUÉ y CÓMO; los comentarios explican POR QUÉ. Documentar contratos con la convención del lenguaje (JSDoc, PHPDoc, docstrings) y usar comentarios inline solo para decisiones no obvias, reglas de negocio, workarounds y restricciones de seguridad o rendimiento. **Nunca eliminar un comentario solo porque el código parece suficientemente claro:** antes de una limpieza o refactorización, clasificarlo (ver skill `code-comment-convention`).
   ```
3. **No hace falta tocar el código existente.** La convención rige hacia adelante: se aplica al código que se cree o modifique. No hay una pasada masiva de comentarios.

## La oferta en `ward` y `keepit`

Si el `CLAUDE.md` del proyecto no menciona `code-comment-convention` ni tiene la sección `## Comentarios en el código`, `ward` y `keepit` lo avisan **una sola vez** y ofrecen agregarla (paso 0a de `ward`). El humano decide:

- **Acepta:** se agrega la sección de arriba a `CLAUDE.md`.
- **Rechaza:** se deja constancia en `CLAUDE.md` con una línea (`Comentarios en el código: convención no adoptada (decisión del humano, AAAA-MM-DD)`) y no se vuelve a ofrecer. Si cambia de opinión, basta con reemplazarla por la sección.

## Qué revisar después

- El `CLAUDE.md` del proyecto tiene la sección `## Comentarios en el código` (o la constancia de que no se adoptó).
- En una limpieza o refactorización posterior, el agente clasifica los comentarios antes de eliminar alguno, en vez de borrar por cantidad o longitud.
