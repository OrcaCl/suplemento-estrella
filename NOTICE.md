# Avisos de terceros

> Hay una copia de este archivo dentro del plugin (`plugins/suplemento-core/NOTICE.md`), con las rutas relativas al plugin, porque el plugin instalado solo trae esa carpeta. Al cambiar uno, actualizar el otro.

Este repositorio se distribuye bajo la licencia MIT (ver `LICENSE`), **excepto** el material derivado de trabajos de OWASP, que se distribuye bajo **Creative Commons Atribución-CompartirIgual 4.0 (CC BY-SA 4.0)**, https://creativecommons.org/licenses/by-sa/4.0/legalcode.

## Material bajo CC BY-SA 4.0

Los archivos de `plugins/suplemento-core/skills/seguridad-por-diseno/references/` que adaptan material de OWASP:

| Archivo | Obra original | Titular |
|---|---|---|
| `owasp-top10-2025.md` | OWASP Top 10:2025 | OWASP Top 10 Project |
| `asvs-5.md` | OWASP Application Security Verification Standard 5.0.0 | OWASP ASVS Project |
| `agentes-y-datos-owasp.md` | OWASP Top 10 for Agentic Applications 2026; Securing Agentic Applications V2; GenAI Data Security Best Practices v2 (Partes 1 y 2) | OWASP GenAI Security Project |
| `amenazas-y-ssdf.md` | Preguntas de modelado de amenazas de Securing Agentic Applications V2; nombres de NIST SP 800-218 | OWASP GenAI Security Project; NIST |

Cambios realizados: traducidos al español, resumidos y reorganizados con redacción propia, y complementados con reglas para Code como agente. No se copian párrafos completos. Esto no implica respaldo de OWASP. El detalle de cada fuente está en `plugins/suplemento-core/skills/seguridad-por-diseno/references/fuentes-y-licencias.md`.

Quien reutilice esos archivos debe conservar la atribución y compartir lo adaptado bajo la misma licencia.

## Otras referencias

**Bases abiertas de compatibilidad de navegadores** usadas para contrastar y completar `madurez-funciones.md` (ADR-023); sus datos se consultaron, no se redistribuyen en bloque:

| Base | Titular | Licencia | Uso |
|---|---|---|---|
| **Can I use** (caniuse.com; repositorio Fyrd/caniuse, `fulldata-json/data-2.0.json`, instantánea del 2026-11-11) | Alexis Deveria y colaboradores | CC BY 4.0 (atribución: "la fuente es caniuse.com") | Porcentaje de uso global con soporte de cada función, cuando figura en el archivo |
| **MDN browser-compat-data** 8.1.9 (mdn/browser-compat-data) | MDN y colaboradores | CC0-1.0 | Versiones mínimas por navegador (vía `web-features`) |
| **web-features** 3.46.0 (web-platform-dx/web-features) | WebDX Community Group | Apache-2.0 | Estado Baseline de cada función y sus fechas |

**Modern Web Guidance** (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance; mantenido por los equipos de Chrome, Edge, Firefox y MDN con la comunidad): licencia **Apache-2.0**. Se leyeron **todas las categorías de sus guías** (ver ADR-021 y ADR-022) y se adaptaron las útiles para este trabajo, en dos skills:

| Archivo | Guías originales | Cambios |
|---|---|---|
| `skills/frontend-conventions/references/accesibilidad.md` | `accessibility` | Traducida, resumida y reorganizada como lista de verificación; complementada con criterios WCAG señalados como propios |
| `skills/frontend-conventions/references/formularios.md` | `forms` (general y las 18 específicas, estas últimas por descripción y reglas destacadas) | Traducida, resumida y reorganizada; cruzada con las reglas de seguridad del proyecto |
| `skills/frontend-conventions/references/componentes.md` | las 22 de `ui-components` | Traducida y muy resumida (sin ejemplos de código ni estilos); la madurez es la declarada por las guías en noviembre de 2026 |
| `skills/frontend-conventions/references/css-y-diseno.md` | `css`, `color`, `typography`, `dark-mode`, `browser-ui-theming`, `visual-effects`, `responsive-design` | Traducida, resumida y reorganizada; sin ejemplos de código |
| `skills/frontend-conventions/references/html-y-js.md` | `html`, `js`, `web-components` y guías de componentes web | Traducida, resumida y reorganizada; `Temporal` resumido en una regla |
| `skills/frontend-conventions/references/rendimiento.md` | `performance` (general) | Traducida, resumida y reorganizada |
| `skills/frontend-conventions/references/comportamientos.md` | `motion`, `ui-behaviors`, `ui-atoms` | Traducida y muy resumida; se leyó completa solo `motion` |
| `skills/frontend-conventions/references/madurez-funciones.md` | declaraciones de compatibilidad de todas las guías, contrastadas con web-features, BCD y Can I use | Datos agrupados por estado, encabezados traducidos, navegadores resumidos a su versión mínima y solo funciones de los tres motores |
| `skills/seguridad-por-diseno/references/seguridad-web-navegador.md` | `security` (general y específicas) y `privacy` | Traducida, resumida y reorganizada; sin ejemplos de código |

(Las rutas son relativas a `plugins/suplemento-core/`.) **Categorías leídas y no adaptadas:** inteligencia artificial integrada en el navegador, WebMCP, WebAssembly, instalación de aplicaciones web (PWA) y los efectos visuales de nicho (WebGL, canvas, texturas); no corresponden al trabajo habitual de este proyecto.

Cumplimiento de la licencia: se conserva la atribución en el encabezado de cada archivo, se indican los cambios y se incluye una copia de la licencia en `plugins/suplemento-core/skills/frontend-conventions/references/LICENSE-Apache-2.0.txt`. La fuente no publica un archivo `NOTICE` propio. Esto no implica respaldo de los autores originales. El plugin *Modern Web Guidance* en sí **no** es parte de este repositorio ni se distribuye con él.
