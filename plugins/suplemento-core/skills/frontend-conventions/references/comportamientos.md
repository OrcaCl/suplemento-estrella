# Comportamientos de interfaz — transiciones, movimiento e interacción

> **Fuente y licencia:** adaptado de las guías `ui-behaviors` y `ui-atoms` y de la guía `motion` de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance), licencia Apache-2.0 (copia en `LICENSE-Apache-2.0.txt`). **Cambios:** traducido al español, muy resumido y reorganizado. Detalle en `NOTICE.md`. Sin respaldo de los autores originales. **Alcance de la lectura:** de las 53 guías de estas dos categorías se leyeron la guía `motion` completa y, de las demás, la descripción y una regla destacada; no su detalle. Muchos de estos patrones dependen de funciones de disponibilidad limitada (animaciones por scroll, posicionamiento por anclaje, invocadores de interés): consultar `madurez-funciones.md` y diseñarlos como mejora progresiva.

## Movimiento y preferencias (guía `motion`, leída completa)

- **Respetar siempre la preferencia de movimiento reducido.** Si la estrategia es **no animar**, activar la animación solo dentro de `@media (prefers-reduced-motion: no-preference)` (estado estático por defecto); si es **suavizarla**, declarar la animación base y cambiar solo los parámetros dentro de `@media (prefers-reduced-motion: reduce)`.
- **No** aplicar globalmente `animation-duration: 0.01ms`: algunas animaciones se vuelven más bruscas. Tratar cada caso y anidar la consulta dentro de la regla.
- Con el movimiento desactivado, el elemento debe terminar en su estado final (no dejar contenido en `opacity: 0`, ni sin indicadores de foco o selección). Y `animationend`/`transitionend` **no se disparan** si la animación nunca corre: el código que los espera no debe quedarse colgado.
- **Pausa:** todo movimiento que empiece solo, dure más de cinco segundos y esté junto a otro contenido necesita un mecanismo visible para detenerlo. Considerar vistas estáticas por defecto con el movimiento como opción.
- **No exceder tres destellos por segundo** nunca, ni dentro de `no-preference`: puede causar convulsiones.
- **Rendimiento:** animar `opacity` y `transform` (incluidas `translate`, `scale`, `rotate` individuales, no `left/top`) para quedarse en el compositor. Entrada y salida de elementos con `@starting-style`, `transition-behavior: allow-discrete` y, para la capa superior (`<dialog>`, `[popover]`), `overlay`. **No** poner `allow-discrete` en la abreviatura `transition`: los navegadores antiguos ignoran toda la declaración; usar una propiedad `transition-behavior` aparte.
- Para efectos de scroll no esenciales, animaciones dirigidas por scroll (`animation-timeline`) en vez de manejadores de JavaScript, **con detección de funciones** (`@supports`) y una alternativa. Las transiciones de vista (`View Transitions`, "newly" desde 2025-10-14) animan entre estados complejos del diseño y entre páginas del mismo origen.
- Un recorte (`clip-path`, `mask-image`) también recorta el contorno de foco del propio elemento: si es enfocable, dibujar el foco en otro lugar.

## Reordenar, ordenar y arrastrar

- **El orden visual debe ser el del DOM** (y el del teclado y del lector de pantalla): reordenar los hijos reales, nunca con `order` ni `flex-direction: *-reverse`.
- **Ordenar por la acción del usuario** (lista, cuadrícula, tabla): mover los nodos del DOM, animar, **anunciar** el cambio y cuidar el rendimiento.
- **Tabla ordenable:** partir de una `<table>` completa y legible sin JavaScript; un `<button type="button">` **dentro de** cada `<th scope="col">` (no hacer clicable el `<th>`, ni usar `<a>` o `role="button"`).
- **Arrastrar y soltar para reordenar:** reordenar los hijos reales, dejar el ítem de origen en su lugar y mostrar un marcador de destino en vez de mover hermanos mientras el puntero se mueve (el movimiento continuo se siente nervioso). No mostrar coordenadas crudas: usar nombres ("anclado a la izquierda").
- **Mover un elemento del DOM sin perder su estado** (un `<dialog>`, `popover`, video o iframe): `moveBefore()` en vez de `appendChild()` o `insertBefore()`, que lo eliminan y lo reinsertan.

## Desplazamiento y patrones táctiles

- **Gestos con alternativa:** todo gesto de trayectoria (deslizar para eliminar o revelar, tirar para revelar) necesita **un botón visible** que haga lo mismo con un clic o con Enter (WCAG 2.5.1). `scroll-snap-type: x mandatory`, no `proximity`, para que la fila no quede a medias.
- No fijar `touch-action` de forma incondicional: desactiva los gestos del navegador y no afecta a la rueda ni al trackpad. En el panning bidimensional, el navegador bloquea el eje; se puede liberar con CSS en vez de capturar eventos.
- Efectos al terminar un desplazamiento programático: usar `scrollend` con cuidado (no se dispara si el objetivo ya está en vista).
- `scroll-initial-target` para que un contenedor comience en un elemento (el día actual de un calendario, una imagen concreta) sin JavaScript.
- Ayudas de desplazamiento (sombras en los bordes) con los pseudoelementos `::before`/`::after` del propio contenedor, no con elementos extra; `single-line-overflow`: un degradado único como máscara también oculta el contorno de foco.
- Elementos pegajosos (`position: sticky`) que cambian cuando quedan fijados, y encabezados que se encogen, con consultas de estado de scroll (disponibilidad limitada).

## Tablas y contenido oculto

- **Tablas responsivas:** encabezados y primeras columnas pegajosos para mantener el contexto al desplazarse, en vez de aplastar las columnas.
- **Buscar en contenido oculto:** `hidden="until-found"` para que la búsqueda del navegador (y los enlaces con ancla) abra el contenido oculto; el borde, el relleno y el fondo van en un contenedor hijo, no en el propio elemento.
- **Resaltar rangos de texto** (resultados de búsqueda, sintaxis) con la API de resaltado personalizado, sin modificar el DOM; no es un reemplazo de la semántica HTML.
- **Íconos:** decidir cómo se guardan (hoja de sprites SVG) y cómo se muestran (máscara para un ícono de un color, fondo para uno a todo color, o `<use>`); respetar `aria-hidden` en los decorativos.
- **Tooltips y menús que se acomodan al borde de la pantalla:** con posicionamiento por anclaje y alternativas lógicas (`flip-block`, `flip-inline`); disponibilidad limitada.

## Patrones de la fuente que **no** se adaptaron

Por ser de nicho, depender de funciones muy nuevas o no ser comunes en aplicaciones de negocio: parallax y *scrollytelling*, efectos de diapositivas de carrusel, indicador de progreso de scroll, revelado con máscaras, easing con física (`linear()`), escalonado de animaciones, navegación espacial (teclado direccional), deslizar para eliminar o revelar con detalle, panning 2D, transiciones entre documentos y entre vistas con detalle, y los efectos visuales (WebGL, `canvas` con HTML, texturas, formas complejas, alineación de caja de texto, líneas de igual ancho). Si el proyecto los necesita, leer la guía original.
