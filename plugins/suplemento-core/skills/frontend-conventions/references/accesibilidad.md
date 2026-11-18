# Accesibilidad — lista de verificación

> **Fuente y licencia:** adaptado de la guía `accessibility` de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance), licencia Apache-2.0 (copia en `LICENSE-Apache-2.0.txt`). **Cambios:** traducido al español, resumido, reorganizado como lista de verificación y complementado donde se indica. Detalle en `NOTICE.md`. Sin respaldo de los autores originales. Las referencias WCAG entre paréntesis vienen de la fuente salvo que se diga lo contrario.

Cómo usarla: recorrer la sección que corresponda al cambio. Lo que no se pueda cumplir se avisa al terminar la tarea, igual que en `seguridad-por-diseno`.

## 1. Estructura y navegación

- **Landmarks:** `<header>`, `<nav>`, `<main>`, `<footer>` en su lugar. **Un solo `<main>` por página** (1.3.1). No abusar de ellos: etiquetar un `<section>` lo convierte en `region`, y eso es un último recurso.
- **Encabezados:** un `<h1>` por página; sin saltarse niveles (`h1` → `h4`); el nivel sigue la jerarquía visual. No poner encabezados dentro de `<summary>` (algunos lectores lo exponen como botón y descartan el encabezado).
- **Listas:** `<ul>`/`<ol>` para contenido repetido y contiguo; `<ol>` solo si el orden importa. No usar listas para párrafos sueltos ni para agrupar checkboxes o radios (el lector ya anuncia la cantidad).
- **Tablas:** `<table>` con `<caption>`, `<th scope="col|row">`; evitar tablas complejas (celdas combinadas, anidadas, filas expandibles).
- **Enlace de salto:** uno basta (o dos si hay navegación primaria y secundaria); no ponerlo donde no hace falta.

## 2. HTML semántico y ARIA

- **HTML nativo antes que ARIA:** `<button>` en vez de `<div role="button">` o `<a role="button">`.
- **Sin roles redundantes:** no `<ul role="list">`, `<nav role="navigation">`, ni `required` junto con `aria-required="true"`.
- **No aplicar roles interactivos a elementos estructurales:** usar `<li><span role="button">`, no `<li role="button">`.
- Un elemento personalizado puede tener ARIA a través de `ElementInternals`: que un `role` no aparezca en el HTML no significa que no lo tenga.

## 3. Nombres accesibles y descripciones

- Preferir el mecanismo nativo: `<label>` (controles), `<caption>` (tablas), `<legend>` (`fieldset`), `<figcaption>` (`figure`).
- Con una etiqueta visible, `aria-labelledby` antes que `aria-label` (sin duplicar texto y se traduce mejor).
- **`title` y `placeholder` no son nombres:** `title` no se ve con teclado; `placeholder` desaparece al escribir.
- No poner `aria-label`/`aria-labelledby` en `<div>`, `<span>` o elementos sin rol.
- **El texto visible va dentro del nombre accesible**, tal cual está escrito (2.5.3 en WCAG 2.1; criterio no citado por la fuente).
- No repetir un mismo nombre en controles con efectos distintos, ni en enlaces con destinos distintos (4.1.2). Enlaces al mismo destino, mismo nombre.
- Texto solo para lectores de pantalla (`<button>Editar <span class="visually-hidden">nombre</span></button>`) cuando el contexto no alcanza.
- **No meter descripciones, errores o instrucciones en la etiqueta:** usar `aria-describedby`. No repetir en la etiqueta el rol (`<nav aria-label="Navegación principal">` se lee "Navegación principal, navegación") ni el estado ya expuesto por `aria-expanded`, `aria-checked`, etc.
- Una descripción solo si aporta algo que la etiqueta no dice; no repetir lo que ya expresan los atributos (por ejemplo "campo obligatorio" si ya tiene `required`). No apuntar `aria-describedby` a contenido interactivo.

## 4. Idioma y metadatos

- `lang` en `<html>` con el idioma principal real, y `lang` en el contenedor de cualquier fragmento en otro idioma. Un valor equivocado hace que el lector lo pronuncie mal.
- `<title>` en cada página (también en `<iframe>`): no vacío, único y descriptivo (2.4.2).
- Cada `<iframe>` con `title` descriptivo; no desactivar su scroll (`scrolling="no"`, `overflow: hidden`): quien amplía el texto necesita desplazarse (1.4.4).

## 5. Teclado y foco

- `tabindex="0"` solo en elementos con rol interactivo que no son enfocables por defecto. **Nunca** en elementos que ya lo son (`button`, `a[href]`, `input`) ni en contenido estático u oculto.
- No agregar manejadores de teclado a elementos nativos interactivos: ya responden a Enter y Espacio.
- **Estilos de foco:** usar `:focus-visible` (no `:focus`); preferir el indicador nativo; si es propio, con `outline` en vez de `box-shadow` (o dar una alternativa con `outline` para el modo de alto contraste, vía `forced-colors`). Nunca `outline: none` sin reemplazo con buen contraste.
- **Tamaño del objetivo táctil:** al menos 24×24 píxeles CSS (WCAG 2.5.8, criterio no citado por la fuente), con `min-block-size`/`min-inline-size` o relleno, no con `width`/`height` fijos.
- No usar `touch-action: none` para gestos propios: bloquea el scroll. Limitarlo al eje necesario (`pan-y` para deslizamientos horizontales).

## 6. Alternativas de texto y medios

- **Imágenes:** `alt` que describa el propósito ("Buscar", no "Lupa"); `alt=""` para las decorativas (1.1.1). Sin prefijos como "Imagen de…". Guiones, no guiones bajos, en nombres de archivo.
- **SVG en línea:** informativo con `role="img"` y una descripción de texto; decorativo con `aria-hidden="true"`.
- Videos: audiodescripción cuando lo visual aporta información que el sonido no da.

## 7. Formularios

Ver `formularios.md`: es una lista propia, más extensa.

## 8. Regiones en vivo (`aria-live`)

- Anunciar errores dinámicos con `aria-live` o moviendo el foco a una lista de errores (4.1.3).
- **No usar regiones en vivo para "Cargando…"** salvo que informe algo; usar `<progress>`.
- Una región `polite` y una `assertive` por página, centralizadas. `assertive` solo para lo crítico (pérdida de datos, sesión por expirar, caída de red).
- Agrupar o retrasar actualizaciones que cambian muchas veces por segundo (contador de resultados al escribir) y no actualizar contenido que quedó `inert` (se pierde el anuncio).

## 9. Color, tipografía y movimiento

La fuente detalla estos temas en guías separadas que **no se leyeron**. Lo siguiente es WCAG estándar, no de la fuente: contraste de texto de al menos 4,5:1 (3:1 para texto grande) y de 3:1 para controles y gráficos (1.4.3, 1.4.11); no comunicar estado solo con color (1.4.1); respetar `prefers-reduced-motion` y `forced-colors`; que el texto pueda ampliarse sin perder contenido (1.4.4).

## 10. Modales

- **`<dialog>` nativo abierto con `.showModal()`.** El navegador vuelve `inert` el resto de la página: **no** agregar trampa de foco.
- Si no se puede usar `<dialog>` (superposiciones no modales, restricciones del framework): `inert` en el contenido de fondo.

## 11. Pruebas

- Automáticas (axe-core, Lighthouse) para lo evidente (alt faltante, contraste), sin fiarse del puntaje: un 100 % no garantiza que se pueda usar.
- **Manual:** recorrer toda la página solo con teclado (Tab, Mayús+Tab, flechas, Enter, Espacio, Esc).
- Probar con lectores de pantalla en sus combinaciones habituales (NVDA con Firefox, JAWS con Chrome, Narrator con Edge, VoiceOver con Safari, TalkBack en Android).
