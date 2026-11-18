# Componentes de interfaz — patrones y madurez

> **Fuente y licencia:** adaptado de las 22 guías `ui-components` de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance), licencia Apache-2.0 (copia en `LICENSE-Apache-2.0.txt`). **Cambios:** traducido al español, muy resumido (se omiten los ejemplos de código y los detalles de estilo) y reorganizado en una sola tabla de decisiones. Detalle en `NOTICE.md`. Sin respaldo de los autores originales. La madurez de cada función es **la que declaran esas guías en noviembre de 2026**: cambia con el tiempo y debe verificarse en MDN o en Baseline antes de apoyarse en ella. La tabla completa de 159 funciones está en `madurez-funciones.md`.

## Madurez de las primitivas (según las guías fuente)

| Primitiva | Estado declarado | Qué hacer |
|---|---|---|
| `<dialog>` con `.showModal()` | Baseline "widely" desde 2022-03-14 | Usarla |
| `<details>` (acordeón) | Baseline "widely" desde 2020-01-15; `name` exclusivo: "newly" desde 2024-09-03 | Usarla; el modo exclusivo, con reservas |
| `popover` | Baseline "newly available" desde 2025-01-27 (Chrome 116, Firefox 125, Safari 17) | Para navegadores más antiguos, polyfill `@oddbird/popover-polyfill` cargado solo si falta la función |
| Comandos invocadores (`command`, `commandfor`) | Baseline "newly" desde 2025-12-12 | Con un `click` que llame la misma función como alternativa |
| `Clipboard.writeText`, scroll snap, `IntersectionObserver`, `scroll-behavior` | Baseline "widely available" | Usarlas sin alternativa |
| `ariaNotify()` | Baseline "newly" (tres motores) | Región en vivo como alternativa |

**Los polyfills y librerías son dependencias de terceros:** van en `vendor/` con versión fija (Regla 1), nunca desde un CDN, y se revisan con `seguridad-por-diseno` antes de agregarlos.

**Regla de inclusión:** esta lista solo recomienda funciones que soportan los **tres motores** (Chromium, Gecko y WebKit): "widely" por defecto y "newly" con alternativa. Las funciones de uno o dos motores (por ejemplo `focusgroup`, el posicionamiento por anclaje o los invocadores de interés) se omiten a propósito; ver `madurez-funciones.md`.

## Patrones por componente

**Diálogo / modal.** `<dialog>` abierto con `.showModal()`. **No** agregar `role="dialog"`, `aria-modal`, trampa de foco, `inert` ni manejador de Esc: ya los trae. No abrirlo con `show()` ni con el atributo `open` si es modal. Botón de cierre visible y con nombre. Un mismo nivel de encabezado para los títulos. Estilos con `::backdrop` y `dialog:modal`; no poner `display` a `dialog` sin acotarlo a `dialog[open]`. No bloquear el scroll de la página con `overflow: hidden` ni `position: fixed` en `html`/`body`. Para cerrar al hacer clic fuera, un manejador propio que compare la posición del puntero con el rectángulo del diálogo (no el `event.target`, que también es el diálogo en su relleno). No mover controles bajo el puntero al mostrar una confirmación. Los paneles no modales: `<dialog popover>`.

**Acordeón.** Varios `<details>` adyacentes. No poner encabezados dentro de `<summary>` (JAWS y TalkBack lo exponen como botón y descartan el encabezado); si cada ítem necesita su encabezado, construir uno propio con botones. Sin navegación por flechas ni `tabindex` móvil: las flechas sirven para desplazarse. No envolver cada acordeón pequeño en un landmark. Evitar los exclusivos: el usuario a veces necesita comparar ítems.

**Pestañas.** Solo para cambiar de vista **dentro de la misma página**; no para navegación entre páginas, aunque se vean como pestañas. Patrón ARIA `tablist` con `tabindex` móvil: solo la pestaña activa está en el orden de Tab y las flechas mueven el foco entre pestañas (patrón WAI-ARIA, no de la fuente).

**Menú emergente (lista de comandos).** Una lista de comandos o enlaces recorrida con flechas, abierta desde un botón, otro ítem (submenú) o un clic derecho. Se construye con `popover`. **Una navegación de sitio no es un menú ARIA** (ver "Barra de navegación").

**Barra de aplicación (Archivo, Editar, Ver…).** Un solo widget con una sola parada de Tab; flechas izquierda/derecha entre menús; al enfocar un título se muestra su menú.

**Barra de herramientas.** Agrupa controles relacionados (formato, alineación) como un solo widget: **una parada de Tab**, flechas entre controles. Úsala solo para controles de un mismo tipo. Un botón solo con ícono lleva `title` como ayuda base.

**Barra de navegación del sitio.** **Un solo `<nav>`** para todos los tamaños. Cuando los enlaces no caben, la lista pasa a un `popover` abierto desde un botón; cuando caben, se muestra en línea. **Sin breakpoint fijo:** se mide si cabe, así que agregar un enlace, una traducción o texto más grande lo resuelve solo. Es navegación, no menú de aplicación: los enlaces siguen en el orden de Tab, sin `role="menubar"`, `role="menu"`, `menuitem`, `aria-haspopup="menu"` ni flechas. Marcar la página actual con `aria-current="page"`. Submenús del sitio con `<button aria-expanded aria-controls>`; **no** `<details>`/`<summary>`.

**Cajón de navegación.** Panel que entra desde el borde sobre el contenido, con el fondo atenuado. Se abre desde un botón y se cierra deslizando, tocando el fondo o con Esc.

**Migas de pan (breadcrumbs).** `<nav aria-label="Migas de pan">` con una lista **ordenada** (`<ol>`). El último ítem es el actual: sigue siendo un enlace con `aria-current="page"`. Los separadores son decorativos: se generan con CSS, no se escriben en el marcado. No quitar el separador en estilos tipo "chip": parecería un grupo de filtros o pestañas, no una jerarquía. No es para cambiar de vista (pestañas) ni para navegar todo el sitio (barra).

**Tarjeta.** Es un patrón visual, no una semántica: usar `<article>` como raíz. Un enlace nativo para navegar; un solo enlace puede envolver toda la tarjeta **solo si no contiene otros controles interactivos**. Las acciones independientes son enlaces y botones propios. Si la tarjeta es una elección, radio o checkbox con su `<label>` (o una `option`). Orden de lectura igual al visual: no contradecirlo con `order` de CSS.

**Carrusel.** Para un conjunto finito de ítems relacionados. Scroll nativo con scroll snap. Controles `<button>` anterior/siguiente y un marcador por diapositiva, con nombre claro (no un chevrón sin etiqueta). Región con nombre y `aria-roledescription="carousel"`; cada diapositiva `role="group"` con `aria-roledescription="slide"` y su posición. Anunciar la diapositiva actual en una región `polite` oculta cuando el scroll se detiene. Objetivos de al menos 24×24 px, contraste de 3:1 en los controles (1.4.11), y que lo activo no dependa solo del color (1.4.1). Si un control se deshabilita estando enfocado, mover el foco al opuesto. No usar `::scroll-button()` ni `::scroll-marker` por ahora.

**Barra de progreso, anillo y spinner.** `<progress>` como base semántica; sin `value` es indeterminado (el spinner). **No poner texto de respaldo dentro de `<progress>`**: los navegadores modernos lo ignoran. Contraste suficiente entre barra y pista. Animar con transformaciones de CSS y respetar `prefers-reduced-motion`.

**Checkbox con estilo.** Etiqueta asociada (el `<input>` dentro de la `<label>`, o `for`/`id`). Foco con `:focus-visible`, nunca `outline: none`; contraste de 3:1 para el foco y para los estados marcado e indeterminado. Área de pulsación de al menos 44×44 px (lo que pide la fuente), con la casilla visual en unidades relativas.

**Modo oscuro.** `color-scheme: light dark` por defecto: **no** fijar `light` ni `dark` en la raíz. **La mayoría de los sitios no necesita un botón permanente**: seguir la preferencia del sistema y, si hace falta un control manual, ponerlo en una pantalla de ajustes, no a la vista siempre. Estados: sistema (sin valor guardado), claro y oscuro. El valor se aplica con `<meta name="color-scheme">`. No borrar el valor guardado con `matchMedia` cuando el sistema cambia.

**Botón de copiar.** Comandos invocadores (`command` y `commandfor`) en vez de JavaScript por botón; con un `click` equivalente que llame `navigator.clipboard.writeText` como alternativa.

**Notificaciones temporales (toasts).** `popover="manual"` (no se cierra al interactuar con otra parte). Un solo contenedor, siempre el mismo lugar, como `<div role="region" aria-label="Notificaciones">`. Anunciarlas a los lectores de pantalla con una región en vivo (o con `ariaNotify()`, "newly" en los tres motores, con la región en vivo como alternativa). Anunciar solo el texto visible, no los nombres de los controles.

**Recorrido guiado (tour).** `popover="manual"` (no se cierra al hacer clic fuera) colocado junto a la función que explica con posicionamiento convencional de CSS o JavaScript, y botones de cerrar o siguiente con `popovertargetaction="hide"`.

**Vista previa al pasar el cursor o enfocar un enlace (hovercard).** Debe aparecer también al enfocar con el teclado. **No mover el foco** al mostrarla (fallaría WCAG). No atar la ayuda a un control que ya usa `aria-expanded` para otra cosa. El disparador es un enlace normal: sin la vista previa, igual navega.

**Scrollspy.** Resalta el enlace de la sección visible. Ids únicos que coincidan con los `href`; secciones lo bastante altas; el estado activo no solo por color.

**Navegación de pila (drill-down).** Patrón complejo (vistas a pantalla completa apiladas, como en una app móvil): `inert` en todas las vistas menos la visible, una entrada de historial por nivel y manejo de `popstate`, y `IntersectionObserver` como fuente de verdad del cambio de vista (no coordenadas de scroll). Usarlo solo si de verdad hace falta; es lo más costoso de mantener de toda la lista.
