# SPEC

`SPEC.md` es el panel de control del proyecto.

Resume el estado actual, las prioridades, las reglas críticas, las decisiones permanentes y el estado general del desarrollo.

Cuando el proyecto crece, la información se distribuye dentro de la carpeta `spec/`, manteniendo `SPEC.md` como índice principal.

## Por qué no dejar que crezca sin límite

`SPEC.md` no debería tener más de ~1000 líneas de texto — pasado ese punto, tanto el humano como el agente empiezan a "marearse" con las directrices y la dirección del proyecto.

Si `SPEC.md` crece demasiado, la recomendación es **mover** (no borrar) las decisiones importantes aprendidas durante el desarrollo hacia archivos específicos dentro de `spec/`.

La plantilla inicial de `spec/` incluye archivos como `api.md`, `datos.md`, `completado.md`, `objetivos.md`, etc.

Durante la inicialización, el agente puede preguntar si deseas dejar el archivo `objetivos.md` tal cual o renombrarlo a algo que represente mejor la tarea principal o los objetivos de tu proyecto. En este mismo repo, por ejemplo, `objetivos.md` se renombró a `roadmap-skills.md`.
