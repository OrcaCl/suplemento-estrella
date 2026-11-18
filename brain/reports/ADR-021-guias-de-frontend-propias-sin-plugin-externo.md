# ADR-021 — Guías de frontend propias, sin depender del plugin Modern Web Guidance

**Estado:** Vigente (reemplaza la recomendación de la ADR-015 y el punto 3 de la ADR-020 sobre consultar el plugin)
**Fecha:** 2026-11-18

## Contexto

La ADR-015 recomendó instalar Modern Web Guidance como plugin de Claude Code. Al leer su skill apareció que ejecuta `npx -y modern-web-guidance@latest …` en cada consulta (código de terceros sin versión fija), recopila telemetría anónima (IDs de guías y búsquedas generadas por el agente; se desactiva con `DISABLE_TELEMETRY=1`), se declara "obligatoria" para toda tarea web y exige una sección propia en las respuestas. El autor pidió no depender de una skill externa con esos comportamientos y actualizar la skill propia con lo que esa fuente ofrece.

## Decisión

1. **No se recomienda ni se requiere instalar Modern Web Guidance.** Si el humano lo tiene instalado, sus guías son una referencia: gana la regla del proyecto.
2. **`frontend-conventions` incorpora tres listas de verificación propias**, adaptadas de las guías `accessibility`, `forms` y `ui-components` de esa fuente (Apache-2.0): `references/accesibilidad.md`, `references/formularios.md` y `references/componentes.md`, con la madurez de cada función tal como la declaran las guías en noviembre de 2026. Se leyeron las 4 guías de accesibilidad, las de formularios (la general y las descripciones de las demás) y las 22 de componentes (los puntos clave de cada una); **no** las demás categorías.
3. **Atribución y licencia (Apache-2.0):** cada archivo adaptado lleva un encabezado con la fuente, la licencia y los cambios; se incluye una copia de la licencia (`references/LICENSE-Apache-2.0.txt`); `NOTICE.md` declara la adaptación. La fuente no trae un archivo `NOTICE` propio que haya que reproducir.
4. **La seguridad de formularios se cruza con `seguridad-por-diseno`:** la fila de frontend ahora incluye CSRF, `POST` para cambiar estado, HTTPS y CSP sin JavaScript en línea, que la skill de seguridad no cubría.
5. **Convención general:** todo material de terceros que se adapte sigue ese mismo procedimiento (encabezado, copia de la licencia si la exige, entrada en `NOTICE.md`); queda escrito en `docs/conventions.md`.

## Alternativas descartadas

- **Seguir recomendando el plugin con la versión fijada:** no se puede fijar desde fuera, porque su skill ordena `@latest`.
- **Copiar las 210 guías:** se desactualizan y duplican mantenimiento; se adaptó solo lo que el trabajo habitual necesita.

## Consecuencias

- Las listas son una **instantánea de noviembre de 2026**: la madurez de las funciones cambia. Se mitiga marcando la fecha, exigiendo verificar en MDN o Baseline, y revisándolas en un `housekeeping` o `ketchup` (ítem 25).
- Quedan sin adaptar las demás categorías de esa fuente (color, tipografía, movimiento, rendimiento, comportamientos de interfaz, seguridad del navegador, etc.).
- Se agregan 3 archivos de referencia y una copia de la licencia al plugin; hay que mantener la atribución al actualizarlos.

## Commit

Ver entrada "Sesión — 2026-11-18 — guías propias de frontend y atribución" en `brain/sesiones.md`.
