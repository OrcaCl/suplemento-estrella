# ADR-010 — `keepit` reemplaza a `listeilor` como comando de cierre de sesión

**Estado:** Vigente
**Fecha:** 2026-10-06

## Contexto

`listeilor` se introdujo en 0.12.0 (ADR-008) como el comando que cierra la sesión: verifica respaldo, revisa pendientes, commit y push. Tras una semana de uso, el autor lo encontró incómodo para algo que se dice en cada sesión: es una palabra larga, difícil de recordar y escribir, y es un chilenismo que no tiene sentido fuera del contexto del autor.

El autor escribió por su cuenta `commands/keepit.md` con el mismo procedimiento y pidió reemplazar el nombre en todo el repo.

**Opciones evaluadas:**
1. Renombrar solo el archivo del comando y dejar `listeilor` en el resto de la documentación.
2. Renombrar en todo el harness (comandos, skills, runtime Gemini, docs) y dejar `listeilor` como alias deprecado, igual que `checkpoint` en 0.12.0.
3. Renombrar en todo el harness y borrar `listeilor.md` sin alias.

## Decisión

Se adopta la opción 2:

1. **`keepit`** es el nombre del comando de cierre de sesión (`suplemento-core` 0.14.0; runtime Gemini 0.1.5). El procedimiento no cambia.
2. **`listeilor` queda como alias deprecado:** `commands/listeilor.md` avisa del cambio y ejecuta `keepit`. Se retirará en una versión futura. El aviso de colisión de `ward`/`keepit` también busca `listeilor` entre los comandos y skills locales.
3. **El historial no se reescribe:** `brain/` (ADR-008, ADR-009, INT-001, `sesiones.md`), `spec/cerrados.md` y las entradas anteriores del `CHANGELOG` conservan "listeilor", porque documentan el nombre vigente cuando se escribieron.

## Razones

1. Una palabra que se usa al final de cada sesión debe ser corta, recordable y sin regionalismos; `keepit` cumple las tres.
2. El alias evita romper proyectos ya instalados cuyo `CLAUDE.md` o hábitos mencionan `listeilor`: actualizar el plugin no modifica los archivos del proyecto (ver ADR-009), y es el mismo patrón que se usó con `checkpoint`.
3. Reescribir el historial haría que los registros dejaran de coincidir con el código y los commits de su época.

## Consecuencias

- `suplemento-core` sube a `0.14.0` y el runtime Gemini a `0.1.5` (`core_version` 0.14.0).
- Proyectos ya instalados: sin migración de archivos; conviene cambiar `listeilor` por `keepit` en su `CLAUDE.md`/`GEMINI.md`. El alias cubre el intervalo.
- Mientras exista el alias hay dos palabras que disparan el cierre. Retirar `listeilor.md` es una decisión futura, pendiente de que los proyectos del autor migren.
- **Actualización (2026-10-06):** el alias se retiró ese mismo día, junto con `checkpoint`, en 0.15.0 (ver DEP-001).
- El ítem 7 de `SPEC.md` (desfase "pasos 1 a 7" en Gemini) sigue abierto y ahora se refiere a `keepit`.

## Commit

Ver entrada "Sesión — 2026-10-06 — `keepit` reemplaza a `listeilor` (0.14.0)" en `brain/sesiones.md`.
