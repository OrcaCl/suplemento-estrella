# ADR-022 — Guías de frontend ampliadas a todas las categorías de la fuente

**Estado:** Vigente (amplía el alcance de la ADR-021; el resto de la ADR-021 sigue)
**Fecha:** 2026-11-18

## Contexto

La ADR-021 adaptó solo accesibilidad, formularios y componentes de interfaz de *Modern Web Guidance* (Apache-2.0) y dejó el resto sin leer. El autor pidió revisar todas las demás categorías para no depender del plugin externo, con tiempo y recursos disponibles.

## Decisión

1. **Se leyeron todas las categorías** de la fuente: CSS, diseño visual, rendimiento, HTML, JavaScript, seguridad, privacidad, experiencia de usuario, comportamientos de interfaz, átomos de UI, las 18 guías específicas de formularios, PWA, IA integrada en el navegador, WebMCP y WebAssembly. La lectura fue **por capas**, no línea por línea: las guías maestras de cada categoría se leyeron completas en sus reglas y las específicas por descripción y reglas destacadas (unos 1,5 MB en total).
2. **Se adaptaron** (con redacción propia, atribución, indicación de cambios y copia de la licencia) a `frontend-conventions/references/`: `css-y-diseno.md`, `rendimiento.md`, `html-y-js.md`, `comportamientos.md` y `madurez-funciones.md`, y se ampliaron `formularios.md`; y a `seguridad-por-diseno/references/`: `seguridad-web-navegador.md` (cabeceras HTTP, cookies, XSS en el DOM, passkeys y privacidad), que cubre un vacío de la skill de seguridad.
3. **`madurez-funciones.md` es una tabla de 159 funciones** (36 "widely", 48 "newly", 75 de disponibilidad limitada) tomada de las declaraciones de compatibilidad de las guías. Es una instantánea de noviembre de 2026 y debe verificarse en MDN o Baseline.
4. **No se adaptaron** (decisión de alcance, no de calidad): IA integrada en el navegador, WebMCP, WebAssembly, PWA y los efectos visuales de nicho; ni los patrones de scroll, parallax y gestos más especializados (listados en `comportamientos.md`).
5. **Corrección de un consejo anterior:** se había recomendado el posicionamiento por anclaje de CSS sin reservas; las guías lo declaran de disponibilidad limitada (Chrome y Edge 157, Safari 27).

## Alternativas descartadas

- **Copiar todas las guías al plugin:** se desactualizan y son 1,5 MB de contenido que casi no se usaría.
- **Adaptar solo lo ya leído:** deja sin cubrir la seguridad del navegador, el rendimiento y CSS moderno, que son de uso diario.

## Consecuencias

- Cinco archivos de referencia nuevos en `frontend-conventions` y uno en `seguridad-por-diseno`, todos con atribución Apache-2.0; hay que mantener esa atribución al actualizarlos.
- **Las listas envejecen** (sobre todo la tabla de madurez): revisarlas en un `housekeeping` o con `ketchup` (ítem 26).
- La lectura por capas puede haber pasado por alto matices de guías específicas; ante la duda, la fuente original manda.

## Commit

Ver entrada "Sesión — 2026-11-18 — guías propias de frontend ampliadas a todas las categorías" en `brain/sesiones.md`.
