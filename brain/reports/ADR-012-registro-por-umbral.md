# ADR-012 — Registro de `brain/` y `SPEC.md` por umbral

**Estado:** Vigente (reemplaza la regla "Code nunca decide por su cuenta" de `documentation-convention`; `keepit` sigue obligatorio)
**Fecha:** 2026-11-17

## Contexto

La regla vigente (ADR-008) difería todo registro hasta un `ward` explícito del humano o `keepit`, y prohibía que Code lo decidiera. Se adoptó tras ver que el registro inmediato generaba commits demasiado granulares. El autor pidió más libertad: cuando una tarea grande deja conocimiento nuevo, Code debería poder registrar sin esperar la palabra `ward`, con criterio según el tamaño de lo aprendido. `ward` sigue disponible para salir a una reunión o respaldar por si acaso.

## Decisión

1. **Nuevo modo `registro: umbral`, por defecto.** Los modos `diferido` (estricto) e `inmediato` siguen disponibles por proyecto.
2. **Umbral:** al terminar una tarea (nunca a mitad de la codificación), Code ejecuta el procedimiento de `ward` si se cumple al menos uno: cerró un ítem de la §3 o se acordaron ítems nuevos; se tomó una decisión que merece ADR/INT/NOC/DEP/REF; se aprendió algo que no se recupera leyendo el código ni `git log`.
3. **Cómo:** commit local, **sin push**; el resumen del paso 7 se informa después, en una línea con el hash y cómo revertir (`git reset --soft HEAD~1`). Ante duda de categoría o contenido posiblemente sensible, pregunta antes de escribir. Lo que el humano pide no registrar, no se registra.
4. **El push sigue siendo solo de `keepit`**, que sigue siendo obligatorio al cerrar sesión.
5. Runtime Gemini: se actualiza después (ítem 16 de `SPEC.md`).

## Alternativas descartadas

- **Proponer y esperar un sí** en cada caso: mantiene una pausa por registro.
- **Autonomía solo para lo mecánico:** las decisiones seguirían esperando; se prefirió el umbral único con pregunta previa solo en caso de duda.

## Consecuencias

- Menos ejecuciones manuales de `ward`; más commits de documentación que el humano no pidió, mitigados por el aviso posterior y la reversión con `git reset --soft`.
- El criterio depende del juicio de Code: si se vuelve demasiado frecuente o escaso, ajustar el umbral o volver a `registro: diferido` en el proyecto.

## Commit

Ver entrada "Sesión — 2026-11-17 — registro por umbral" en `brain/sesiones.md`.
