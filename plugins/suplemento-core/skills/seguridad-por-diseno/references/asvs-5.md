# OWASP ASVS 5.0

> **Fuente y licencia:** adaptado de OWASP Application Security Verification Standard 5.0.0 (OWASP ASVS Project, https://github.com/OWASP/ASVS). Licencia CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode). Traducido, resumido y reorganizado con redacción propia. Detalle en `fuentes-y-licencias.md`. Sin respaldo de OWASP.

Versión 5.0.0, publicada en mayo de 2025. Capítulos y cifras verificados el 2026-11-17 contra el repositorio oficial (OWASP/ASVS, etiqueta v5.0.0, archivo `5.0/docs_en/OWASP_Application_Security_Verification_Standard_5.0.0_en.csv`): **345 requisitos** en 17 capítulos. Para el texto exacto de un requisito, leerlo ahí.

## Capítulos (17)

| Cap. | Tema | Cap. | Tema |
|---|---|---|---|
| V1 | Codificación y saneamiento | V10 | OAuth y OIDC |
| V2 | Validación y lógica de negocio | V11 | Criptografía |
| V3 | Seguridad del frontend web | V12 | Comunicación segura |
| V4 | API y servicios web | V13 | Configuración |
| V5 | Manejo de archivos | V14 | Protección de datos |
| V6 | Autenticación | V15 | Codificación segura y arquitectura |
| V7 | Gestión de sesiones | V16 | Registro de eventos y manejo de errores |
| V8 | Autorización | V17 | WebRTC |
| V9 | Tokens autocontenidos | | |

## Niveles

Tres niveles acumulativos. En la versión 5.0 se calibran según el **riesgo** de la aplicación, no como "mínimo, estándar y avanzado" fijos. Cada requisito del CSV oficial declara el primer nivel en que aplica (columna `L`):

| Nivel | Requisitos nuevos en ese nivel | Total acumulado |
|---|---|---|
| 1 | 70 | 70 |
| 2 | 183 | 253 |
| 3 | 92 | 345 |

El nivel 1 es mucho más acotado que en ASVS 4 (donde tenía 131 controles, según una fuente secundaria): es una base realista para empezar.

| Nivel | Para qué | Cómo se usa en este harness |
|---|---|---|
| 1 | Base para cualquier software | Por defecto (`asvs_nivel: 1`) |
| 2 | Aplicaciones con autenticación, datos personales o datos sensibles | Proponerlo cuando el proyecto lo requiera |
| 3 | Sistemas críticos | Solo si el humano lo declara |

## Cómo usarlo

No recorrer los 17 capítulos en cada tarea. Usar la tabla de `SKILL.md` para saber qué capítulo corresponde al tipo de cambio y abrir solo ese capítulo en el repositorio oficial si hace falta el requisito exacto.
