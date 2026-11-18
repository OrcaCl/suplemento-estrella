# Avisos de terceros

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

**Modern Web Guidance** (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance; mantenido por los equipos de Chrome, Edge, Firefox y MDN con la comunidad): licencia **Apache-2.0**. `frontend-conventions` incluye listas de verificación **adaptadas** de tres de sus categorías de guías (ADR-021): `accessibility`, `forms` y `ui-components`.

| Archivo | Guías originales | Cambios |
|---|---|---|
| `plugins/suplemento-core/skills/frontend-conventions/references/accesibilidad.md` | `accessibility` | Traducida al español, resumida y reorganizada como lista de verificación; complementada con criterios WCAG señalados como propios |
| `plugins/suplemento-core/skills/frontend-conventions/references/formularios.md` | `forms` (general) | Traducida, resumida y reorganizada; cruzada con las reglas de seguridad del proyecto |
| `plugins/suplemento-core/skills/frontend-conventions/references/componentes.md` | las 22 de `ui-components` | Traducida y muy resumida (sin ejemplos de código ni estilos); la madurez es la declarada por las guías en noviembre de 2026 |

Cumplimiento de la licencia: se conserva la atribución en el encabezado de cada archivo, se indican los cambios y se incluye una copia de la licencia en `plugins/suplemento-core/skills/frontend-conventions/references/LICENSE-Apache-2.0.txt`. La fuente no publica un archivo `NOTICE` propio. Esto no implica respaldo de los autores originales. El plugin *Modern Web Guidance* en sí **no** es parte de este repositorio ni se distribuye con él.


NIST SP 800-218 (SSDF) y el concepto STRIDE se citan por nombre; no se copia su texto. No se verificaron sus términos de uso.
