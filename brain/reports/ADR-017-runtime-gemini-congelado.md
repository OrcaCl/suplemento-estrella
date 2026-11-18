# ADR-017 — Runtime Gemini congelado

**Estado:** Vigente (congelado; el retiro formal queda por confirmar)
**Fecha:** 2026-11-18

## Contexto

El autor trabaja con Claude Code y prefiere ese entorno; la cuenta de Gemini que se usó para probar el runtime es compartida y tiene el mismo problema de reparto de tokens. Mantener la paridad del runtime Gemini cuesta trabajo en cada cambio del núcleo (ya había cuatro cambios acumulados sin traducir) y no se está usando.

## Decisión

1. **El runtime `runtimes/gemini-antigravity/` queda congelado desde 2026-11-18:** no se actualiza ni se mantiene en paridad con el núcleo. Se queda en el repositorio, en la versión `0.1.6` con `core_version` `0.15.0`.
2. **Se cancelan los pendientes que lo mencionaban:** los ítems 7 y 16 de `SPEC.md` y el punto del ítem 20 sobre el equivalente en Gemini.
3. **El instalador y el README siguen disponibles**, con un aviso de que el runtime no se mantiene y puede estar desactualizado respecto al núcleo (incluidos `ward`/`keepit`, `housekeeping`, el registro por umbral y la skill de seguridad).
4. **El retiro formal** (borrar el runtime y registrarlo como `DEP`) queda pendiente de que el autor lo confirme; se reevalúa si vuelve a necesitar Gemini.

## Alternativas descartadas

- **Mantener la paridad:** trabajo continuo sin uso real.
- **Retirarlo ahora:** el autor lo dijo en condicional ("dejaría de mantenerlo"); se prefirió una medida reversible.

## Consecuencias

- Las ADR 011 a 015 mencionan "Gemini pendiente (ítem 16)"; esa parte queda sin efecto por esta decisión.
- La política de versionado por capas (ADR-001) sigue vigente, pero la capa Gemini no avanza.
- Quien instale el runtime Gemini recibe reglas anteriores al núcleo actual, sin seguridad por diseño.

## Commit

Ver entrada "Sesión — 2026-11-18 — runtime Gemini congelado" en `brain/sesiones.md`.
