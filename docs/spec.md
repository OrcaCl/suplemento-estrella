# SPEC

`SPEC.md` es el panel de control del proyecto.

Resume el estado actual, las prioridades, las reglas críticas, las decisiones permanentes y el estado general del desarrollo.

Cuando el proyecto crece, la información se distribuye dentro de la carpeta `spec/`, manteniendo `SPEC.md` como índice principal.

## Por qué no dejar que crezca sin límite

`SPEC.md` no debería pasar de **1000 líneas** (configurable con `spec_tope_lineas`), ni tener ninguna línea de más de 600 caracteres — pasado ese punto, tanto el humano como el agente empiezan a "marearse" con las directrices y la dirección del proyecto, y el archivo se carga completo al inicio de cada sesión.

La causa habitual de que crezca no es el proyecto, sino **acumular en vez de reemplazar**: en un proyecto real pasó de 5 KB a 134 KB en cuatro meses porque cada checkpoint agregaba un bloque nuevo sin borrar el anterior (ver ADR-006 en `brain/`). Por eso:

- "Última actualización" es solo la fecha, y "Última sesión" (§2) es **una** fila que se sobrescribe.
- Los ítems cerrados salen de la §3 y pasan al archivo único `spec/cerrados.md`, con **ID + fecha + evidencia**. La §3 es la **lista única** de pendientes: no hay `- [ ]` ni secciones "Próxima sesión" fuera de ella.
- Se pueden conservar N filas "Sesión anterior" si el proyecto lo declara (`sesiones_anteriores_en_spec`); por defecto ninguna.
- La narrativa de la sesión va a `brain/sesiones.md`, nunca a `SPEC.md`.
- Antes de commitear un cambio a `SPEC.md` corre `scripts/check_spec.sh`: sale con código ≠ 0 si excede los topes (líneas, líneas largas, filas de sesión, footer, pendientes fuera de §3). Con `--report` audita sin bloquear. Un tope se **ajusta**, no se ignora.

Si `SPEC.md` crece demasiado, la recomendación es **mover** (no borrar) el detalle hacia archivos específicos dentro de `spec/`.

La plantilla inicial de `spec/` incluye archivos como `api.md`, `datos.md`, `cerrados.md`, `objetivos.md`, etc.

Durante la inicialización, el agente puede preguntar si deseas dejar el archivo `objetivos.md` tal cual o renombrarlo a algo que represente mejor la tarea principal o los objetivos de tu proyecto. En este mismo repo, por ejemplo, `objetivos.md` se renombró a `roadmap-skills.md`.
