---
name: frontend-conventions
description: Convenciones de frontend para proyectos con renderizado server-side (templates + CSS + JS) — atomicidad de archivos por componente, un único punto de verdad para los estilos con cascade layers, nomenclatura BEM, el puente data-* y el uso de la plataforma web moderna para pasar datos del servidor a JavaScript sin mezclar sintaxis del motor de templates dentro de archivos .js. Úsala siempre que se esté creando o modificando un componente de UI, un archivo CSS, un archivo JavaScript, o un template que necesite pasar datos al cliente. El ejemplo de referencia usa Jinja2/Flask, pero la regla aplica a cualquier motor de templates server-side (Blade, EJS, etc.).
---

# Frontend Conventions

Cuatro reglas que se sostienen juntas: un componente vive en un archivo, los estilos se cargan desde un único punto de verdad, las clases siguen una nomenclatura predecible, y el JavaScript nunca depende de la sintaxis del motor de templates del backend. Además, se prefiere la plataforma web moderna antes que librerías (ver la última sección).

## Regla 1 — Atomicidad de archivo por componente

Cada componente de UI tiene su propio archivo CSS y, si necesita interactividad, su propio archivo JS. Nunca mezclado en un archivo monolítico de estilos o de scripts.

```
static/
├── css/
│   ├── globales/       # reset, colores, base, helpers — compartido por todo el sitio
│   ├── componentes/     # un archivo por componente (modal.css, tabla.css, etc.)
│   ├── vendor/          # librerías externas, sin modificar
│   └── styles.css       # índice — ver Regla 2
├── js/
│   ├── globales/        # utilidades compartidas
│   ├── componentes/      # un archivo por componente
│   └── vendor/           # librerías externas
```

**Librerías externas siempre en `vendor/`** — nunca cargadas desde un CDN en producción. Esto evita requests externos y garantiza que la app funcione sin depender de disponibilidad de terceros.

## Regla 2 — Un único punto de verdad para los estilos (sin cadenas de `@import`)

Debe existir **un solo lugar** que defina qué estilos están activos y en qué orden. Ese lugar es un **parcial del template** (por ejemplo `_estilos.html`) que lista un `<link>` por archivo y que todas las páginas incluyen:

```html
<!-- _estilos.html — único punto de verdad de los estilos -->
<link rel="stylesheet" href="{{ url_for('static', filename='css/globales/capas.css') }}">
<link rel="stylesheet" href="{{ url_for('static', filename='css/globales/colores.css') }}">
<link rel="stylesheet" href="{{ url_for('static', filename='css/globales/reset.css') }}">
<link rel="stylesheet" href="{{ url_for('static', filename='css/globales/base.css') }}">
<link rel="stylesheet" href="{{ url_for('static', filename='css/componentes/modal.css') }}">
<link rel="stylesheet" href="{{ url_for('static', filename='css/componentes/tabla.css') }}">
<!-- un <link> por componente, en el orden en que se agregan -->
```

Nunca vincular un CSS de componente directamente desde otro template, saltándose el parcial: rompe el punto único de verdad.

**Por qué no `@import`.** Una cadena de `@import` en un CSS obliga al navegador a descargar los archivos en secuencia (cada uno revela el siguiente), lo que retrasa la construcción del CSSOM y, con ella, el primer pintado. Con `<link>` el navegador los pide en paralelo. (Hasta la 0.15.0 esta regla mandaba un `styles.css` hecho solo de `@import`; los proyectos que lo tienen siguen funcionando, solo pagan ese costo.)

**El orden de prioridad lo fija `@layer`, no el orden de carga.** `capas.css` se carga primero y declara las capas una sola vez:

```css
/* capas.css */
@layer reset, base, tema, componentes, utilidades;
```

Cada archivo pone sus reglas dentro de su capa:

```css
/* componentes/modal.css */
@layer componentes {
  .modal { }
  .modal__header { }
}
```

Una capa posterior gana sobre una anterior sin importar la especificidad de los selectores, así que un componente nunca necesita subir su especificidad para ganarle al reset.

**Cuidado con lo que queda fuera de las capas:** una regla que no pertenece a ninguna capa **gana** a las que sí están en capas. Todo el CSS propio va dentro de una capa; el de `vendor/`, que suele venir sin capas, puede imponerse al propio y hay que revisarlo (si molesta, se importa dentro de una capa con `@import url('vendor/x.css') layer(vendor)` en un único archivo de vendor).

Si el proyecto ya tiene un paso de build, concatenar los archivos en uno solo en producción es válido y más rápido; el punto único de verdad sigue siendo la lista ordenada de archivos fuente.

## Regla 3 — Nomenclatura BEM (para nombres, no para especificidad)

Todas las clases siguen el patrón Block-Element-Modifier:

```css
.bloque { }
.bloque__elemento { }
.bloque--modificador { }
```

Ejemplos reales: `.modal__header`, `.tabla--compacta`, `.btn-convert--sm`.

Evitar selectores anidados profundos o dependientes de la jerarquía del DOM (`.modal .header .title`) — BEM hace que cada clase sea autocontenida y describible sin necesitar ver el HTML alrededor.

**BEM da nombres predecibles; no es la herramienta para controlar la especificidad.** Para eso están `@layer` (Regla 2) y `:where()`: un valor por defecto envuelto en `:where()` (por ejemplo `:where(.modal__header) { padding: 1rem; }`) tiene especificidad cero y cualquier regla posterior lo sobrescribe sin trucos. Si un componente necesita ganar, se resuelve poniéndolo en una capa posterior, no alargando el selector.

Se puede usar **CSS anidado nativo** dentro de un bloque para estados y modificadores cuando mejora la lectura (`.modal { &:hover { } &.modal--compacta { } }`), sin anidar más de un nivel. Ojo: el nativo **no concatena sufijos**: `&__header` es sintaxis de Sass y no funciona en CSS; los elementos BEM se escriben como clases completas (`.modal__header`). En un proyecto que ya usa otra convención de nombres, se respeta esa antes de imponer BEM.

## Regla 4 — Cero sintaxis del motor de templates en archivos .js

**Regla absoluta: ningún archivo `.js` contiene sintaxis del motor de templates del backend** (`{{ }}`, `{% %}` en Jinja2; `@{{ }}` en Blade; etc.).

El puente entre servidor y JavaScript es siempre un contenedor HTML con atributos `data-*`, renderizado por el motor de templates, oculto (`hidden`) para no afectar el layout.

### Para escalares (strings, números, booleans)

```html
<div id="componente-app-data"
     data-patente="{{ patente }}"
     data-tz-param="{{ tz_param }}"
     hidden></div>
```

```javascript
const _appData = document.getElementById('componente-app-data');
const _PATENTE = _appData ? _appData.dataset.patente : '';
const _TZ_PARAM = _appData ? _appData.dataset.tzParam : 'default';
```

### Para JSON (listas, objetos)

Usar comillas simples en el atributo HTML para no chocar con las comillas dobles del JSON serializado:

```html
<div id="componente-app-data"
     data-items='{{ items | tojson }}'
     hidden></div>
```

```javascript
const ITEMS = _appData ? JSON.parse(_appData.dataset.items) : [];
```

### Seguridad del puente `data-*` (XSS)

El puente solo es seguro si el motor de templates **escapa el valor según su contexto**. Jinja2 con autoescape y `| tojson` lo hace (escapa `<`, `>`, `&` y `'`); no todos los motores ni todos los modos lo hacen:

- Nunca usar la salida **sin escapar** en estos atributos: `| safe` (Jinja2), `<%- %>` (EJS), `{!! !!}` (Blade). Un dato con una comilla puede cerrar el atributo e inyectar HTML o JS.
- Comprobar que el autoescape está activo (en Jinja2 fuera de Flask puede venir desactivado).
- En JS, leer el valor con `dataset` y `JSON.parse`; no volver a escribirlo con `innerHTML`.
- Un dato que viene del usuario o de una fuente externa se trata como no confiable en cualquier caso (ver `seguridad-por-diseno`, fila Frontend).
- Para listas u objetos, una alternativa más robusta que el atributo es un bloque de datos: `<script type="application/json" id="componente-items">{{ items | tojson }}</script>`, leído con `JSON.parse(document.getElementById('componente-items').textContent)`. No depende de las comillas del atributo; `tojson` de Jinja2 escapa `<`, `>` y `&`, de modo que el dato no puede cerrar la etiqueta `<script>`.
- Si hay que insertar HTML que viene de un usuario, no usar `innerHTML`: usar la Sanitizer API (`setHTML()`) y, si el proyecto exige defensa en profundidad, Trusted Types con una CSP (guías `sanitize-untrusted-html` y `trusted-types` de Modern Web Guidance).

### Convención de nomenclatura

- El contenedor lleva un `id` semántico (`<nombre-componente>-app-data`)
- Los atributos HTML usan kebab-case (`data-desde-hora`)
- El JS los lee vía `dataset` en camelCase (`dataset.desdeHora`) — es la conversión automática del navegador, no hace falta transformarlo a mano
- El contenedor siempre lleva `hidden`

### Guard obligatorio para estado vacío

Cuando la página puede renderizarse sin datos del servidor (ej. un formulario vacío antes de la primera consulta), el contenedor `data-*` puede no existir. El JS debe protegerse siempre:

```javascript
const _appData = document.getElementById('componente-app-data');
const ITEMS = _appData ? JSON.parse(_appData.dataset.items) : [];

if (_appData) {
    // Todo el código que depende de datos del servidor va aquí adentro
    inicializarComponente();
}
```

Sin este guard, un `null.dataset` revienta el script en cualquier página donde el contenedor no se haya renderizado.

## Ayuda para columnas/encabezados con acrónimos o texto truncado

Si una columna de tabla usa un acrónimo o texto abreviado en el encabezado, agregar una ayuda visual (ícono de interrogación o tooltip; antes de sumar una librería como Tippy.js, revisar si `popover` y el posicionamiento por anclaje de CSS ya lo resuelven en los navegadores que el proyecto soporta) con `aria-*` correspondiente para accesibilidad — no dejar el encabezado sin explicación, incluso si parece obvio para quien lo escribió.

## Plataforma web moderna — preferir lo nativo antes que una librería

Las reglas anteriores ordenan *cómo se organiza* el frontend; esta sección es sobre *qué primitivas usar*. Los modelos de lenguaje suelen proponer patrones heredados porque sus datos de entrenamiento los favorecen. Por defecto, y siempre que el proyecto lo soporte, preferir lo que la plataforma ya trae:

- `<dialog>` y el atributo `popover` en vez de modales y menús hechos a mano con JavaScript.
- Consultas de contenedor (`@container`), `:has()`, CSS anidado, `@layer` y `@scope` en vez de JavaScript o cadenas de selectores para estilos que dependen del contexto.
- Propiedades lógicas (`margin-inline-start`) en vez de físicas cuando el estilo debe adaptarse al sentido de escritura.
- `color-scheme` y `prefers-color-scheme` para modo oscuro; validación de formularios y `autocomplete` nativos antes que scripts propios.
- Transiciones de vista y animaciones por CSS antes que librerías de animación.

**Política de soporte de navegadores.** Declararla en el `CLAUDE.md` del proyecto con una línea como `**Soporte de navegadores:** Baseline Widely available`. Las funciones que ya son Baseline y están ampliamente disponibles se usan sin alternativa; las más nuevas exigen un respaldo (por ejemplo `:where()` con una clase equivalente) o una decisión explícita del humano.

**Guías externas (opcional).** Si el proyecto tiene instalado el plugin *Modern Web Guidance* (GoogleChrome/modern-web-guidance, Apache-2.0; ver ADR-015 y ADR-016), consultarlo **antes** de escribir HTML, CSS o JavaScript de cliente que no sea trivial: diálogos, formularios, animaciones, accesibilidad, rendimiento o seguridad del navegador. Dos cuidados: su skill ejecuta `npx -y modern-web-guidance@latest …` en cada consulta, es decir, código de terceros sin versión fija; y exige agregar una sección "Modern Web Guidance" al final de las respuestas que lo usen. Sus guías son una referencia, no una orden: si contradicen una regla de este proyecto (como BEM o la Regla 2), gana la regla del proyecto, y se informa la divergencia al humano.

Esta sección se basó en la lectura de esa guía externa (no se copia su texto); la fuente y la licencia están en `NOTICE.md`.

## Por qué esta regla existe

Mezclar sintaxis del motor de templates dentro de `.js` hace que ese archivo deje de ser JavaScript válido por sí solo — no se puede lintear con herramientas estándar, no se puede testear en aislamiento, y no se puede mover a un bundler o CDN sin reescribirlo. El patrón `data-*` mantiene cada capa (HTML generado por el servidor, CSS, JS) verificable de forma independiente.