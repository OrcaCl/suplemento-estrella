# OWASP ASVS 5.0

Versión 5.0.0, publicada en mayo de 2025. Los capítulos se confirmaron en el repositorio oficial (OWASP/ASVS, etiqueta v5.0.0). Cifras como "unos 350 requisitos" provienen de fuentes secundarias: consultar el repositorio para el número exacto y para el texto de cada requisito antes de citarlo.

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

Tres niveles acumulativos. En la versión 5.0 se calibran según el **riesgo** de la aplicación, no como "mínimo, estándar y avanzado" fijos.

| Nivel | Para qué | Cómo se usa en este harness |
|---|---|---|
| 1 | Base para cualquier software | Por defecto (`asvs_nivel: 1`) |
| 2 | Aplicaciones con autenticación, datos personales o datos sensibles | Proponerlo cuando el proyecto lo requiera |
| 3 | Sistemas críticos | Solo si el humano lo declara |

## Cómo usarlo

No recorrer los 17 capítulos en cada tarea. Usar la tabla de `SKILL.md` para saber qué capítulo corresponde al tipo de cambio y abrir solo ese capítulo en el repositorio oficial si hace falta el requisito exacto.
