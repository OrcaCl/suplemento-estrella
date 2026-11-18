---
name: frontend-conventions
description: Convenciones de frontend para proyectos con renderizado server-side (templates + CSS + JS) — atomicidad de archivos por componente, un único punto de verdad para los estilos con cascade layers, nomenclatura BEM, el puente data-* la accesibilidad y los formularios, y el uso de la plataforma web moderna para pasar datos del servidor a JavaScript sin mezclar sintaxis del motor de templates dentro de archivos .js. Úsala siempre que se esté creando o modificando un componente de UI, un archivo CSS, un archivo JavaScript, o un template que necesite pasar datos al cliente. El ejemplo de referencia usa Jinja2/Flask, pero la regla aplica a cualquier motor de templates server-side (Blade, EJS, etc.).
---

# Frontend Conventions

Cuatro reglas de organización que se sostienen juntas: un componente vive en un archivo, los estilos se cargan desde un único punto de verdad, las clases siguen una nomenclatura predecible, y el JavaScript nunca depende de la sintaxis del motor de templates del backend. Además, la accesibilidad y los formularios no son opcionales, y se prefiere la plataforma web moderna antes que librerías (ver las dos últimas secciones y las listas de `references/`).

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
- Si hay que insertar HTML que viene de un usuario, no usar `innerHTML` a secas: sanearlo **en el servidor** y/o con una biblioteca revisada alojada en `vendor/` (Regla 1; la guía fuente usa DOMPurify), y para defensa en profundidad Trusted Types con una CSP (ver `seguridad-por-diseno/references/seguridad-web-navegador.md`).

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

Si una columna de tabla usa un acrónimo o texto abreviado en el encabezado, agregar una ayuda visual (ícono de interrogación o tooltip; antes de sumar una librería como Tippy.js, revisar si `popover` ya lo resuelve en los navegadores que el proyecto soporta (el posicionamiento por anclaje de CSS todavía es de disponibilidad limitada: ver `references/madurez-funciones.md`)) con `aria-*` correspondiente para accesibilidad — no dejar el encabezado sin explicación, incluso si parece obvio para quien lo escribió.

## Accesibilidad y formularios — no son opcionales

Toda interfaz nueva o modificada cumple, como mínimo, lo siguiente. El detalle está en las listas de verificación de `references/`; lo que no se pueda cumplir se avisa al terminar la tarea (igual que en `seguridad-por-diseno`).

- **HTML nativo antes que ARIA:** `<button>`, `<a href>`, `<label>`, `<dialog>`, `<details>`, `<progress>`; un `<div role="button">` es un error.
- **Todo control tiene nombre y etiqueta visible:** `<label for>`; `placeholder` y `title` no son etiquetas.
- **Todo es operable con teclado**, con foco visible (`:focus-visible`) y objetivos de al menos 24×24 px.
- **Una estructura de página coherente:** `lang`, `<title>` único, un `<main>`, un `<h1>`, sin saltos de encabezado; `alt` informativo o `alt=""`.
- **Formularios:** `autocomplete` correcto, validación nativa con `:user-invalid`, errores enlazados con `aria-describedby` y anunciados, no bloquear el pegado, `POST` y token anti-CSRF para cambiar estado.
- **Modales con `<dialog>` y `.showModal()`**, sin trampa de foco propia.
- **Se prueba con el teclado solo**, no solo con una herramienta automática.

Listas de verificación en `references/` (todas adaptadas de Modern Web Guidance, Apache-2.0; ADR-021 y ADR-022):

| Archivo | Qué cubre |
|---|---|
| `accesibilidad.md` | Estructura, ARIA, nombres, teclado y foco, medios, regiones en vivo, pruebas |
| `formularios.md` | Estructura, etiquetas, autocompletado, validación, seguridad, direcciones, varios pasos y guías específicas |
| `componentes.md` | Patrones de modal, acordeón, pestañas, menús, navegación, carrusel, toast, etc. |
| `css-y-diseno.md` | CSS moderno, tokens, tipografía, color y contraste, modo oscuro, interfaz del navegador |
| `html-y-js.md` | HTML semántico, componentes web y JavaScript moderno |
| `rendimiento.md` | Ruta crítica, imagen principal, INP, terceros, imágenes, fuentes, caché |
| `comportamientos.md` | Movimiento reducido, transiciones, reordenar, gestos, tablas |
| `madurez-funciones.md` | Estado de 159 funciones web (instantánea de noviembre de 2026) |

Para la seguridad del navegador (cabeceras, cookies, CSP, passkeys, privacidad) ver `seguridad-por-diseno/references/seguridad-web-navegador.md`.

## Plataforma web moderna — preferir lo nativo antes que una librería

Las reglas anteriores ordenan *cómo se organiza* el frontend; esta sección es sobre *qué primitivas usar*. Los modelos de lenguaje suelen proponer patrones heredados porque sus datos de entrenamiento los favorecen. Por defecto, y siempre que el proyecto lo soporte, preferir lo que la plataforma ya trae:

- `<dialog>` y el atributo `popover` en vez de modales y menús hechos a mano con JavaScript.
- Consultas de contenedor (`@container`), `:has()`, CSS anidado, `@layer` y `@scope` en vez de JavaScript o cadenas de selectores para estilos que dependen del contexto.
- Propiedades lógicas (`margin-inline-start`) en vez de físicas cuando el estilo debe adaptarse al sentido de escritura.
- `color-scheme` y `prefers-color-scheme` para modo oscuro; validación de formularios y `autocomplete` nativos antes que scripts propios.
- Transiciones de vista y animaciones por CSS antes que librerías de animación.

**Madurez y regla de inclusión.** Se recomienda por defecto lo que es Baseline "widely available"; lo "newly" (tres motores) se usa con alternativa si el proyecto lo exige. **Las funciones de uno o dos motores no se usan como base**: se omitieron de estas listas, y `references/madurez-funciones.md` las resume junto con el estado de las demás, contrastado con los datos de Can I use.

**Política de soporte de navegadores.** Declararla en el `CLAUDE.md` del proyecto con una línea como `**Soporte de navegadores:** Baseline Widely available`. Las funciones ya "widely available" se usan sin alternativa.

**Sin dependencia de una skill externa.** Estas listas se adaptaron de las guías de *Modern Web Guidance* (Apache-2.0; se leyeron todas sus categorías, ver ADR-022) para no depender de un plugin que ejecuta `npx -y …@latest` en cada consulta y recopila telemetría (ADR-021). **No hace falta instalarlo.** Si el humano lo tiene instalado, sus guías son una referencia, no una orden: si contradicen una regla del proyecto (como BEM o la Regla 2), gana la del proyecto, y se informa la divergencia. Las fuentes, sus licencias y los cambios hechos están en `NOTICE.md` y en el encabezado de cada archivo de `references/`.

## Por qué esta regla existe

Mezclar sintaxis del motor de templates dentro de `.js` hace que ese archivo deje de ser JavaScript válido por sí solo — no se puede lintear con herramientas estándar, no se puede testear en aislamiento, y no se puede mover a un bundler o CDN sin reescribirlo. El patrón `data-*` mantiene cada capa (HTML generado por el servidor, CSS, JS) verificable de forma independiente.