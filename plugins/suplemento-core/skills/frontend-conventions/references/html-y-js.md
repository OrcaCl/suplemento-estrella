# HTML y JavaScript modernos — lista de verificación

> **Fuente y licencia:** adaptado de las guías `html`, `js`, `web-components` y las de componentes web de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance), licencia Apache-2.0 (copia en `LICENSE-Apache-2.0.txt`). **Cambios:** traducido al español, resumido y reorganizado; se omiten ejemplos de código y las guías de `Temporal` se resumen en una regla. Detalle en `NOTICE.md`. Sin respaldo de los autores originales. Las APIs de JavaScript se contrastaron con `web-features`. Se leyeron las guías generales de HTML y JavaScript y la descripción de las de componentes web; no cada una en detalle. La accesibilidad completa está en `accesibilidad.md`.

## HTML

- `<!DOCTYPE html>`; `lang` en `<html>` (y en cualquier elemento en otro idioma); `<meta name="viewport" content="width=device-width, initial-scale=1.0">`. **No** desactivar el zoom de la página.
- Semántica en vez de `<div>` y `<span>`: landmarks (`<header>`, `<nav>`, `<main>`, `<aside>`, `<footer>`; no más de un `banner`, `main` o `contentinfo`), `<search>` para búsquedas y filtros, un solo `<h1>`, jerarquía de encabezados sin saltos.
- `<button>` para acciones y `<a>` solo para navegar a una URL. `type="button"` en los botones de un formulario que no envían. Todo control interactivo con nombre accesible.
- Atributos booleanos sin valor redundante (`disabled`, no `disabled="disabled"`). **No** cambiar la semántica nativa con ARIA salvo requisito crítico; **no** `role="presentation"` ni `aria-hidden="true"` en elementos enfocables ni en sus ancestros.
- **Cita y código:** `<blockquote cite>` para citas extensas (no para sangría visual); `<figure>` solo cuando hay un pie o una unidad referenciada, con `<figcaption>`; `<cite>` para el **título** de una obra, no para el autor; `<code>` en línea y `<pre><code>` en bloque; si el bloque se desplaza, `tabindex="0"`, `role="region"` y un nombre (`aria-labelledby`).
- **Superposiciones nativas:** `<dialog>` con `.showModal()` para modales (foco, fondo atenuado y Esc incluidos) y botón de cierre visible; atributo `popover` para lo no modal (menús, ayudas); `<form method="dialog">` para cerrarlos sin JavaScript. `::backdrop` para el fondo. No llamar `showModal()` sobre un elemento con `popover` (son excluyentes; `<dialog popover>` sí es válido).
- **Divulgación:** `<details>`/`<summary>` con `<summary>` como primer hijo; `name` compartido para un acordeón exclusivo (con reservas, ver `componentes.md`). No anidar controles interactivos dentro de `<summary>`. No usar `title` como tooltip (no se alcanza con teclado).
- **Foco:** `inert` para secciones ocultas o el fondo mientras hay un modal propio; mantener el foco (devolverlo al disparador) cuando se oculta o elimina el elemento enfocado; mover el foco al contenido nuevo que el usuario pidió (abrir un diálogo, cambiar de vista). **Nunca** `tabindex` positivo; no alterar el orden con `order` o `flex-flow: row-reverse` sin alinear el DOM; no usar `focus({ preventScroll: true })` sin validarlo.
- **Formularios:** el atributo `form="id"` separa un control de su `<form>`. `autocomplete` con el token correcto; `current-password` para ingresar y `new-password` para registrarse o cambiar. `type`, `inputmode` y `autocomplete` controlan cosas distintas (validación, teclado y autocompletado) y van juntos. **No** `autocomplete="off"` en credenciales, direcciones, pagos o contacto: los navegadores lo ignoran por diseño.
- **Medios:** `width` y `height` en `<video>`, imagen `poster`, subtítulos con `<track>`. Un video de fondo va silenciado, con control del usuario y oculto a la tecnología asistiva (sin `controls`, para que no sea enfocable). **No** reproducir audio automáticamente sin un control accesible para detenerlo.
- **Estilos e interactividad:** el atributo `style` solo para pasar un valor a una propiedad personalizada de CSS (el estilo vive en la hoja). **No** estilos en línea de diseño estático ni manejadores en línea (`onclick="…"`): usar `addEventListener()` (y poder aplicar una CSP estricta, ver `seguridad-web-navegador.md`).

## Componentes web

- Son Custom Elements, Shadow DOM y plantillas: para sistemas de diseño y componentes que se reutilizan entre frameworks. Para el resto, HTML y CSS nativos bastan.
- **Evitar los elementos nativos personalizados** (`extends HTMLButtonElement` con `is="…"`): Safari declinó implementarlos.
- No sombrear atributos globales (`style`, `class`, `id`, `slot`, `part`, `title`, `lang`, `dir`, `role`) con propiedades propias.
- Un control propio que participe de un formulario usa elementos asociados a formularios (`formAssociated` y `ElementInternals`), **no** un `<input>` oculto.
- Shadow DOM es una frontera de estilos: solo las propiedades heredadas (incluidas las personalizadas) la cruzan. Las propiedades personalizadas son la API de tema; **evitar `:host-context()`** (Firefox y Safari no lo implementarán).
- Las referencias ARIA (`aria-labelledby`) **no cruzan** un shadow root: hay que resolverlas dentro del mismo árbol. Falta de semántica dentro del árbol sombreado es el fallo más común.
- Prerenderizar en el servidor con Declarative Shadow DOM ("widely" desde 2024-02-20) para que el componente tenga forma antes del JavaScript; no volver a renderizar el árbol al hidratar.

## JavaScript

Estado de estas APIs verificado en `web-features` (noviembre de 2026): `structuredClone()`, los métodos de arreglos por copia (`toSorted()`, `toReversed()`, `toSpliced()`, `with()`), el agrupamiento (`Object.groupBy()`, `Map.groupBy()`), `Promise.withResolvers()`, `AbortSignal.any()` y `.timeout()`, `Error cause`, `URLSearchParams` y `TextEncoder`/`TextDecoder` son **Baseline "widely available"**.

- **Copiar estado:** `structuredClone(valor)`, no `JSON.parse(JSON.stringify(valor))` ni `_.cloneDeep`. Conserva `Date`, `Map`, `Set`, referencias cíclicas y más; **no** conserva prototipos de clase, métodos ni campos `#privados`, y lanza error con nodos del DOM, funciones o `dataset`. No reemplazarlo si el código depende de la normalización a JSON.
- **Arreglos sin mutar:** `toSorted()`, `toReversed()`, `toSpliced()`, `with()`, `findLast()` y `findLastIndex()` en vez de copiar y mutar. Cuidado con iterables que no son arreglos (conservar `Array.from`) y con arreglos dispersos.
- **Agrupar:** `Object.groupBy()` o `Map.groupBy()` en vez de acumular con `reduce`; `Object.groupBy` devuelve un objeto sin prototipo (usar `Object.hasOwn`).
- **Asincronía:** `Promise.withResolvers()` en vez de variables externas mutables; `AbortSignal.timeout(ms)` para plazos y `AbortSignal.any([...])` para combinar cancelación del usuario y plazo. Un plazo vencido lanza `TimeoutError`, no `AbortError`: comprobar ambos.
- **Errores:** `new Error(mensaje, { cause: err })` en vez de concatenar mensajes. **No** devolver la cadena `cause` al cliente (puede traer consultas, rutas o credenciales): registrarla en el servidor.
- **URL y texto:** `URLSearchParams` (con `new URL(...).searchParams` desde una URL completa; nunca sobre `location.hash` ni sobre cookies); `TextDecoder`/`TextEncoder` en vez de `decodeURIComponent(escape(...))`.
- **DOM:** `contenedor.replaceChildren()` en vez de `innerHTML = ''` (que usa el analizador de HTML y falla con Trusted Types); `new CustomEvent(tipo, { detail, bubbles, cancelable, composed })`, no `createEvent`.
- **Fechas y zonas horarias:** guardar en UTC (ISO 8601) y convertir al mostrar con `Intl.DateTimeFormat` y una `timeZone` explícita; no asumir 12 meses por año ni el calendario gregoriano para todos los usuarios. Las guías de la fuente proponen la API `Temporal`, pero hoy está en uno o dos motores y no se usa como base.
