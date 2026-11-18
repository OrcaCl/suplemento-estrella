# Rendimiento web — lista de verificación

> **Fuente y licencia:** adaptado de la guía `performance` de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance), licencia Apache-2.0 (copia en `LICENSE-Apache-2.0.txt`). **Cambios:** traducido al español, resumido y reorganizado; se omiten los ejemplos de código. Detalle en `NOTICE.md`. Sin respaldo de los autores originales. Se leyó la guía general; las 25 guías específicas (lotes de analítica, tareas largas, precarga de la página siguiente, transmisión de HTML, etc.) se conocen solo por su título.

## 1. Ruta crítica de renderizado

- **Estilos críticos en línea en el `<head>`** y el resto diferido. Dividir el CSS por consultas de medios con el atributo `media` en cada `<link>`: el navegador baja lo que no aplica (impresión, escritorio en móvil) sin bloquear el pintado.
- **`async` o `defer` en todo script no crítico**; `defer` si dependen del DOM o entre sí, `async` si son independientes. Se prefiere `type="module"`.
- **Pistas de recursos:** `preconnect` para dominios conocidos de terceros, `dns-prefetch` como respaldo ligero, `preload` para lo del mismo origen que se necesita ya (imagen principal, fuente que bloquea), `prefetch` para la página siguiente. Regla corta: *preconnect para dominios, preload para lo visible, prefetch para lo futuro.*
- **No usar `@import` en CSS** (cadena de peticiones secuenciales que retrasa el CSSOM): ver `SKILL.md`, Regla 2.
- No poner JavaScript grande y no crítico en el `<head>`. No cargar CSS ni JS inalcanzable: minificar y eliminar código muerto en el despliegue.

## 2. Imagen principal (LCP)

- Declarar la imagen principal en el HTML crudo (preferible un `<img>`), para que el escáner de precarga la descubra de inmediato.
- `fetchpriority="high"` en la imagen principal; `fetchpriority="low"` en lo grande que **no** es la principal y no está en la primera pantalla; **sin abusar**: la prioridad es un juego de suma cero.
- `loading="lazy"` en imágenes, iframes y medios lejos de la primera pantalla. **Nunca** en la imagen principal ni en lo visible al cargar.
- No usar cargadores de JavaScript complejos para la sección principal: una cadena HTML → JS → imagen retrasa todo.

## 3. Respuesta a las interacciones (INP)

- **Dividir tareas de JavaScript de más de 50 ms** y ceder el hilo con `scheduler.yield()` (con alternativa de `setTimeout` envuelto en una promesa; la API tiene disponibilidad limitada, ver `madurez-funciones.md`). Regla práctica: menos de 50 ms, síncrono; entre 50 y 250 ms, dividir y ceder; más de 250 ms, a un Web Worker.
- Limitar la frecuencia de manejadores de `scroll`, `resize` e `input` (debounce o throttle). Separar la actualización de la interfaz (síncrona) del cálculo pesado (en segundo plano).
- No provocar *layout thrashing*: no intercalar lecturas (`offsetHeight`, `getBoundingClientRect`) y escrituras (`style.height`) en un bucle; agrupar lecturas y luego escrituras. No usar `setInterval` pesado.

## 4. Scripts de terceros

- Son la principal causa de congestión del hilo principal (analítica, anuncios, chats). Cargarlos con `defer`, preferentemente al final de la página, y no en páginas con datos sensibles (pago, salud) salvo que sea imprescindible.
- **Alojar en el propio dominio** las dependencias de terceros críticas (menos consultas DNS, control de `Cache-Control`): coincide con la Regla 1 de `SKILL.md` (`vendor/`, sin CDN).
- Para las pocas cargas externas inevitables, `seguridad-por-diseno` pide integridad (SRI): ver `seguridad-web-navegador.md`.

## 5. Renderizado y contención

- `content-visibility: auto` en secciones fuera de pantalla de páginas **grandes y complejas** (estado "newly" desde 2025-09-15), junto con `contain-intrinsic-size` derivado del contenido (con `auto`) para que el scroll no salte. **No** en páginas pequeñas ni en lo visible al cargar. Sigue exponiendo el contenido a los lectores de pantalla; si debe ocultarse de verdad, gestionar `aria-hidden`.
- `contain: layout style paint` en componentes aislados (modales, widgets) para que sus cambios no reordenen toda la página.
- **No** poner `will-change` en todas partes (consume memoria de video y puede degradar el renderizado).

## 6. Imágenes y video

- `<picture>` con AVIF o JPEG XL, luego WebP, luego JPEG/PNG. **`width` y `height` en todo `<img>`** (evita el salto de diseño, CLS). `srcset` **con `sizes`**: sin `sizes` el navegador asume `100vw` y descarga la imagen más grande.
- Video: `width` y `height`, imagen `poster`, `preload="none"` en lo no crítico, formatos modernos (WebM junto a MP4), `loading="lazy"` fuera de pantalla. No reproducir video grande automáticamente.

## 7. Fuentes web

- `preload` de las fuentes críticas de la primera pantalla (`as="font" type="font/woff2" crossorigin`, **con `crossorigin` aun en el mismo origen**). Subconjuntos de caracteres y pesos. **No** precargar todas las fuentes ni usar `fetchpriority="high"` en fuentes (ya tienen prioridad alta).

## 8. Service workers y caché

- `CacheFirst` para activos estáticos versionados con hash; `StaleWhileRevalidate` para datos dinámicos no críticos; `NetworkFirst` para el HTML; límites de tamaño y vencimiento de la caché.
- No cachear a ciegas respuestas opacas ni peticiones POST. No saltarse el versionado (los usuarios quedan atrapados en cachés viejas).
- **No usar `Cache-Control: no-store` en recursos no sensibles:** impide el *back-forward cache* y empeora la navegación. Sí en lo realmente sensible.

## 9. Código

- Importaciones dinámicas (`import()`) para dividir rutas y librerías pesadas; separar el código de terceros del propio en el empaquetador. No enviar un único `app.js` enorme.
