# Madurez de funciones web — regla de inclusión y estado (noviembre de 2026)

> **Fuentes y licencias:** estado de compatibilidad tomado de las declaraciones de las guías de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, Apache-2.0) y **contrastado** con tres bases abiertas: **web-features** 3.46.0 (estado Baseline; Apache-2.0), **MDN browser-compat-data** 8.1.9 (versiones por navegador; CC0-1.0) y los datos de **Can I use** (caniuse.com, instantánea del 2026-11-11; CC BY 4.0, por Alexis Deveria y colaboradores). **Cambios:** se agruparon por estado, se tradujeron los encabezados y se resumieron los navegadores a su versión mínima. Detalle en `NOTICE.md`. Sin respaldo de los autores originales.

## Regla de inclusión (decisión del autor, ADR-023)

1. **Se recomienda por defecto lo que es Baseline "widely available"** (ya en los tres motores desde hace al menos 30 meses).
2. **Lo "newly available"** (los tres motores, pero reciente) se usa **con una alternativa** si el proyecto lo exige; el uso global de Can I use, cuando existe, ayuda a decidir.
3. **Las funciones que soportan solo uno o dos motores no se usan como base ni se recomiendan en estas listas.** Si una guía externa las propone, tratarlas como mejora progresiva opcional (la página funciona sin ellas) y no como solución. Ejemplos de las que más probablemente sugiera un modelo: Anchor positioning, focusgroup, Interest invokers, scroll-target-group, Sanitizer API, Temporal, Scheduler API, Speculation rules, @function, calc-size(), interpolate-size, popover="hint", <dialog closedby>, moveBefore().
4. Los motores son tres: Chromium (Chrome y Edge), Gecko (Firefox) y WebKit (Safari). Que dos navegadores compartan motor no cuenta como dos.
5. **Las cabeceras defensivas que un navegador sin soporte ignora** no cuentan como funcionalidad de la que se dependa, pero igualmente solo se recomiendan las de los tres motores.

**Cómo está hecha esta tabla.** Las 159 funciones que las guías declaran se cruzaron por nombre con `web-features`: **las 146 funciones con nombre propio coinciden al 100 %** con su estado actual (las otras 13 son subcapacidades que apuntan a la función madre). Para las funciones que la skill cita pero las guías no declaran (APIs de JavaScript, cabeceras, selectores), el estado viene directamente de `web-features`. La columna de uso global sale de Can I use cuando la función figura allí; **muchas funciones recientes (por ejemplo `popover`, `inert`, `light-dark()`, `@starting-style`) no están en el archivo de datos de Can I use** (su README indica que parte de la web usa BCD), así que esa celda queda en "—".

**Esta tabla envejece.** Una función "newly" pasa a "widely" a los 30 meses; verificar en MDN o Baseline antes de apoyarse en una. Para regenerarla: descargar esas tres bases (versiones indicadas arriba), cruzar por nombre y exportar.

## Ampliamente disponibles (widely) — 68 funciones

| Función | Baseline desde | Versión mínima (Chrome · Firefox · Safari) | Uso global con soporte (Can I use) |
|---|---|---|---|
| :focus-visible | 2022-03-14 | Chrome 86 · Firefox 85 · Safari 15.4 | 96,6 % |
| :has() | 2023-12-19 | Chrome 105 · Firefox 121 · Safari 15.4 | 96,1 % |
| :is() | 2021-01-21 | Chrome 88 · Firefox 82 · Safari 14 | — |
| :user-valid and :user-invalid | 2023-11-02 | Chrome 119 · Firefox 88 · Safari 16.5 | — |
| :where() | 2021-01-21 | Chrome 88 · Firefox 82 · Safari 14 | — |
| <details> | 2020-01-15 | Chrome 12 · Firefox 49 · Safari 6 | 97,4 % |
| <dialog> | 2022-03-14 | Chrome 37 · Firefox 98 · Safari 15.4 | 97,3 % |
| <input> | 2015-07-29 | Chrome 1 · Firefox 1 · Safari 1 | — |
| <picture> | 2016-03-21 | Chrome 38 · Firefox 38 · Safari 9.1 | 97,4 % |
| <search> | 2023-10-13 | Chrome 118 · Firefox 118 · Safari 17 | — |
| AbortController and AbortSignal | 2019-03-25 | Chrome 66 · Firefox 57 · Safari 12.1 | 97,3 % |
| AbortSignal.any() | 2024-03-19 | Chrome 116 · Firefox 124 · Safari 17.4 | — |
| AbortSignal.timeout() | 2024-04-18 | Chrome 124 · Firefox 100 · Safari 16 | — |
| ARIA attribute reflection | 2023-10-24 | Chrome 103 · Firefox 119 · Safari 16.4 | — |
| Array by copy | 2023-07-04 | Chrome 110 · Firefox 115 · Safari 16 | — |
| Array grouping | 2024-03-05 | Chrome 117 · Firefox 119 · Safari 17.4 | — |
| Autonomous custom elements | 2020-01-15 | Chrome 54 · Firefox 63 · Safari 10.1 | 81,2 % (+16,1 % parcial) |
| AVIF | 2024-01-25 | Chrome 85 · Firefox 113 · Safari 16.4 | 96,7 % |
| Cascade layers | 2022-03-14 | Chrome 99 · Firefox 97 · Safari 15.4 | 97,1 % |
| color-scheme | 2022-02-03 | Chrome 98 · Firefox 96 · Safari 13 | — |
| Container queries (size) | 2023-02-14 | Chrome 105 · Firefox 110 · Safari 16 | 96,0 % |
| Content Security Policy (CSP) | 2016-08-02 | Chrome 25 · Firefox 23 · Safari 7 | 97,4 % |
| Cookies | 2015-07-29 | Chrome 1 · Firefox 1 · Safari 1 | — |
| CORS | 2015-07-29 | Chrome 4 · Firefox 3.5 · Safari 4 | 97,6 % |
| Declarative shadow DOM | 2024-02-20 | Chrome 111 · Firefox 123 · Safari 16.4 | 95,2 % (+1,2 % parcial) |
| Email, telephone, and URL <input> types | 2015-07-29 | Chrome 5 · Firefox 4 · Safari 5 | 97,6 % |
| enterkeyhint | 2021-11-02 | Chrome 77 · Firefox 94 · Safari 13.1 | — |
| Error cause | 2021-09-20 | Chrome 93 · Firefox 91 · Safari 15 | — |
| Form-associated custom elements | 2023-03-27 | Chrome 77 · Firefox 98 · Safari 16.4 | — |
| Gradients | 2015-07-29 | Chrome 26 · Firefox 3.6 · Safari 7 | — |
| HTTP Strict Transport Security | 2015-07-29 | Chrome 4 · Firefox 4 · Safari 7 | 97,6 % |
| image-set() | 2023-09-18 | Chrome 113 · Firefox 89 · Safari 17 | — |
| Import maps | 2023-03-27 | Chrome 89 · Firefox 108 · Safari 16.4 | 96,8 % |
| Individual transform properties | 2022-08-05 | Chrome 104 · Firefox 72 · Safari 14.1 | — |
| inert | 2023-04-11 | Chrome 102 · Firefox 112 · Safari 15.5 | — |
| inputmode | 2021-12-07 | Chrome 66 · Firefox 95 · Safari 12.1 | 97,3 % |
| Intersection observer | 2019-03-25 | Chrome 58 · Firefox 55 · Safari 12.1 | 97,4 % |
| Keyboard events | 2015-07-29 | Chrome 1 · Firefox 6 · Safari 1.2 | — |
| Lazy-loading images and iframes | 2023-12-19 | Chrome 77 · Firefox 121 · Safari 16.4 | 96,7 % |
| linear() easing | 2023-12-11 | Chrome 113 · Firefox 112 · Safari 17.2 | — |
| Logical properties | 2021-09-20 | Chrome 89 · Firefox 66 · Safari 15 | 97,1 % |
| Masks | 2023-12-07 | Chrome 120 · Firefox 53 · Safari 15.4 | 94,4 % (+3,0 % parcial) |
| MutationObserver | 2015-07-29 | Chrome 26 · Firefox 14 · Safari 7 | 97,6 % |
| Nesting | 2023-12-11 | Chrome 120 · Firefox 117 · Safari 17.2 | 93,4 % (+1,4 % parcial) |
| overflow: clip | 2022-09-12 | Chrome 90 · Firefox 81 · Safari 16 | — |
| paint-order | 2024-03-22 | Chrome 123 · Firefox ≤66 · Safari ≤12 | — |
| prefers-color-scheme media query | 2020-01-15 | Chrome 76 · Firefox 67 · Safari 12.1 | 97,3 % |
| prefers-reduced-motion media query | 2020-01-15 | Chrome 74 · Firefox 63 · Safari 10.1 | 97,3 % |
| Promise.withResolvers() | 2024-03-05 | Chrome 119 · Firefox 121 · Safari 17.4 | — |
| Referrer policy | 2021-09-20 | Chrome 85 · Firefox 87 · Safari 15 | 97,4 % |
| Resize observer | 2020-07-28 | Chrome 64 · Firefox 69 · Safari 13.1 | 97,3 % |
| Scroll snap | 2020-01-15 | Chrome 69 · Firefox 68 · Safari 11 | 97,3 % |
| scroll-behavior | 2022-03-14 | Chrome 61 · Firefox 36 · Safari 15.4 | 97,3 % |
| Shadow DOM | 2020-01-15 | Chrome 53 · Firefox 63 · Safari 10 | 97,4 % |
| Shadow parts | 2020-07-28 | Chrome 73 · Firefox 72 · Safari 13.1 | — |
| Small, large, and dynamic viewport units | 2022-12-05 | Chrome 108 · Firefox 101 · Safari 15.4 | 96,1 % |
| structuredClone() | 2022-03-14 | Chrome 98 · Firefox 94 · Safari 15.4 | — |
| Subgrid | 2023-09-15 | Chrome 117 · Firefox 71 · Safari 16 | 94,7 % |
| Subresource integrity | 2018-04-30 | Chrome 46 · Firefox 51 · Safari 11.1 | 97,4 % |
| SVG | 2020-01-15 | Chrome 1 · Firefox 3 · Safari 3 | — |
| SVG filters | 2015-07-29 | Chrome 5 · Firefox 3 · Safari 6 | 97,6 % |
| Text encoding and decoding | 2020-01-15 | Chrome 38 · Firefox 19 · Safari 10.1 | — |
| Text stroke and fill  (compatibility prefixes) | 2017-04-05 | Chrome 4 · Firefox 49 · Safari 3 | — |
| Web animations | 2020-09-16 | Chrome 84 · Firefox 75 · Safari 14 | 97,2 % |
| Web authentication | 2021-09-07 | Chrome 67 · Firefox 60 · Safari 13 | 94,8 % (+2,5 % parcial) |
| Web Cryptography | 2017-09-19 | Chrome 37 · Firefox 34 · Safari 11 | 97,4 % |
| WebP | 2020-09-16 | Chrome 32 · Firefox 65 · Safari 14 | 97,2 % |
| X-Frame-Options | 2015-07-29 | Chrome 4 · Firefox 4 · Safari 4 | — |

## Recién disponibles (newly) — 42 funciones

Los tres motores, con alternativa si el proyecto lo exige.

| Función | Baseline desde | Versión mínima (Chrome · Firefox · Safari) | Uso global con soporte (Can I use) |
|---|---|---|---|
| ::details-content | 2025-09-16 | Chrome 131 · Firefox 143 · Safari 18.4 | — |
| @scope | 2026-03-24 | Chrome 143 · Firefox 146 · Safari 26.4 | 93,2 % |
| @starting-style | 2024-08-06 | Chrome 117 · Firefox 129 · Safari 17.5 | — |
| abs() and sign() | 2025-06-26 | Chrome 138 · Firefox 118 · Safari 15.4 | — |
| Active view transition | 2026-01-13 | Chrome 125 · Firefox 147 · Safari 18.2 | — |
| Alt text for generated content | 2024-07-09 | Chrome 77 · Firefox 128 · Safari 17.4 | — |
| ariaNotify() | 2026-09-14 | Chrome 141 · Firefox 150 · Safari 27 | — |
| Async clipboard | 2024-06-11 | Chrome 76 · Firefox 127 · Safari 13.1 | 96,8 % |
| autocorrect | 2026-09-11 | Chrome 153 · Firefox 136 · Safari 14.1 | — |
| Container style queries | 2026-05-19 | Chrome 111 · Firefox 151 · Safari 18 | 1,8 % (+91,3 % parcial) |
| content-visibility | 2025-09-15 | Chrome 108 · Firefox 130 · Safari 26 | 95,2 % |
| contrast-color() | 2026-04-10 | Chrome 147 · Firefox 146 · Safari 26 | — |
| CSP violation reports | 2026-03-24 | Chrome 74 · Firefox 149 · Safari 18.4 | — |
| Custom highlights | 2026-03-24 | Chrome 105 · Firefox 149 · Safari 17.2 | — |
| Event timing performance entries | 2025-12-12 | Chrome 76 · Firefox 89 · Safari 26.2 | — |
| Fetch priority | 2024-10-29 | Chrome 103 · Firefox 132 · Safari 17.2 | — |
| field-sizing | 2026-06-16 | Chrome 123 · Firefox 152 · Safari 26.2 | — |
| font-size-adjust | 2024-07-25 | Chrome 127 · Firefox 118 · Safari 17 | 89,8 % |
| Intl.DurationFormat | 2025-03-04 | Chrome 129 · Firefox 136 · Safari 16.4 | — |
| Invoker commands | 2025-12-12 | Chrome 135 · Firefox 144 · Safari 26.2 | — |
| light-dark() | 2024-05-13 | Chrome 123 · Firefox 120 · Safari 17.5 | — |
| light-dark() image values | 2026-09-14 | Chrome 150 · Firefox 150 · Safari 27 | — |
| Mutually exclusive <details> elements | 2024-09-03 | Chrome 120 · Firefox 130 · Safari 17.2 | — |
| Navigation API | 2026-01-13 | Chrome 102 · Firefox 147 · Safari 26.2 | — |
| Popover | 2025-01-27 | Chrome 116 · Firefox 125 · Safari 17 | — |
| progress() | 2026-09-01 | Chrome 138 · Firefox 155 · Safari 26 | — |
| Registered custom properties | 2024-07-09 | Chrome 85 · Firefox 128 · Safari 16.4 | — |
| Relative colors | 2024-09-16 | Chrome 125 · Firefox 128 · Safari 18 | 88,5 % (+5,3 % parcial) |
| revert-rule | 2026-09-14 | Chrome 148 · Firefox 150 · Safari 27 | — |
| Scroll-driven animations | 2026-10-27 | Chrome 115 · Firefox 159 · Safari 26 | — |
| scrollbar-color | 2025-12-12 | Chrome 121 · Firefox 64 · Safari 26.2 | — |
| scrollbar-gutter | 2024-12-11 | Chrome 94 · Firefox 97 · Safari 18.2 | — |
| scrollbar-width | 2024-12-11 | Chrome 121 · Firefox 64 · Safari 18.2 | — |
| scrollend | 2025-12-12 | Chrome 114 · Firefox 109 · Safari 26.2 | — |
| sibling-count() and sibling-index() | 2026-08-18 | Chrome 138 · Firefox 154 · Safari 26.2 | — |
| text-decoration-skip-ink: all | 2026-05-07 | Chrome 148 · Firefox 75 · Safari 15.4 | — |
| text-wrap: balance | 2024-05-13 | Chrome 114 · Firefox 121 · Safari 17.5 | 89,3 % (+4,6 % parcial) |
| Top-level await | 2026-09-14 | Chrome 89 · Firefox 89 · Safari 27 | — |
| transition-behavior | 2024-08-06 | Chrome 117 · Firefox 129 · Safari 17.4 | — |
| Trusted types | 2026-02-24 | Chrome 83 · Firefox 148 · Safari 26 | 92,5 % |
| View transitions | 2025-10-14 | Chrome 111 · Firefox 144 · Safari 18 | 93,2 % |
| view-transition-class | 2025-10-14 | Chrome 125 · Firefox 144 · Safari 18.2 | — |
