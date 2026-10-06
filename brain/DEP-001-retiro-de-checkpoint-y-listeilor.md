# DEP-001 — Retiro de los comandos `checkpoint` y `listeilor`

**Estado:** Vigente
**Fecha:** 2026-10-06

## Qué se retira

- `plugins/suplemento-core/commands/checkpoint.md` — alias deprecado desde 0.12.0 (ADR-008): avisaba del cambio y ejecutaba `ward`.
- `plugins/suplemento-core/commands/listeilor.md` — alias deprecado desde 0.14.0 (ADR-010): avisaba del cambio y ejecutaba `keepit`.

Versión: `suplemento-core` 0.15.0; runtime Gemini 0.1.6.

## Por qué

1. Los aliases existían para no romper proyectos ya instalados. No hay forma de saber si alguien más usa el repo; en la práctica los proyectos afectados son los del autor, que los actualiza a mano.
2. Mantener dos nombres viejos por cada comando obliga a duplicar avisos (colisión, tablas, glosario) y mantiene vivas palabras que el autor ya no quiere usar.
3. El costo de retirarlos es bajo: `documentation-convention` sigue indicando el comando vigente si el humano dice una palabra antigua.

## Qué se conserva

- El aviso de colisión sigue buscando `checkpoint` y `listeilor` locales (`.claude/commands/`, `.claude/skills/`): un `checkpoint.md` heredado suele seguir el modelo viejo que acumula en `SPEC.md` (INT-001).
- La guía `references/migracion-0.12.md` y el glosario conservan las referencias históricas.

## Consecuencias

- **Cambio incompatible** para quien aún use `checkpoint` o `listeilor` como comando: deben pasar a `ward` y `keepit`.
- Sin plazo de transición: el autor decidió retirarlos de inmediato en lugar de esperar 4 a 6 semanas.

## Commit

Ver entrada "Sesión — 2026-10-06 — retiro de `checkpoint` y `listeilor` (0.15.0)" en `brain/sesiones.md`.
