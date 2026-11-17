# ADR-011 — Tamaño de `SPEC.md`: criterio orgánico, solo avisos

**Estado:** Vigente (reemplaza la parte de tope duro de ADR-006 y ADR-008; el resto de ambos sigue)
**Fecha:** 2026-11-17

## Contexto

ADR-006 y ADR-008 fijaron tres reglas duras sobre `SPEC.md`: tope de 1000 líneas, ninguna línea de más de 600 caracteres, y una lista de chequeo obligatoria que podía impedir el commit. El autor pidió que fuera más orgánico: los avances, pendientes y cerrados ya tienen archivos propios (`brain/sesiones.md`, `spec/cerrados.md`), así que la necesidad real de escribir en `SPEC.md` es la que debe medir el tamaño, no un contador de columnas. También pidió que no fuera un error duro: solo un aviso.

## Decisión

1. **Se elimina la regla de 600 caracteres por línea** (también el "≤ 600" de las filas "Sesión anterior").
2. **Las 1000 líneas (`spec_tope_lineas`) pasan a ser una referencia que solo avisa** al llegar al 80 % o superarla, al leer el archivo y antes del commit. Nunca bloquea un commit.
3. **El criterio es la pregunta del árbitro de destino:** ¿esto lo necesita el agente al abrir la sesión? Si no, va a `brain/sesiones.md`, `spec/cerrados.md` o `brain/`.
4. **La lista de `ward`/`keepit` queda solo para consistencia** (filas de sesión, footer con la versión de la cabecera, pendientes solo en §3, IDs sin duplicar), porque eso es un error de contenido y no de tamaño.
5. Esta decisión se aplica en el runtime de Claude Code. El runtime Gemini se actualiza después (ítem 16 de `SPEC.md`).

## Alternativas descartadas

- **Sin ningún número:** el archivo podría degradarse sin que nada avise. Se conserva la referencia de líneas como aviso.
- **Solo suavizar la regla de 600:** deja el tope de 1000 como freno duro, que el autor quería quitar.

## Consecuencias

- Menos fricción en `ward` y `keepit`; el costo es que el control depende más del criterio de Code y del humano.
- Si `SPEC.md` vuelve a degradarse en uso real, reabrir la decisión (ítem 3 de `SPEC.md`).
- Los proyectos instalados que declaren `spec_tope_lineas` siguen funcionando: la clave ahora es una referencia.

## Commit

Ver entrada "Sesión — 2026-11-17 — criterio orgánico de tamaño de `SPEC.md`" en `brain/sesiones.md`.
