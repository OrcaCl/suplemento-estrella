---
name: frontend-conventions
description: Convenciones de frontend para proyectos con renderizado server-side (templates + CSS + JS) — atomicidad de archivos por componente, nomenclatura BEM, y el puente data-* para pasar datos del servidor a JavaScript sin mezclar sintaxis del motor de templates dentro de archivos .js. Úsala siempre que se esté creando o modificando un componente de UI, un archivo CSS, un archivo JavaScript, o un template que necesite pasar datos al cliente. El ejemplo de referencia usa Jinja2/Flask, pero la regla aplica a cualquier motor de templates server-side (Blade, EJS, etc.).
---

# Frontend Conventions

Tres reglas que se sostienen juntas: un componente vive en un archivo, las clases siguen una nomenclatura predecible, y el JavaScript nunca depende de la sintaxis del motor de templates del backend.

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

## Regla 2 — styles.css como único índice

`styles.css` no contiene reglas propias — es exclusivamente una cadena de `@import` que define el orden de carga.

```css
@import url('globales/colores.css');
@import url('globales/reset.css');
@import url('globales/helpers.css');
@import url('globales/base.css');
@import url('componentes/modal.css');
@import url('componentes/tabla.css');
/* un @import por componente, en el orden en que se agregan */
```

Nunca vincular un archivo CSS de componente directamente desde un template, saltándose `styles.css` — eso rompe la capacidad de tener un solo punto de verdad sobre qué estilos están activos.

## Regla 3 — Nomenclatura BEM

Todas las clases siguen el patrón Block-Element-Modifier:

```css
.bloque { }
.bloque__elemento { }
.bloque--modificador { }
```

Ejemplos reales: `.modal__header`, `.tabla--compacta`, `.btn-convert--sm`.

Evitar selectores anidados profundos o dependientes de la jerarquía del DOM (`.modal .header .title`) — BEM hace que cada clase sea autocontenida y describible sin necesitar ver el HTML alrededor.

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

Si una columna de tabla usa un acrónimo o texto abreviado en el encabezado, agregar una ayuda visual (ícono de interrogación o tooltip vía librería como Tippy.js) con `aria-*` correspondiente para accesibilidad — no dejar el encabezado sin explicación, incluso si parece obvio para quien lo escribió.

## Por qué esta regla existe

Mezclar sintaxis del motor de templates dentro de `.js` hace que ese archivo deje de ser JavaScript válido por sí solo — no se puede lintear con herramientas estándar, no se puede testear en aislamiento, y no se puede mover a un bundler o CDN sin reescribirlo. El patrón `data-*` mantiene cada capa (HTML generado por el servidor, CSS, JS) verificable de forma independiente.