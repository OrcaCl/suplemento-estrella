# Seguridad web del lado del navegador y privacidad — lista de verificación

> **Fuente y licencia:** adaptado de las guías `security` (maestra y específicas) y `privacy` de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance), licencia Apache-2.0 (copia en `../../frontend-conventions/references/LICENSE-Apache-2.0.txt`). **Cambios:** traducido al español, resumido y reorganizado; se omiten ejemplos de código. Detalle en `NOTICE.md` y `fuentes-y-licencias.md`. Sin respaldo de los autores originales. **Alcance de la lectura:** la guía maestra de seguridad se leyó completa en sus reglas (no el cuerpo de la fase de aplicación de CSP); de las 16 guías específicas se leyó la descripción y las reglas destacadas; la de privacidad, completa. Complementa a OWASP (`owasp-top10-2025.md`, `asvs-5.md`), que da el *qué*; esto da cabeceras y APIs concretas del navegador. **Regla de inclusión (ADR-023):** solo se recomiendan funciones de los tres motores; se omitieron `Permissions-Policy`, los metadatos `Sec-Fetch-*`, `Clear-Site-Data`, las cookies particionadas, la Sanitizer API y `Connection-Allowlist` por ser de uno o dos motores. **No verificadas en las bases abiertas** (no figuran en web-features ni en Can I use): COOP, CORP, `X-Content-Type-Options` y los prefijos `__Host-`/`__Secure-`; por eso van como defensa en profundidad y hay que comprobarlas en MDN. La madurez de cada función está en `frontend-conventions/references/madurez-funciones.md` y envejece.

## 1. Transporte y cabeceras (las "victorias rápidas")

- **HTTPS en todo**, y `Strict-Transport-Security: max-age=31536000; includeSubDomains; preload` para forzarlo.
- `X-Content-Type-Options: nosniff`, con el `Content-Type` correcto en cada recurso (`application/javascript`, `application/json`, `text/html`).
- `Referrer-Policy: strict-origin-when-cross-origin` como valor seguro por defecto (evita filtrar parámetros sensibles de la URL a terceros).
- **Antiframing (clickjacking):** `Content-Security-Policy: frame-ancestors 'none'` junto con `X-Frame-Options: DENY` si la página nunca se incrusta; `'self'` y `SAMEORIGIN` si solo la incrusta el propio sitio; si hay socios concretos, `frame-ancestors 'self' https://socio.example` **sin** `X-Frame-Options` (no sabe expresar listas entre orígenes).
- **`Cross-Origin-Opener-Policy: same-origin-allow-popups`** por defecto (permite OAuth y pagos iniciados por la propia app); `same-origin` solo tras verificar que ninguna integración usa `window.opener` entre orígenes.
- **`Cross-Origin-Resource-Policy`:** `same-origin` por defecto para respuestas internas (HTML, datos autenticados, JSON de sesión); `same-site` entre subdominios; `cross-origin` solo para recursos pensados para incrustarse.
- **CORS:** validar `Origin` en el servidor y devolver un `Access-Control-Allow-Origin` dinámico y específico, **nunca `*` con credenciales** (el navegador lo rechaza); responder los `OPTIONS` de verificación previa antes de procesar datos.
- **Cierre de sesión:** invalidar la sesión **en el servidor** (no basta con borrar la cookie del cliente) y expirar la cookie con los mismos atributos con que se creó.

## 2. Cookies

- Cookies de sesión de primera parte con el prefijo **`__Host-`** (exige `Secure`, `Path=/` y sin `Domain`); si no aplica, **`__Secure-`**.
- `HttpOnly` en cookies de sesión y autenticación; `SameSite=Lax` explícito por defecto. **No** depender de cookies de terceros ni de cookies particionadas (de un solo motor): si la app debe incrustarse en otro sitio, rediseñar para no necesitar cookies de terceros.
- **No** guardar tokens sensibles ni datos personales en `localStorage` (cualquier script incrustado los lee).

## 3. XSS y el DOM

- `textContent` o `innerText` en vez de `innerHTML` para texto. **Nunca** `innerHTML` ni `setHTMLUnsafe` con datos no confiables. Construir elementos con `createElement` o `DOMParser`, no concatenando HTML.
- **HTML de usuarios que sí hay que mostrar:** sanearlo **en el servidor** y/o con una biblioteca revisada y alojada en `vendor/` (la guía fuente usa DOMPurify); la sanitización del lado del cliente protege solo esa página, y si el mismo contenido se muestra en otro lugar (correo, otras páginas) hay que sanear también allí. La API nativa de saneamiento (`setHTML`) aún es de uno o dos motores y no se usa como base.
- **Trusted Types** ("newly" desde 2026-02-24): los destinos peligrosos (`innerHTML`, `outerHTML`, `document.write`, `eval`, `<script src>`, `Worker()`) solo aceptan objetos tipados que salen de una política con nombre; se exige con `require-trusted-types-for 'script'` en la CSP. **No** crear una política que devuelva la entrada sin cambios (`createHTML: s => s`): anula la protección.
- **CSP:** desplegar primero en modo **solo informe** (`Content-Security-Policy-Report-Only`) con un `Reporting-Endpoints`, durante días o semanas de tráfico real, y recién entonces aplicarla. No incluir datos sensibles (datos personales, tokens, identificadores de sesión, cadenas de consulta con secretos) en los informes. Sin JavaScript en línea para poder usar una CSP estricta.
- **`postMessage`:** validar siempre `event.origin` con igualdad estricta contra una lista de orígenes de confianza, y **nunca `*`** como destino al enviar datos sensibles; validar y sanear el contenido recibido antes de llevarlo a un destino del DOM. Para comparar URLs de verdad usar la API `Origin` en vez de cadenas: `startsWith('https://app.example.com')` se evade con `https://app.example.com.atacante.example`, y los orígenes opacos (`"null"`, de iframes con `sandbox`) colisionan.
- **Recursos de terceros:** **Subresource Integrity** (`integrity` con `sha384` o más, y `crossorigin="anonymous"`) solo para activos **inmutables y versionados**: en uno dinámico, una actualización silenciosa rompe la ejecución. `integrity()` en `url()` de CSS tiene disponibilidad limitada.

## 4. Autenticación sin contraseña (passkeys / WebAuthn)

- Requieren HTTPS (o `localhost`). **Usar bibliotecas probadas** en el servidor (SimpleWebAuthn en JS/TS, `py_webauthn` en Python, `webauthn4j` en Java, `go-webauthn` en Go, `webauthn-ruby`, `webauthn-framework` en PHP); **nunca** implementar la criptografía a mano.
- El `rpId` viene de **las opciones que entrega el servidor**; **no** derivarlo de `window.location.hostname` en el cliente (el servidor puede usar un dominio padre registrable).
- El AAGUID del autenticador sirve **solo como pista de interfaz** (mostrar el nombre del proveedor): **no** usarlo para decisiones de seguridad (los passkeys de plataforma no dan atestación criptográfica de él).
- Para operaciones sensibles (cambiar contraseña, transferencias): reautenticación con passkey, y **no** usar el modo de interfaz inmediata en una página de inicio de sesión dedicada ni en la reautenticación.
- No verificar tokens (por ejemplo de verificación de correo) en JavaScript de cliente: se verifica **en el servidor**, con bibliotecas JOSE/JWT establecidas.

## 5. Privacidad

- **Minimizar:** recopilar con la menor granularidad necesaria (un rango de edad, no la fecha de nacimiento); no recopilar "por si acaso"; no reutilizar para otra finalidad (marketing) lo recopilado para una (verificación) sin consentimiento; **borrar cuando se cumplió el propósito**.
- **Transparencia:** explicar junto al campo por qué se pide; dar el motivo antes de pedir permisos potentes (cámara, ubicación); sin patrones engañosos para el consentimiento; que cancelar la cuenta sea tan fácil como crearla.
- **Seguridad de los datos:** **limpiar los datos personales de los logs** (enmascarar correos, tokens e identificadores); `HttpOnly` en cookies de sesión; **limitar la tasa** en endpoints sensibles (búsqueda de usuarios, perfiles) para evitar el raspado masivo.
- **Terceros:** auditar con DevTools o archivos HAR qué datos recopilan; patrón de **fachada** para incrustaciones pesadas (miniatura estática y cargar el iframe solo al hacer clic); enlaces estáticos en vez de SDK de redes sociales; no cargar scripts de terceros donde hay datos sensibles; no asumir que un tercero es seguro por ser popular.
- **Huella digital:** detección de funciones en vez de `navigator.userAgent`; no construir huellas con `canvas`, listas de fuentes o dispositivos.
- **Derechos de las personas:** acceso, corrección y **borrado** sin obligar a contactar a soporte; no castigar a quien los ejerce.
