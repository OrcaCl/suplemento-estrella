# ADR-009 — `code-comment-convention`: el código fuente como tercera capa de conocimiento

**Estado:** Vigente
**Fecha:** 2026-10-06

## Contexto

Hasta 0.12.0 la metodología dirigía dónde vive el conocimiento fuera del código — `brain/` para el desarrollador, `SPEC.md` y `spec/` para el agente — pero **no decía nada sobre los comentarios dentro del código**. Cada sesión decidía por su cuenta qué documentar y qué limpiar.

El caso que lo hizo evidente: el autor pidió limpiar los comentarios de un proyecto real (ExtJS + Supabase) y se eliminaron **todos**, incluidos los que explicaban el porqué de decisiones, workarounds del framework y dependencias con las políticas RLS. El código quedó más difícil de leer en los ajustes rápidos: para recuperar un "por qué" había que ir a Brain KMS o pedirle a Code que leyera `SPEC.md`, cuando la respuesta debería estar a la vista, en el mismo código.

**Opciones evaluadas:**
1. Una línea en `documentation-convention` o `code-simplicity` ("no borrar comentarios útiles").
2. Una skill propia con criterio de clasificación, jerarquía de niveles y regla de no destrucción.
3. No hacer nada y resolverlo caso a caso en el `CLAUDE.md` de cada proyecto.

## Decisión

Se adopta la opción 2, con estas piezas:

1. **Nueva skill `code-comment-convention`** (Claude Code, `suplemento-core` 0.13.0; Gemini, `14-code-comment-convention.md`, runtime 0.1.4). Principio: *el código explica QUÉ y CÓMO; los comentarios explican POR QUÉ.* Incluye una **regla de no destrucción** (clasificar antes de eliminar un comentario; una limpieza no es una eliminación masiva), la jerarquía de documentación por nivel y el significado distinto de `TODO`/`FIXME`/`HACK`/`NOTE`.
2. **El ejemplo ExtJS + Supabase se conserva** en la skill (como ejemplo de aplicación, no como restricción de stack): es el origen del problema, y mostrar un caso real de por qué un comentario no debe borrarse enseña más que una regla abstracta.
3. **`project-init` la incluye** en los proyectos nuevos: sección `## Comentarios en el código` en `CLAUDE.md` / `GEMINI.md`.
4. **Proyectos ya instalados: oferta única, no migración automática.** Actualizar el plugin no modifica el `CLAUDE.md` del proyecto; `ward` y `listeilor` (paso 0a) ofrecen agregar la sección una sola vez. Si el humano rechaza, queda constancia en el `CLAUDE.md` y no se vuelve a ofrecer. Es opcional y no exige tocar código existente.

## Razones

1. **Completa un modelo de tres capas** que antes tenía un hueco: Brain KMS (la evolución y las decisiones del proyecto, para el desarrollador), `SPEC.md` (el contexto en "lenguaje agente") y el código fuente (contexto local, legible de un vistazo para ambos). Cada tipo de conocimiento vive en el nivel que le corresponde, y la skill define qué se queda en el código.
2. La opción 1 no alcanza: la falla fue de criterio, no de olvido; hace falta una forma de clasificar. La opción 3 deja el problema a la memoria de cada proyecto, que es justo lo que falló.
3. Un agente que limpia por cantidad o longitud destruye conocimiento que no puede recuperarse del código. La regla de no destrucción cambia la pregunta de "¿es necesario este comentario?" a "¿qué conocimiento se perdería si lo elimino?".
4. La oferta única respeta la autonomía del proyecto: la convención es nueva y opinada, y no todo proyecto existente querrá adoptarla.
5. La skill no duplica lo que ya existe: `documentation-convention` decide *cuándo* registrar, `spec-driven-development` *dónde* vive la especificación, `brain-kms` *cómo* se preserva el conocimiento; esta decide *qué permanece en el código*.

## Consecuencias

- `suplemento-core` sube a `0.13.0` y el runtime Gemini a `0.1.4` (`core_version` 0.13.0); 14 skills en cada runtime.
- `ward` y `listeilor` ganan un paso 0a (oferta de la convención). En un proyecto que la rechazó queda una línea de constancia en `CLAUDE.md`/`GEMINI.md`.
- La skill es hoy más detallada para JavaScript/ExtJS/Supabase que para otros stacks. Si aparecen proyectos en otros lenguajes, conviene ampliar los ejemplos (PHPDoc, docstrings) sin quitar los existentes.
- La convención rige hacia adelante: no hay una pasada masiva de comentarios sobre código existente.
- Guía de migración para proyectos instalados: `plugins/suplemento-core/skills/code-comment-convention/references/migracion-0.13.md`.

## Commit

Ver entrada "Sesión — 2026-10-06 — `code-comment-convention`: el código como tercera capa (0.13.0)" en `brain/sesiones.md`. Cambios de código en el commit `cefb21c`.
