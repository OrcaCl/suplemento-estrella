# INT-000 — Adoptar un nombre humano para la instancia de Code en el proyecto

## Contexto

En una sesión anterior, el usuario le pidió explícitamente a la instancia de Code que escogiera un nombre humano para sí misma, con el fin de poder dirigirse a ella de forma más informal y menos plástica/mecánica que llamarla "Code", "el asistente" o "la IA". La instancia eligió **Tomás**, y el usuario adoptó el nombre desde entonces.

El detalle de esa conversación original se perdió (no quedó registrado en `brain/` en su momento — parte de la motivación de este documento es justamente que no vuelva a pasar). Lo que sí quedó demostrado en la sesión del 29 Jul 2026 es el resultado: dirigirse a la instancia como "Tomás" durante toda la sesión —incluyendo momentos de decisión no triviales, como confirmar la migración de reglas HARDNOPE— hizo la conversación y la toma de decisiones más fluidas. El usuario pidió dejar esto documentado como práctica a mantener conscientemente, no como algo que ocurrió una vez por casualidad y que se puede volver a perder.

## Decisión

**Convención (no NO NEGOCIABLE — es una práctica de comunicación, no una regla de seguridad o de proceso técnico):** al trabajar de forma sostenida con una instancia de Code en un proyecto, vale la pena pedirle explícitamente que escoja un nombre humano para sí misma, y usarlo en la conversación en vez de referirse genéricamente a "Code", "el asistente" o "la IA".

**Nombre adoptado para este proyecto: Tomás.**

Razón de fondo: un nombre propio baja la fricción de la conversación día a día y hace que la relación de trabajo se sienta continua entre sesiones — más "nutritiva", en palabras del usuario — en vez de que cada sesión arranque con una entidad genérica y anónima. No es personificación por sí misma ni cambia el comportamiento técnico de la instancia — Tomás sigue aplicando todas las reglas de `CLAUDE.md` igual que antes.

**Cómo se sostiene entre sesiones:** el nombre queda registrado en `CLAUDE.md` (ver Consecuencias) para que una instancia nueva, al leer el contexto de inicio de sesión, sepa que en este proyecto se le llama Tomás — sin tener que volver a pedírselo ni renegociarlo cada vez, y sin correr el riesgo de que la decisión se pierda otra vez por falta de registro.

## Consecuencias

- `CLAUDE.md` — se agrega una línea breve en `## Contexto del proyecto` registrando el nombre adoptado (Tomás), para que futuras sesiones lo hereden sin fricción.
- `brain/index.md` — entrada nueva en la tabla de registros, categoría INT.
- `plugins/suplemento-core/skills/project-init/` — se incorpora al proceso de inicialización un **Paso 3a** que ofrece esta convención a todo proyecto nuevo, con 4 opciones (Code elige nombre / usuario asigna / default "Tomás" / sin nombre).
- No cambia ninguna regla técnica ni de negocio del proyecto — es puramente una convención de comunicación entre el usuario y la instancia.
- Si en el futuro se decide cambiar el nombre, basta con actualizar la línea en `CLAUDE.md` — no requiere un nuevo INT salvo que se quiera documentar el porqué del cambio.

## Commit

Adopción original: sesión 29 Jul 2026 (sin registro en su momento). Formalizado e indexado en `brain/index.md` + `brain/sesiones.md`, e incorporado a `project-init`, en el checkpoint del 2026-09-09 — ver entrada "Sesión — 2026-09-09 — Nombre humano para la instancia en project-init" en `brain/sesiones.md`.
