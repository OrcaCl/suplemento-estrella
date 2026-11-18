# OWASP Top 10:2025

> **Fuente y licencia:** adaptado de OWASP Top 10:2025 (OWASP Top 10 Project, https://top10.owasp.org/2025/). Licencia CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode). Traducido, resumido y reorganizado con redacción propia. Detalle en `fuentes-y-licencias.md`. Sin respaldo de OWASP.

Las diez categorías, confirmadas en la página oficial (top10.owasp.org/2025). Esa página no indica si la edición es final ni su fecha de publicación; verificarlo antes de citar la edición como definitiva. La lista no incluye riesgos específicos de IA: esos están en `agentes-y-datos-owasp.md`.

| ID | Categoría | Qué evitar al escribir código | Qué verificar |
|---|---|---|---|
| A01 | Broken Access Control (control de acceso roto) | Confiar en el cliente; rutas sin comprobar permisos; acceso a un recurso solo por su ID. Según fuentes secundarias, SSRF quedó absorbido aquí | Cada petición comprueba identidad y pertenencia en el servidor; se deniega por defecto |
| A02 | Security Misconfiguration | Credenciales por defecto, modo debug en producción, permisos amplios, cabeceras de seguridad ausentes | Configuración distinta por entorno; nada innecesario habilitado |
| A03 | Software Supply Chain Failures | Dependencias sin fijar, paquetes de nombre dudoso, pipelines sin control | Lockfile; revisión de paquetes nuevos; ver `ketchup` (ítem 18 de SPEC.md) |
| A04 | Cryptographic Failures | Criptografía propia, algoritmos obsoletos, datos sensibles sin cifrar, claves en el código | Estándares vigentes; TLS; gestión de claves fuera del código |
| A05 | Injection | Concatenar entrada del usuario en SQL, comandos, plantillas o consultas | Consultas parametrizadas; codificación de salida; validación |
| A06 | Insecure Design | Funciones sin pensar cómo se abusan; sin límites ni controles de negocio | Modelado de amenazas antes de implementar; límites de tasa y de monto |
| A07 | Authentication Failures | Contraseñas débiles o mal guardadas, sesiones que no expiran, recuperación de cuenta insegura | Hash adecuado, límite de intentos, rotación y expiración de sesión |
| A08 | Software or Data Integrity Failures | Aceptar código, actualizaciones o datos serializados sin verificar origen | Verificación de firma o integridad; evitar deserializar datos no confiables |
| A09 | Security Logging & Alerting Failures | No registrar eventos de seguridad, o registrar datos sensibles | Eventos clave registrados, sin datos sensibles, con alerta cuando corresponda |
| A10 | Mishandling of Exceptional Conditions | Errores sin manejar, fallar abierto, filtrar detalles internos | Fallar cerrado; mensajes genéricos al usuario; detalle solo en logs |

Los controles concretos de la columna "Qué evitar" son criterio general de la práctica de seguridad; la categoría y su nombre sí provienen de OWASP.
