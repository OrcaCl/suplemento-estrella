# ADR-020 — `frontend-conventions`: estilos con parcial y `@layer`, BEM solo para nombres, plataforma moderna

**Estado:** Vigente
**Fecha:** 2026-11-18

## Contexto

Al comparar `frontend-conventions` con las guías de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, Apache-2.0; ver ADR-015) aparecieron dos contradicciones con nuestras reglas y un vacío:

1. **Regla 2** mandaba un `styles.css` hecho solo de `@import`. Su guía de rendimiento dice que `@import` en CSS crea cadenas de requests secuenciales que retrasan el CSSOM.
2. **Regla 3** imponía BEM. Su guía de CSS dice evitar BEM para controlar la especificidad y usar `@layer` y `:where()`, y a la vez revisar las convenciones existentes antes de inventar otras.
3. La skill organizaba el frontend pero no decía qué primitivas usar, y los modelos proponen patrones heredados por sus datos de entrenamiento.

## Decisión

1. **Regla 2:** el único punto de verdad de los estilos es un **parcial del template** con un `<link>` por archivo, no una cadena de `@import`. El orden de prioridad lo fija `@layer` declarado al inicio (`capas.css`), no el orden de carga. Con un build, concatenar en producción sigue siendo válido.
2. **Regla 3:** BEM **se conserva como convención de nombres**; la especificidad se controla con `@layer` y `:where()`. Se permite CSS anidado nativo para estados y modificadores (no concatena sufijos: `&__x` es de Sass). En proyectos con otra convención se respeta esa.
3. **Nueva sección "Plataforma web moderna":** preferir lo nativo (`<dialog>`, `popover`, consultas de contenedor, `:has()`, `@layer`, propiedades lógicas, `color-scheme`), una política de soporte de navegadores en `CLAUDE.md` y consulta opcional de Modern Web Guidance si está instalado. Sus guías son referencia, no orden: si contradicen una regla del proyecto, gana la del proyecto.
4. **Seguridad del puente `data-*`:** se agrega la alternativa de un bloque `<script type="application/json">` y los enlaces a las guías de Sanitizer API y Trusted Types.
5. Los proyectos que ya tienen `styles.css` con `@import` siguen funcionando; solo pagan el costo de rendimiento. No se migran solos.

## Alternativas descartadas

- **Concatenar siempre en un build:** el plugin no incluye scripts y no todos los proyectos tienen build.
- **Reemplazar BEM por anidamiento y `@scope`:** rompe la consistencia con los proyectos existentes y exige reescribir CSS.
- **Copiar las guías al plugin:** se desactualizan y duplican mantenimiento (ADR-015); se consulta el plugin externo en su lugar.

## Consecuencias

- La skill de Modern Web Guidance ejecuta `npx -y modern-web-guidance@latest` en cada consulta: código de terceros sin versión fija. Choca con el criterio de la ADR-016 (nada de terceros cambia sin revisión); queda abierto en el ítem 20 cómo fijar la versión o revisar cada ejecución.
- Su skill también exige una sección "Modern Web Guidance" en las respuestas y se declara "obligatoria" para toda tarea web: la regla de la skill de este proyecto es que gana lo que el proyecto decide.
- Se usó su contenido como lectura, no se copió texto; la fuente y la licencia se declaran en `NOTICE.md`.

## Commit

Ver entrada "Sesión — 2026-11-18 — `frontend-conventions` frente a Modern Web Guidance" en `brain/sesiones.md`.
