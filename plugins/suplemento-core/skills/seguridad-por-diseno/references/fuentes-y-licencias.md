# Fuentes y licencias

Esta skill se apoya en trabajo de terceros. Aquí se declara qué se usó, de dónde viene, con qué licencia y qué cambios se hicieron, para que el uso sea transparente. Nada de esto implica respaldo de OWASP ni de las demás organizaciones citadas a este plugin.

## Licencia de los archivos derivados

Los archivos de esta carpeta `references/` que adaptan material de OWASP (`owasp-top10-2025.md`, `asvs-5.md`, `agentes-y-datos-owasp.md`, y `amenazas-y-ssdf.md`) se distribuyen bajo **Creative Commons Atribución-CompartirIgual 4.0 (CC BY-SA 4.0)**, https://creativecommons.org/licenses/by-sa/4.0/legalcode, porque esa licencia exige que lo adaptado se comparta bajo la misma. El resto del plugin mantiene la licencia MIT del repositorio. Si copias estos archivos a otro proyecto, conserva la atribución y esta licencia.

## Fuentes

| Fuente | Proyecto / autoría | Versión y fecha | Licencia | Uso en esta skill |
|---|---|---|---|---|
| OWASP Top 10:2025 — https://top10.owasp.org/2025/ | OWASP Top 10 Project | Edición 2025 | CC BY-SA 4.0 (archivo `LICENSE` del repositorio OWASP/Top10) | Nombres de las diez categorías; la columna de controles es redacción propia |
| OWASP Application Security Verification Standard (ASVS) 5.0.0 — https://github.com/OWASP/ASVS | OWASP ASVS Project | 5.0.0, mayo de 2025 | CC BY-SA 4.0 (repositorio OWASP/ASVS) | Nombres de capítulos, conteo de requisitos por nivel (calculado del CSV oficial) |
| OWASP Top 10 for Agentic Applications 2026 | OWASP GenAI Security Project, Agentic Security Initiative | Versión 2026, diciembre de 2025 | CC BY-SA 4.0 | Nombres de ASI01 a ASI10 y las medidas de prevención, resumidas con redacción propia |
| Securing Agentic Applications V2: A Builder & Defender's Guide | OWASP GenAI Security Project | Versión 2.0, octubre de 2026 | CC BY-SA 4.0 | Ideas de las secciones 2.7.3, 3.1.3, 3.3.7, 5.2, 5.5.1, 6.1 y 6.4, resumidas con redacción propia |
| GenAI Data Security Best Practices v2, Parte 1 y Parte 2 | OWASP GenAI Security Project | Versión 2.0, octubre y noviembre de 2026 | CC BY-SA 4.0 | Principios de minimización, aislamiento, ciclo de vida y cero confianza en el modelo, resumidos con redacción propia |
| NIST SP 800-218 (SSDF) y SP 800-218A | NIST | 1.1 vigente; 1.2 sin confirmar como final | No verificada: confirmar los términos de uso antes de copiar texto literal | Solo los nombres de los cuatro grupos de prácticas |
| STRIDE | Concepto de modelado de amenazas ampliamente difundido | — | No verificada | Solo los nombres de las seis amenazas |

## Cambios realizados

- Se tradujeron al español y se resumieron en redacción propia; no se copian párrafos completos de los documentos originales.
- Se reorganizaron por **tipo de cambio de código** y se les agregaron reglas pensadas para Code como agente (no están en los originales).
- Los conteos de ASVS se calcularon del CSV oficial; el resultado es cálculo propio.

## Cómo citar al reutilizar

Incluye el nombre del proyecto y el del documento, por ejemplo: "OWASP GenAI Security Project — *OWASP Top 10 for Agentic Applications 2026*, CC BY-SA 4.0", y un enlace a la licencia. Los documentos piden además indicar si se hicieron cambios.
