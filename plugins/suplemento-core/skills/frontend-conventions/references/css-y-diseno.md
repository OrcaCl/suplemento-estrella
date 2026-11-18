# CSS moderno y diseño visual — lista de verificación

> **Fuente y licencia:** adaptado de las guías `css`, `color`, `typography`, `dark-mode`, `browser-ui-theming`, `visual-effects` y `responsive-design` de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance), licencia Apache-2.0 (copia en `LICENSE-Apache-2.0.txt`). **Cambios:** traducido al español, resumido y reorganizado; se omiten ejemplos de código. Detalle en `NOTICE.md`. Sin respaldo de los autores originales. De `dark-mode` solo se leyeron los títulos y las reglas sueltas, no el detalle de cada sección; las guías de efectos de nicho (WebGL, canvas, texturas, formas complejas) no se adaptan. La madurez de cada función está en `madurez-funciones.md` y envejece.

## 1. Fundamentos

- **Evitar duplicar conocimiento:** preferir variables a repetir valores, y las convenciones nativas a las variables: `currentColor`, `inherit`, `em`, las unidades de contenedor (`cqi`, `cqb`). Código repetido no es conocimiento repetido: el objetivo es robustez, no ahorrar caracteres.
- **Propiedades lógicas** (`margin-inline-start`) en vez de físicas, para que el estilo se adapte al sentido de escritura y a las herramientas de traducción. No usarlas por reflejo: preguntarse "¿querría que esto se invierta en un idioma de derecha a izquierda?"; si no, la física.
- Pensar siempre en modo oscuro, alto contraste, distintos tamaños de pantalla y distintos métodos de entrada (táctil, teclado, puntero).

## 2. Cascada y especificidad

- **No usar BEM para controlar la especificidad:** usar capas (`@layer`) con un orden declarado de antemano (`reset, base, tema, componentes, utilidades`) y `:where()` dentro de cada capa para que los selectores compitan solo por lo que importa. (BEM sigue siendo válido como convención de nombres; ver `SKILL.md`, Regla 3.)
- Usar `inherit`, `initial`, `unset` o `revert` en vez de valores explícitos, para expresar la intención.
- **Sin reinicios globales sobre `*`:** no se pueden sobrescribir desde componentes web ni desde capas de menor prioridad sin `!important`. Aplicar el reinicio a tipos de elemento o condiciones concretas.
- **`:has()`** para dar estilo al contenedor según el estado de un hijo (`label:has(:checked)`) en vez de gestionar clases con JavaScript; no se puede anidar `:has()` ni usar pseudoelementos dentro.
- **`:is()` / `:where()`** en vez de duplicar reglas para tener alternativas ante pseudoclases que podrían no estar soportadas.
- **`:not()`** para excluir estados; **`@scope`** para excluir subárboles anidados a cualquier profundidad y cuando la **cercanía** debe ganar sobre la especificidad (por ejemplo, clases de tema `.dark` y `.light` anidadas en cualquier orden).
- **CSS anidado nativo** para agrupar estilos relacionados cuando mejora la lectura.

## 3. Tokens de diseño y tema

- Propiedades personalizadas en `:root` para colores, fuentes y tamaños, con tantos niveles como el proyecto necesite (de valores primitivos a tokens de componente); un demo o una app pequeña pueden tener uno solo: no sobreingeniar. Revisar las convenciones de nombres existentes antes de inventar otras.
- **No poner valores no triviales en línea:** `background: transparent` o `padding: 0` sí; `background: #f06` o `padding: .3em` no.
- Las consultas de estilo sobre contenedor (`@container style()`) permiten variaciones contextuales de un componente sin acoplarlo a quien las produce. Su estado es "newly" desde 2026-05-19 y Can I use la da con soporte parcial en ~91 % del uso global: usar con alternativa (ver `madurez-funciones.md`).

## 4. Tipografía

- `line-height` sin unidad (`1.5`); `rem` (no `px`) para tamaños de fuente, para respetar la preferencia del usuario.
- **No fijar `height` ni `block-size` en elementos con texto** (botones, insignias, tarjetas): dejar que el contenido defina la altura, con `min-block-size` si hace falta.
- Líneas de no más de 80 caracteres; evitar `text-align: justify` (o combinarlo con `hyphens: auto` y un `lang` declarado); no usar solo mayúsculas para enfatizar; limitar el énfasis.
- Ampliación hasta 200 % sin perder contenido y reflujo a 320 px CSS sin scroll horizontal (WCAG 1.4.10); evitar `white-space: nowrap` y anchos fijos en texto corrido.
- `text-wrap: balance` en titulares y encabezados de tabla; **no** aplicarlo a `*` (tiene costo) ni sobre elementos con caja visible.
- Tamaños responsivos con `clamp()` combinando unidades relativas al viewport y a la fuente (por ejemplo `clamp(2rem, 1rem + 5vw, 4rem)`); nunca `vw` solo.
- Un `overflow-wrap: break-word` o `anywhere` para contener URL largas.

## 5. Color y contraste

- **No comunicar estado ni existencia de un control solo con color:** ícono, forma o texto (WCAG 1.4.1). Éxito y error, nunca solo en verde y rojo.
- **Contraste mínimo:** 4,5:1 para texto normal y 3:1 para texto grande (24 px, o 18,66 px en negrita) e íconos; **3:1 para los bordes y estados de los controles** (borde de un campo, marca de un checkbox, indicador de foco) (WCAG 1.4.3 y 1.4.11).
- `@media (prefers-contrast: more)` solo cuando el diseño usa acentos de bajo contraste (bordes sutiles, texto secundario apagado) que haya que reforzar.
- **Modo de colores forzados (alto contraste):** el navegador reemplaza los colores, quita `box-shadow`, `text-shadow` y fondos con degradado, y a veces `border-image`. **No** usar `background-image`, `box-shadow` ni `border-image` para señalar bordes, separadores o estado. `forced-color-adjust: none` solo donde el color es información (un selector de color, un resaltador de sintaxis), nunca "por estética".
- **Generar tonos:** primero buscar un token que ya exista. Si hay que generarlos, **no** ajustar solo la luminosidad en `oklch`/`oklab` (el navegador aún no hace el mapeo de gama y el resultado es impredecible); usar `color-mix()` con blanco o negro, por defecto `in oklab`, no `in srgb` ni `in oklch` con neutros.
- `contrast-color()` para el color del **texto** sobre un fondo dinámico, nunca para el fondo; referenciar las mismas variables de fondo (Baseline "newly"; con alternativa).

## 6. Modo claro y oscuro

- Declarar los esquemas soportados en el HTML (`<meta name="color-scheme" content="light dark">`) y en la raíz del CSS (`color-scheme: light dark`), para que controles de formulario, barras de desplazamiento y fondo por defecto se adapten. **No** fijar `light` ni `dark` como valor por defecto de la raíz.
- Respetar `prefers-color-scheme: dark` y definir los tokens de color en pares claro/oscuro (`light-dark()` o variables por esquema).
- Si hay un control manual, ver el patrón en `componentes.md` ("Modo oscuro"): la mayoría de los sitios no necesita un botón permanente.
- Un `<iframe>` no puede detectar de forma fiable el esquema del documento que lo contiene en Safari: pasarlo explícitamente (parámetro de URL o `postMessage`).
- **No animar ni hacer transiciones de `scrollbar-color`** (un error de WebKit hace parpadear la barra).

## 7. Interfaz generada por el navegador

Antes de recrear controles, barras de desplazamiento, selecciones o mensajes de error del navegador, comprobar que **no** se pueden personalizar lo suficiente con CSS moderno y que el cambio justifica perder semántica accesible, teclado, IME y tecnología asistiva que lo nativo trae.

- `::selection`, `accent-color` (los tres motores; Safari desde 26.2), `color-scheme`, `scrollbar-color` (con el pulgar visiblemente distinto de la pista, contraste ≥ 3:1).
- **No** `user-select: none` en texto de contenido (rompe copiar, traducir y la lectura desde un punto); limitarlo a elementos de la interfaz.
- **No** `scrollbar-width` distinto de `auto` sin otra forma accesible de desplazarse (el pulgar fino es demasiado pequeño para algunas personas).
- **No** `resize: none` en `<textarea>` sin una alternativa (`field-sizing: content` o botones propios).
- **No** `<input type="button|submit|reset">`: usar `<button>`.
- Estilo de validez con `:user-invalid` / `:user-valid`, **no** `:invalid` / `:valid`.
- Checkbox, radio e interruptor: `appearance: none` más contenido generado, o `label:has(:checked)`. Mantener el `<select>` nativo (selector del sistema, teclado y accesibilidad incluidos); no recrearlo con `<div>`s.

## 8. Diseño adaptable

- Componentes que se adaptan al espacio que reciben (consultas de contenedor, estado "widely" desde 2023-02-14) en vez de solo a la pantalla; no fijar breakpoints cuando se puede medir.
- **No** consultar `height`/`block-size` sobre un contenedor `inline-size`: solo mide el ancho. **No** truncar titulares con `text-overflow: ellipsis` ni recortar controles con `overflow: hidden` en sus padres. **No** usar `overflow-x: hidden` o `clip` en `html`/`body` para evitar el scroll horizontal: se corta contenido; arreglar el elemento demasiado ancho. No usar `overflow: hidden` para tapar problemas de layout.
- Al ampliar el zoom el contenedor no debe volverse más pequeño (para poder llegar al 200 % del texto).
- Mantener el teclado móvil, las barras del sistema y el notch fuera de los controles.
