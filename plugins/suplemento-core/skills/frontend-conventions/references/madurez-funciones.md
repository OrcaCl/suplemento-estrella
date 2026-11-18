# Madurez de funciones web — según las guías fuente (noviembre de 2026)

> **Fuente y licencia:** datos tomados de las declaraciones de compatibilidad ("Baseline status" y "Browser support") de las guías de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance), licencia Apache-2.0 (copia en `LICENSE-Apache-2.0.txt`). **Cambios:** se agruparon por estado, se tradujeron los encabezados y se resumieron los navegadores a su versión mínima. Detalle en `NOTICE.md`. Sin respaldo de los autores originales.

**Esta tabla es una instantánea y envejece.** Refleja lo que las guías declaraban al leerlas (noviembre de 2026); el estado "Baseline" cambia con el tiempo (una función "newly" pasa a "widely" a los 30 meses de ser Baseline). Antes de apoyarse en una función, verificar su estado actual en MDN o en Baseline. Solo cubre las funciones que las guías mencionan, no toda la plataforma.

**Cómo leerla**
- **Ampliamente disponible (widely):** se usa sin alternativa.
- **Recién disponible (newly):** Baseline, pero con navegadores antiguos todavía en uso; usar con alternativa si el proyecto lo exige (política de soporte en `CLAUDE.md`).
- **Disponibilidad limitada:** no está en todos los motores; solo como mejora progresiva (la página funciona sin ella) o con un polyfill revisado como cualquier dependencia de terceros.


## Ampliamente disponibles (widely available) — 36 funciones

| Función | Baseline desde | Versión mínima |
|---|---|---|
| :has() | 2023-12-19 | Chrome 105 · Edge 105 · Firefox 121 · Safari 15.4 |
| :user-valid and :user-invalid | 2023-11-02 | Chrome 119 · Edge 119 · Firefox 88 · Safari 16.5 |
| <details> | 2020-01-15 | Chrome 12 · Edge 79 · Firefox 49 · Safari 6 |
| <dialog> | 2022-03-14 | Chrome 37 · Edge 79 · Firefox 98 · Safari 15.4 |
| AbortController and AbortSignal | 2019-03-25 | Chrome 66 · Edge 16 · Firefox 57 · Safari 12.1 |
| ARIA attribute reflection | 2023-10-24 | Chrome 103 · Edge 103 · Firefox 119 · Safari 16.4 |
| Cascade layers | 2022-03-14 | Chrome 99 · Edge 99 · Firefox 97 · Safari 15.4 |
| color-scheme | 2022-02-03 | Chrome 98 · Edge 98 · Firefox 96 · Safari 13 |
| Container queries (size) | 2023-02-14 | Chrome 105 · Edge 105 · Firefox 110 · Safari 16 |
| Declarative shadow DOM | 2024-02-20 | Chrome 111 · Edge 111 · Firefox 123 · Safari 16.4 |
| Email, telephone, and URL <input> types | 2015-07-29 | Chrome 5 · Edge 12 · Firefox 4 · Safari 5 |
| enterkeyhint | 2021-11-02 | Chrome 77 · Edge 79 · Firefox 94 · Safari 13.1 |
| Form-associated custom elements | 2023-03-27 | Chrome 77 · Edge 79 · Firefox 98 · Safari 16.4 |
| image-set() | 2023-09-18 | Chrome 113 · Edge 113 · Firefox 89 · Safari 17 |
| Individual transform properties | 2022-08-05 | Chrome 104 · Edge 104 · Firefox 72 · Safari 14.1 |
| inert | 2023-04-11 | Chrome 102 · Edge 102 · Firefox 112 · Safari 15.5 |
| inputmode | 2021-12-07 | Chrome 66 · Edge 79 · Firefox 95 · Safari 12.1 |
| Intersection observer | 2019-03-25 | Chrome 58 · Edge 16 · Firefox 55 · Safari 12.1 |
| linear() easing | 2023-12-11 | Chrome 113 · Edge 113 · Firefox 112 · Safari 17.2 |
| Masks | 2023-12-07 | Chrome 120 · Edge 120 · Firefox 53 · Safari 15.4 |
| MutationObserver | 2015-07-29 | Chrome 26 · Edge 12 · Firefox 14 · Safari 7 |
| overflow: clip | 2022-09-12 | Chrome 90 · Edge 90 · Firefox 81 · Safari 16 |
| paint-order | 2024-03-22 | Chrome 123 · Edge 123 |
| Resize observer | 2020-07-28 | Chrome 64 · Edge 79 · Firefox 69 · Safari 13.1 |
| Scroll snap | 2020-01-15 | Chrome 69 · Edge 79 · Firefox 68 · Safari 11 |
| scroll-behavior | 2022-03-14 | Chrome 61 · Edge 79 · Firefox 36 · Safari 15.4 |
| Shadow parts | 2020-07-28 | Chrome 73 · Edge 79 · Firefox 72 · Safari 13.1 |
| Small, large, and dynamic viewport units | 2022-12-05 | Chrome 108 · Edge 108 · Firefox 101 · Safari 15.4 |
| Subgrid | 2023-09-15 | Chrome 117 · Edge 117 · Firefox 71 · Safari 16 |
| SVG filters | 2015-07-29 | Chrome 5 · Edge 12 · Firefox 3 · Safari 6 |
| Text stroke and fill  (compatibility prefixes) | 2017-04-05 | Chrome 4 · Edge 15 · Firefox 49 · Safari 3 |
| the api.Clipboard.writeText capability | 2020-03-24 | Chrome 66 · Edge 79 · Firefox 63 · Safari 13.1 |
| the api.HTMLElement.showPopover capability | 2024-04-16 | Chrome 114 · Edge 114 · Firefox 125 · Safari 17 |
| the html.elements.input.autocomplete capability | 2015-07-29 | Chrome 14 · Edge 12 · Firefox 4 · Safari 6 |
| Web animations | 2020-09-16 | Chrome 84 · Edge 84 · Firefox 75 · Safari 14 |
| Web Cryptography | 2017-09-19 | Chrome 37 · Edge 12 · Firefox 34 · Safari 11 |

## Recién disponibles (newly available) — 48 funciones

| Función | Baseline desde | Versión mínima |
|---|---|---|
| ::details-content | 2025-09-16 | Chrome 131 · Edge 131 · Firefox 143 · Safari 18.4 |
| @starting-style | 2024-08-06 | Chrome 117 · Edge 117 · Firefox 129 · Safari 17.5 |
| abs() and sign() | 2025-06-26 | Chrome 138 · Edge 138 · Firefox 118 · Safari 15.4 |
| Active view transition | 2026-01-13 | Chrome 125 · Edge 125 · Firefox 147 · Safari 18.2 |
| Alt text for generated content | 2024-07-09 | Chrome 77 · Edge 79 · Firefox 128 · Safari 17.4 |
| ariaNotify() | 2026-09-14 | Chrome 141 · Edge 141 · Firefox 150 · Safari 27 |
| autocorrect | 2026-09-11 | Chrome 153 · Edge 153 · Firefox 136 · Safari 14.1 |
| Container style queries | 2026-05-19 | Chrome 111 · Edge 111 · Firefox 151 · Safari 18 |
| content-visibility | 2025-09-15 | Chrome 108 · Edge 108 · Firefox 130 · Safari 26 |
| contrast-color() | 2026-04-10 | Chrome 147 · Edge 147 · Firefox 146 · Safari 26 |
| Custom highlights | 2026-03-24 | Chrome 105 · Edge 105 · Firefox 149 · Safari 17.2 |
| Event timing performance entries | 2025-12-12 | Chrome 76 · Edge 79 · Firefox 89 · Safari 26.2 |
| Fetch priority | 2024-10-29 | Chrome 103 · Edge 103 · Firefox 132 · Safari 17.2 |
| field-sizing | 2026-06-16 | Chrome 123 · Edge 123 · Firefox 152 · Safari 26.2 |
| font-size-adjust | 2024-07-25 | Chrome 127 · Edge 127 · Firefox 118 · Safari 17 |
| Intl.DurationFormat | 2025-03-04 | Chrome 129 · Edge 129 · Firefox 136 · Safari 16.4 |
| Invoker commands | 2025-12-12 | Chrome 135 · Edge 135 · Firefox 144 · Safari 26.2 |
| light-dark() | 2024-05-13 | Chrome 123 · Edge 123 · Firefox 120 · Safari 17.5 |
| light-dark() image values | 2026-09-14 | Chrome 150 · Edge 150 · Firefox 150 · Safari 27 |
| Mutually exclusive <details> elements | 2024-09-03 | Chrome 120 · Edge 120 · Firefox 130 · Safari 17.2 |
| Navigation API | 2026-01-13 | Chrome 102 · Edge 102 · Firefox 147 · Safari 26.2 |
| Popover | 2025-01-27 | Chrome 116 · Edge 116 · Firefox 125 · Safari 17 |
| progress() | 2026-09-01 | Chrome 138 · Edge 138 · Firefox 155 · Safari 26 |
| Registered custom properties | 2024-07-09 | Chrome 85 · Edge 85 · Firefox 128 · Safari 16.4 |
| Relative colors | 2024-09-16 | Chrome 125 · Edge 125 · Firefox 128 · Safari 18 |
| revert-rule | 2026-09-14 | Chrome 148 · Edge 148 · Firefox 150 · Safari 27 |
| Scroll-driven animations | 2026-10-27 | Chrome 115 · Edge 115 · Firefox 159 · Safari 26 |
| scrollbar-color | 2025-12-12 | Chrome 121 · Edge 121 · Firefox 64 · Safari 26.2 |
| scrollbar-gutter | 2024-12-11 | Chrome 94 · Edge 94 · Firefox 97 · Safari 18.2 |
| scrollbar-width | 2024-12-11 | Chrome 121 · Edge 121 · Firefox 64 · Safari 18.2 |
| scrollend | 2025-12-12 | Chrome 114 · Edge 114 · Firefox 109 · Safari 26.2 |
| sibling-count() and sibling-index() | 2026-08-18 | Chrome 138 · Edge 138 · Firefox 154 · Safari 26.2 |
| text-decoration-skip-ink: all | 2026-05-07 | Chrome 148 · Edge 148 · Firefox 75 · Safari 15.4 |
| text-wrap: balance | 2024-05-13 | Chrome 114 · Edge 114 · Firefox 121 · Safari 17.5 |
| the api.Element.ariaLabelledByElements capability | 2025-04-04 | Chrome 135 · Edge 135 · Firefox 136 · Safari 16.4 |
| the api.HTMLElement.showPopover.options_source_parameter.implicit_anch | 2026-01-13 | Chrome 137 · Edge 137 · Firefox 147 · Safari 26 |
| the api.PublicKeyCredential.getClientCapabilities_static capability | 2025-02-06 | Chrome 133 · Edge 133 · Firefox 135 · Safari 17.4 |
| the api.PublicKeyCredential.parseCreationOptionsFromJSON_static capabi | 2025-03-31 | Chrome 129 · Edge 129 · Firefox 119 · Safari 18.4 |
| the api.PublicKeyCredential.parseRequestOptionsFromJSON_static capabil | 2025-03-31 | Chrome 129 · Edge 129 · Firefox 119 · Safari 18.4 |
| the api.SubtleCrypto.deriveBits.x25519 capability | 2025-02-06 | Chrome 133 · Edge 133 · Firefox 130 · Safari 17 |
| the api.SubtleCrypto.sign.ed25519 capability | 2025-05-29 | Chrome 137 · Edge 137 · Firefox 129 · Safari 17 |
| the css.types.gradient.linear-gradient.single_color_stop capability | 2025-04-04 | Chrome 135 · Edge 135 · Firefox 136 · Safari 18.4 |
| the html.elements.button.popovertarget.implicit_anchor_reference capab | 2026-01-13 | Chrome 133 · Edge 133 · Firefox 147 · Safari 26 |
| Top-level await | 2026-09-14 | Chrome 89 · Edge 89 · Firefox 89 · Safari 27 |
| transition-behavior | 2024-08-06 | Chrome 117 · Edge 117 · Firefox 129 · Safari 17.4 |
| Trusted types | 2026-02-24 | Chrome 83 · Edge 83 · Firefox 148 · Safari 26 |
| View transitions | 2025-10-14 | Chrome 111 · Edge 111 · Firefox 144 · Safari 18 |
| view-transition-class | 2025-10-14 | Chrome 125 · Edge 125 · Firefox 144 · Safari 18.2 |

## Disponibilidad limitada — 75 funciones

| Función | Navegadores que la soportan |
|---|---|
| :autofill | Chrome 110 · Edge 110 · Safari 15 |
| :host-context() | Chrome 54 · Edge 79 |
| <dialog closedby> | Chrome 134 · Edge 134 · Firefox 141 |
| <input type="checkbox" switch> | Safari 17.4 |
| <meta name="text-scale"> | Chrome 146 · Edge 146 |
| <template for> | Chrome 150 · Edge 150 |
| @function | Chrome 139 · Edge 139 |
| accent-color | Chrome 93 · Edge 93 · Firefox 92 · Safari 26.2 |
| Anchor position container queries | Chrome 143 · Edge 143 |
| Anchor positioning | Chrome 157 · Edge 157 · Safari 27 |
| at-rule() | Chrome 148 · Edge 148 · Firefox 157 |
| attr() | Chrome 133 · Edge 133 · Firefox 155 |
| background-clip: border-area | Chrome 150 · Edge 150 · Safari 18.2 |
| beforeinstallprompt | Chrome 76 · Edge 79 |
| blocking="render" | Chrome 105 · Edge 105 · Safari 18.2 |
| border-shape | Chrome 147 · Edge 147 |
| calc-size() | Chrome 129 · Edge 129 |
| Connection allowlists | Chrome 152 · Edge 152 |
| Container scroll-state queries | Chrome 144 · Edge 144 |
| corner-shape | Chrome 139 · Edge 139 |
| Cross-document view transitions | Chrome 126 · Edge 126 · Safari 18.2 |
| cross-origin() for url() | Chrome 150 · Edge 150 · Safari 26.2 |
| Customizable <select> | Chrome 135 · Edge 135 · Safari 27 |
| Element-scoped view transitions | Chrome 147 · Edge 147 |
| fetchLater | Chrome 135 · Edge 135 |
| flex-wrap: balance | Chrome 150 · Edge 150 |
| focusgroup | Chrome 150 · Edge 150 |
| Grid lanes | Safari 27.2. |
| hidden="until-found" | Chrome 102 · Edge 102 · Firefox 148 |
| HTML processing instructions | Chrome 150 · Edge 150 |
| HTML setter methods | Chrome 157 · Edge 157 |
| HTML-in-canvas | Chrome 157 · Edge 157 |
| integrity() for url() | Chrome 150 · Edge 150 |
| Interaction contentful paint performance entries | Chrome 151 · Edge 151 |
| Interest invokers | Chrome 149 · Edge 149 |
| interpolate-size | Chrome 129 · Edge 129 |
| Language detector | Chrome 138 · Edge 148 |
| LanguageModel | Chrome 148 |
| Lazy-loading media | Chrome 150 · Edge 150 |
| Local network access | Chrome 145 · Edge 145 |
| Long animation frames performance entries | Chrome 123 · Edge 123 |
| moveBefore() | Chrome 133 · Edge 133 · Firefox 144 |
| Origin | Chrome 145 · Edge 145 · Safari 26.5 |
| overflow-clip-margin | Firefox 148 |
| overlay | Chrome 117 · Edge 117 |
| overscroll-behavior | Chrome 144 · Edge 144 · Firefox 150 |
| Page visibility state performance entries | Chrome 115 · Edge 115 |
| Password credentials | Chrome 60 · Edge 79 |
| Permissions policy | Chrome 108 · Edge 108 |
| popover="hint" | Chrome 151 · Edge 151 · Firefox 153 |
| reading-flow | Chrome 137 · Edge 137 |
| referrer-policy() for url() | Chrome 150 · Edge 150 · Safari 26.2 |
| Sanitizer API | Chrome 146 · Edge 146 · Firefox 148 |
| Scheduler API | Chrome 129 · Edge 129 · Firefox 142 |
| Scroll method promises | Chrome 150 · Edge 150 |
| Scroll snap events | Chrome 129 · Edge 129 |
| scroll-axis-lock | Chrome 153 |
| scroll-initial-target | Chrome 133 · Edge 133 |
| scroll-target-group | Chrome 140 · Edge 140 |
| Soft navigation performance entries | Chrome 151 · Edge 151 |
| Speculation rules | Chrome 109 · Edge 109 |
| Summarizer | Chrome 138 · Edge 138 |
| Temporal | Chrome 144 · Edge 144 · Firefox 139 |
| text-box | Chrome 133 · Edge 133 · Safari 18.2 |
| text-fit | Chrome 150 · Edge 150 |
| text-wrap: pretty | Chrome 117 · Edge 117 · Safari 26 |
| the api.KeyboardEvent.isComposing capability | Chrome 56 · Edge 79 · Firefox 31 |
| the css.properties.d capability | Chrome 52 · Edge 79 · Firefox 97 |
| the css.properties.transition-behavior.transitionable_display capabili | Chrome 117 · Edge 117 · Safari 18 |
| Translator | Chrome 138 · Edge 148 |
| user-select | Chrome 54 · Edge 79 · Firefox 69 |
| Web app manifest | Chrome 53 · Edge 79 · Safari 17 · Safari iOS 15.4 |
| Web app origin migration | Chrome 149 · Edge 149 |
| Web authentication signal methods | Chrome 132 · Edge 132 · Safari 26 |
| WebOTP | Chrome 93 · Edge 93 · Safari 27 |
