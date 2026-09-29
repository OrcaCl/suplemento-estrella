---
description: Registra en brain/ y SPEC.md todo lo pendiente desde el último checkpoint o cierre de sesión, y hace commit + push. No usar para commits de código intermedios.
---

## Instrucciones

Al recibir la palabra "checkpoint" del humano, ejecutar en orden:

1. Revisar qué se hizo desde el último checkpoint o cierre de sesión: commits de código sin documentar, cambios relevantes, decisiones tomadas en la conversación.
2. **`brain/sesiones.md`** — agregar entrada con hitos, archivos clave y resultados medibles.
3. **`SPEC.md`** — reemplazar, no acumular (ver skill `spec-driven-development`, secciones "Árbitro de destino" y "Reemplazar, no acumular"): los ítems cerrados salen de la §3 hacia `spec/completado.md` (1 línea con fecha); la fila "Última sesión" de la §2 se sobrescribe (≤ ~400 caracteres, sin filas "Sesión anterior"); "Última actualización" es solo la fecha; el footer (≤ ~300 caracteres) lleva versión, fecha y métricas clave del dominio (conteo de tests solo si el proyecto tiene tests). La narrativa va a `brain/sesiones.md`, nunca a `SPEC.md`.
4. **`brain/index.md`** — actualizar si hay registros nuevos de cualquier categoría (solo tabla + puntero a `sesiones.md`, nunca resumen de sesión — ver skill `brain-kms`).
5. **Crear el registro que corresponda, según la categoría** (ver skill `brain-kms` para el criterio completo de cuál usar):
   - **`brain/ADR-NNN.md`** — decisión que afecta lo que el sistema hace o cómo se comporta
   - **`brain/INT-NNN.md`** — decisión que afecta solo cómo el humano y Code trabajan juntos (proceso, herramientas, o convenciones de comunicación)
   - **`brain/NOC-NNN.md`** — hallazgo de riesgo o cuidado mixto, a monitorear, sin ser todavía una decisión
   - **`brain/DEP-NNN.md`** — retiro de una herramienta, archivo, patrón o plugin
   - **`brain/REF-NNN.md`** — hallazgo u observación propia de este proyecto
   - **`brain/REFX-NNN.md`** — referencia traída manualmente desde otro proyecto (nunca consultada por Code por su cuenta — ver guardrail abajo)
6. Mostrar al humano un resumen breve de lo que se va a registrar **antes** de escribir los archivos — no asumir silenciosamente qué contó como hito, ni qué categoría corresponde si hay ambigüedad entre dos.
7. Completar la sección `## Commit` de cualquier `ADR`/`INT`/`NOC`/`DEP` creado en esta sesión, apuntando a la entrada de `sesiones.md` recién agregada.
8. **Chequeo de tamaño de `SPEC.md` — obligatorio, antes del commit:** correr `wc -c SPEC.md` y `awk 'length>600{print NR}' SPEC.md`. Si pasa de ~15 KB (15000 bytes) o alguna línea supera 600 caracteres, condensar y mover el contenido a su destino primero — no commitear un `SPEC.md` excedido.
9. `git commit` con mensaje descriptivo del período cubierto.
10. `git push` — el registro no existe hasta que está pusheado (ver skill `documentation-convention`).

No usar este comando para commits de código intermedios — es exclusivamente para el registro de documentación (`brain/`, `SPEC.md`) diferido según la skill `documentation-convention`.

## Guardrail — REFX nunca dispara navegación a otro proyecto

Si el paso 5 involucra crear o referenciar un `REFX-NNN.md`, ese contenido es información que el humano trae manualmente — **Code no navega, lee, ni consulta el proyecto de origen mencionado**, ni siquiera "para tener más contexto" antes de escribir el registro. Si hace falta más información del otro proyecto, eso se pide explícitamente al humano; nunca es una decisión autónoma de ir a buscarla.

## Uso

Se invoca diciendo "checkpoint" en la conversación. Sin argumentos — siempre opera sobre todo lo pendiente de registrar desde el último checkpoint o cierre de sesión.