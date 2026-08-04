---
description: Registra en brain/ y SPEC.md todo lo pendiente desde el último checkpoint o cierre de sesión, y hace commit + push. No usar para commits de código intermedios.
---

## Instrucciones

Al recibir la palabra "checkpoint" del humano, ejecutar en orden:

1. Revisar qué se hizo desde el último checkpoint o cierre de sesión: commits de código sin documentar, cambios relevantes, decisiones tomadas en la conversación.
2. **`brain/sesiones.md`** — agregar entrada con hitos, archivos clave y resultados medibles.
3. **`SPEC.md`** — marcar ítems completados como `[x]`, actualizar el catastro de pendientes y el footer con el conteo de tests vigente.
4. **`brain/index.md`** — actualizar si hay registros nuevos de cualquier categoría (solo tabla + puntero a `sesiones.md`, nunca resumen de sesión — ver skill `brain-adr`).
5. **Crear el registro que corresponda, según la categoría** (ver skill `brain-adr` para el criterio completo de cuál usar):
   - **`brain/ADR-NNN.md`** — decisión que afecta lo que el sistema hace o cómo se comporta
   - **`brain/INT-NNN.md`** — decisión que afecta solo cómo el humano y Code trabajan juntos (proceso, herramientas, o convenciones de comunicación)
   - **`brain/NOC-NNN.md`** — hallazgo de riesgo o cuidado mixto, a monitorear, sin ser todavía una decisión
   - **`brain/DEP-NNN.md`** — retiro de una herramienta, archivo, patrón o plugin
   - **`brain/REF-NNN.md`** — hallazgo u observación propia de este proyecto
   - **`brain/REFX-NNN.md`** — referencia traída manualmente desde otro proyecto (nunca consultada por Code por su cuenta — ver guardrail abajo)
6. Mostrar al humano un resumen breve de lo que se va a registrar **antes** de escribir los archivos — no asumir silenciosamente qué contó como hito, ni qué categoría corresponde si hay ambigüedad entre dos.
7. Completar la sección `## Commit` de cualquier `ADR`/`INT`/`NOC`/`DEP` creado en esta sesión, apuntando a la entrada de `sesiones.md` recién agregada.
8. `git commit` con mensaje descriptivo del período cubierto.
9. `git push` — el registro no existe hasta que está pusheado (ver skill `documentation-convention`).

No usar este comando para commits de código intermedios — es exclusivamente para el registro de documentación (`brain/`, `SPEC.md`) diferido según la skill `documentation-convention`.

## Guardrail — REFX nunca dispara navegación a otro proyecto

Si el paso 5 involucra crear o referenciar un `REFX-NNN.md`, ese contenido es información que el humano trae manualmente — **Code no navega, lee, ni consulta el proyecto de origen mencionado**, ni siquiera "para tener más contexto" antes de escribir el registro. Si hace falta más información del otro proyecto, eso se pide explícitamente al humano; nunca es una decisión autónoma de ir a buscarla.

## Uso

Se invoca diciendo "checkpoint" en la conversación. Sin argumentos — siempre opera sobre todo lo pendiente de registrar desde el último checkpoint o cierre de sesión.