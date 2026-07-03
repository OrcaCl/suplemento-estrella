---
name: sequential-mode
description: Regla de modo de trabajo por defecto — ejecución secuencial, una tarea a la vez, sin lanzar subagentes en paralelo salvo independencia clara y beneficio evidente. Úsala siempre que estés por decidir si dividir una tarea en subagentes paralelos, cuando el usuario pida "hazlo rápido" o "en paralelo", o cuando un plugin de flujo de trabajo (como Superpowers) sugiera dispatching-parallel-agents o subagent-driven-development por defecto. Esta skill es la que decide si esa sugerencia aplica o se anula para este proyecto.
---

# Sequential Mode

Modo de trabajo por defecto en proyectos PROMATIC: una tarea a la vez, confirmación explícita entre pasos, sin paralelismo salvo justificación clara.

## La regla

Trabajar siempre en modo secuencial. No lanzar subagentes en paralelo salvo que se cumplan **ambas** condiciones a la vez:

1. Las tareas son completamente independientes entre sí (ninguna depende del resultado de otra)
2. El beneficio de tiempo es evidente, no solo teórico

Si solo se cumple una condición, seguir en modo secuencial.

## Por qué — el razonamiento, no solo la regla

El paralelismo multiplica el consumo de tokens por el número de agentes activos simultáneos. En la mayoría de los proyectos PROMATIC las tareas son mayoritariamente secuenciales y dependientes entre sí (un cambio de schema afecta al importador, que afecta al detector, que afecta a la vista) — el paralelo no solo no ahorra tiempo en ese caso, agrega el costo de tener que reconciliar resultados de agentes que trabajaron con contexto parcial entre sí.

Esta regla existe para preservar presupuesto de tokens y evitar errores de reconciliación, no por preferencia estética.

## Interacción con plugins que promueven paralelismo por defecto

Si el proyecto tiene instalado un plugin de flujo de trabajo que activa subagentes automáticamente ante 2+ tareas independientes (ej. una skill tipo `dispatching-parallel-agents` o `subagent-driven-development`), esta skill **anula ese comportamiento por defecto** salvo que se cumplan las dos condiciones de arriba. No es que el plugin esté mal — es que el default del plugin no es el default de este proyecto.

Cuando se detecte que un plugin está a punto de lanzar subagentes en paralelo, confirmar explícitamente con el usuario antes de proceder, en vez de dejar que el comportamiento por defecto del plugin decida solo.

## Cómo pedir confirmación entre pasos

El modo secuencial no es solo "no paralelizar" — incluye confirmar con el usuario antes de avanzar al siguiente paso de un plan, en vez de encadenar automáticamente paso 1 → paso 2 → paso 3 sin pausa. Esto aplica especialmente a:

- Antes de crear archivos nuevos o estructura de carpetas nueva
- Antes de ejecutar una migración de base de datos
- Antes de instalar una dependencia nueva
- Entre fases de un plan multi-paso ya aprobado, si cada fase representa una unidad de trabajo verificable por sí sola

No aplica a acciones triviales y reversibles dentro de una misma tarea ya confirmada (ej. no hace falta confirmar cada línea de código dentro de una función que ya se acordó escribir).

## Ejemplo de cuándo SÍ paralelizar

Dos tareas que son genuinamente independientes y verificables por separado — por ejemplo, escribir tests para dos módulos distintos que no comparten estado ni se importan entre sí, donde el resultado de uno no cambia cómo se aborda el otro. Ahí el paralelo sí tiene sentido y el beneficio de tiempo es real, no solo teórico.

## Ejemplo de cuándo NO paralelizar (aunque parezca tentador)

Migrar un modelo de base de datos y, "en paralelo", actualizar el código que lo consume. Aunque técnicamente son archivos distintos, el segundo depende del resultado exacto del primero (nombres de columnas, tipos, constraints) — son secuenciales aunque toquen archivos diferentes.