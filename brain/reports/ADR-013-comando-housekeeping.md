# ADR-013 — Comando `housekeeping`: lint de documentación con informe y aprobación

**Estado:** Vigente
**Fecha:** 2026-11-17

## Contexto

Con el tamaño de `SPEC.md` como aviso (ADR-011) y el registro por umbral (ADR-012), la limpieza dejó de hacerse en cada commit. El autor pidió un lugar para hacerla con calma después de una sesión intensa de oficina, y para que cupieran allí otras tareas diferidas (revisar skills externas, actualizar el runtime Gemini). También citó la recomendación de Anthropic de hacer lint durante las sesiones para no almacenar más datos de los útiles.

## Decisión

1. **Nuevo comando `housekeeping`** en el núcleo (`commands/housekeeping.md`).
2. **Informe y aprobación:** revisa en solo lectura, muestra hallazgos numerados (marcados "mecánico" o "requiere criterio") y aplica solo lo que el humano apruebe. Commit local, sin push.
3. **Alcance:** `SPEC.md` y `spec/`; `brain/` y `sesiones.md`; plugin, docs y runtimes. Las herramientas externas (claude-mem) quedan fuera por ahora.
4. **Lo dispara solo el humano**; no es un paso de `ward` ni de `keepit`.
5. Runtime Gemini: el comando se traduce después (ítem 16 de `SPEC.md`).

## Alternativas descartadas

- **Aplicar lo seguro y preguntar lo dudoso:** más rápido, pero con riesgo de cambios inesperados sobre archivos que el agente carga en cada sesión.
- **Solo informe:** deja la aplicación de los cambios a otra sesión.
- **Incluir herramientas externas:** toca archivos fuera del repo; se puede sumar más adelante.

## Consecuencias

- Hay un lugar explícito para condensar y ordenar sin presión de tiempo; el costo es un comando más que recordar.
- Los ítems 15 y 16 de `SPEC.md` se resuelven en un `housekeeping`.
- La primera ejecución real requiere actualizar el plugin instalado (hoy 0.15.0) y reiniciar Claude Code; el comando no existe todavía en la copia instalada.

## Commit

Ver entrada "Sesión — 2026-11-17 — comando `housekeeping`" en `brain/sesiones.md`.
