# SKILL: Frontend Conventions (Server-Side Templates & SSR)

## Propósito y Disparadores
Establece las reglas de desarrollo frontend para proyectos con renderizado server-side (Jinja2, Blade, EJS, etc.).
Aplica cuando se esté:
- Creando o modificando un componente de UI, hoja de estilos CSS o script JS.
- Pasando datos desde el backend (Python, PHP, Node) hacia el navegador.
- Integrando librerías de terceros en el cliente.

---

## 1. Atomicidad de Archivos y Estructura

Cada componente posee sus propios archivos dedicados.

static/
├── css/
│   ├── globales/         # colores.css, reset.css, base.css
│   ├── componentes/      # modal.css, tabla.css (1 archivo por componente)
│   ├── vendor/           # Librerías externas (JS/CSS) descargadas localmente
│   └── styles.css        # ÍNDICE ÚNICO
└── js/
    ├── globales/         # Utilidades compartidas
    ├── componentes/      # modal.js, tabla.js (1 archivo por componente)
    └── vendor/           # Librerías externas

Guardrail de CDNs: Prohibido cargar dependencias desde CDNs externos en producción. Guardar siempre los archivos compilados en static/*/vendor/.

## 2. Regla de Índice Único (styles.css)

styles.css no contiene reglas CSS directas, solo sentencias @import:

@import url('globales/colores.css');
@import url('globales/reset.css');
@import url('globales/base.css');
@import url('componentes/modal.css');
@import url('componentes/tabla.css');

Prohibido vincular archivos CSS individuales en las plantillas HTML.

## 3. Nomenclatura BEM (Block-Element-Modifier)

Todos los estilos de UI deben usar el patrón BEM para evitar la fragilidad del anidamiento en el DOM:

.modal { }
.modal__header { }
.modal__header--compacto { }

## 4. El Puente data-* (Cero Sintaxis de Templates en .js)

Regla Innegociable: NUNCA escribir etiquetas de motores de plantillas ({{ }}, {% %}, etc.) dentro de archivos .js.
Implementación HTML (Template Backend):

<div id="mi-componente-app-data"
     data-patente="{{ patente }}"
     data-items='{{ items | tojson }}'
     hidden></div>

Lectura en JavaScript Puramente Estático:

const _appData = document.getElementById('mi-componente-app-data');

// Guard Obligatorio contra estado vacío / null.dataset
if (_appData) {
    const PATENTE = _appData.dataset.patente || '';
    const ITEMS = _appData.dataset.items ? JSON.parse(_appData.dataset.items) : [];
    
    inicializarComponente(PATENTE, ITEMS);
}

## 5. Accesibilidad en Encabezados

Si una tabla o tarjeta incluye columnas con acrónimos o textos abreviados, se debe incorporar ayuda visual (tooltip con Tippy.js o ícono con atributación aria-label / aria-describedby).

