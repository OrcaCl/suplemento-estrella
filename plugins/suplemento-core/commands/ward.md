---
description: Guarda en brain/ y SPEC.md todo lo pendiente desde el último ward o cierre de sesión, y hace commit local (sin push). No usar para commits de código intermedios; para cerrar sesión usar listeilor.
---

## Instrucciones

Al recibir la palabra "ward" del humano, ejecutar en orden:

0. **Aviso de colisión — antes de escribir nada.** Buscar en el proyecto comandos o skills locales que respondan a los mismos nombres: `.claude/commands/{ward,listeilor,checkpoint}.md` y `.claude/skills/{ward,listeilor,checkpoint}/`. Si existe alguno, avisar al humano qué archivo es, mostrar en qué se diferencia de este comando (qué pasos hace y cuáles no) y **no sobrescribirlo ni borrarlo sin confirmación**. Un `checkpoint.md` local heredado de 0.11 o anterior sigue respondiendo a "checkpoint" y suele seguir el modelo antiguo que acumula en `SPEC.md` — ver `skills/spec-driven-development/references/migracion-0.12.md`.
1. Revisar qué se hizo desde el último ward o cierre de sesión: commits de código sin documentar, cambios relevantes, decisiones tomadas en la conversación.
2. **`brain/sesiones.md`** — agregar entrada con hitos, archivos clave y resultados medibles.
3. **`SPEC.md`** — reemplazar, no acumular (ver skill `spec-driven-development`, secciones "Árbitro de destino", "Reemplazar, no acumular" y "Regla de cierre de un ítem"):
   - **Cerrar un ítem:** borrar su fila de la §3 → insertarla en `spec/cerrados.md` **con el mismo ID que traía en la lista de pendientes**, en su posición por ID ascendente (el archivo se ordena por ID, no por orden de llegada), con formato `**ID — ✅ CERRADO (fecha)[, motivo].** Título. 1–2 frases de qué se hizo o por qué se descartó + evidencia` → agregar el ID a la lista "Cerrados" de la §3. Si el ítem se cierra por "ya estaba hecho", la evidencia debe ser **verificable** (consulta, test o commit), no solo "se implementó".
   - La fila "Última sesión" de la §2 se sobrescribe (≤ ~400 caracteres). Filas "Sesión anterior": exactamente las que declare `sesiones_anteriores_en_spec` (por defecto 0); lo más antiguo vive solo en `brain/sesiones.md`.
   - "Última actualización" es solo la fecha; el footer es una línea (≤ ~300 caracteres) con versión, fecha y métricas clave del dominio.
   - La narrativa va a `brain/sesiones.md`, nunca a `SPEC.md`.
4. **Reconciliación de pendientes.** Buscar `- [ ]` y listas de pendientes **fuera de §3** (secciones "Próxima sesión", "Prioridad N", "Pendientes de X", checklists dentro de otras secciones): consolidar cada uno como ítem de §3 o marcarlo obsoleto/cerrado con fecha. Revisar también si la narrativa de esta sesión dejó colas sin ítem (algo "quedó pendiente" solo en prosa) y proponerlas como ítems nuevos — con ID nuevo, nunca reutilizando uno cerrado.
5. **`brain/index.md`** — actualizar si hay registros nuevos de cualquier categoría (solo tabla + puntero a `sesiones.md`, nunca resumen de sesión — ver skill `brain-kms`).
6. **Crear el registro que corresponda, según la categoría** (ver skill `brain-kms` para el criterio completo de cuál usar):
   - **`brain/ADR-NNN.md`** — decisión que afecta lo que el sistema hace o cómo se comporta
   - **`brain/INT-NNN.md`** — decisión que afecta solo cómo el humano y Code trabajan juntos (proceso, herramientas, o convenciones de comunicación)
   - **`brain/NOC-NNN.md`** — hallazgo de riesgo o cuidado mixto, a monitorear, sin ser todavía una decisión
   - **`brain/DEP-NNN.md`** — retiro de una herramienta, archivo, patrón o plugin
   - **`brain/REF-NNN.md`** — hallazgo u observación propia de este proyecto
   - **`brain/REFX-NNN.md`** — referencia traída manualmente desde otro proyecto (nunca consultada por Code por su cuenta — ver guardrail abajo)
7. Mostrar al humano un resumen breve de lo que se va a registrar **antes** de escribir los archivos — no asumir silenciosamente qué contó como hito, ni qué categoría corresponde si hay ambigüedad entre dos.
8. Completar la sección `## Commit` de cualquier `ADR`/`INT`/`NOC`/`DEP` creado en esta sesión, apuntando a la entrada de `sesiones.md` recién agregada.
9. **Chequeo de `SPEC.md` — obligatorio, antes del commit:** revisar la lista de topes de la skill `spec-driven-development` ("Tope de tamaño"): líneas ≤ `spec_tope_lineas` (1000 por defecto) y ninguna > 600 caracteres, filas "Sesión anterior" = `sesiones_anteriores_en_spec`, footer de una línea con la misma versión que la cabecera, ningún `- [ ]` fuera de §3 ni `[x]` dentro de ella, IDs sin duplicar. Si algo excede, condensar y mover el contenido a su destino — **no commitear un `SPEC.md` excedido**. Si está al 80 % del tope, avisar al humano.
10. `git commit` con mensaje descriptivo del período cubierto. **Sin `git push`:** ward guarda localmente; el push lo hace `listeilor` al cerrar la sesión. Informar al humano que quedó commit local sin pushear.

No usar este comando para commits de código intermedios — es exclusivamente para el registro de documentación (`brain/`, `SPEC.md`) diferido según la skill `documentation-convention`.

## Guardrail — REFX nunca dispara navegación a otro proyecto

Si el paso 6 involucra crear o referenciar un `REFX-NNN.md`, ese contenido es información que el humano trae manualmente — **Code no navega, lee, ni consulta el proyecto de origen mencionado**, ni siquiera "para tener más contexto" antes de escribir el registro. Si hace falta más información del otro proyecto, eso se pide explícitamente al humano; nunca es una decisión autónoma de ir a buscarla.

## Uso

Se invoca diciendo "ward" en la conversación (o `/suplemento-core:ward`). Sin argumentos — siempre opera sobre todo lo pendiente de registrar desde el último ward o cierre de sesión.
