---
name: sequential-mode
description: Regla de modo de trabajo por defecto — ejecución secuencial, una tarea a la vez, CERO subagentes por defecto. Cualquier excepción requiere que Code se la pida explícitamente al humano y reciba aprobación puntual para esa tarea específica — nunca una decisión autónoma de Code. Úsala siempre que estés por considerar dividir una tarea en subagentes paralelos, cuando el usuario pida "hazlo rápido" o "en paralelo", o cuando un plugin de flujo de trabajo (como Superpowers) sugiera dispatching-parallel-agents o subagent-driven-development por defecto — incluyendo el momento exacto en que `writing-plans` presenta su menú de "Execution Handoff" o `executing-plans` recomienda subagentes al abrir. Esta skill decide si esa sugerencia aplica o se anula para este proyecto, sin importar que esté redactada como "recommended" o "REQUIRED SUB-SKILL".
---

# Sequential Mode

Modo de trabajo por defecto en proyectos Suplemento Estrella: una tarea a la vez, sin excepción autónoma. Esta versión endurece la regla original tras observar que, con actualizaciones del motor de Claude Code, excepciones redactadas como "si el beneficio es evidente" dejaron de comportarse como matices y empezaron a interpretarse como autorización por defecto — con el consiguiente consumo de tokens no deseado por subagentes lanzados sin pedirlo.

## La regla — sin frases de excepción condicional

**Cero subagentes por defecto, sin excepción.** No hay ninguna condición ("si son independientes", "si el beneficio es evidente") que autorice a Code a lanzar subagentes por su cuenta. Ese tipo de redacción quedó deliberadamente eliminada de esta skill — no porque el razonamiento fuera incorrecto, sino porque un motor más capaz puede interpretar la condición como ya cumplida sin consultar.

**La única forma de paralelizar es esta, en orden:**

1. Code identifica que una tarea *podría* beneficiarse de subagentes.
2. Code se lo pregunta explícitamente al humano, describiendo qué tareas dividiría y por qué.
3. El humano aprueba o rechaza, para **esa tarea puntual** — la aprobación no es un permiso general que se extiende a tareas futuras similares.
4. Solo con aprobación explícita, Code lanza los subagentes.

Sin el paso 2 y 3, la respuesta por defecto es siempre: ejecutar de forma lineal en la hebra principal.

## Por qué — el razonamiento no cambió, cambió el motor

El paralelismo multiplica el consumo de tokens por el número de agentes activos simultáneos. Eso siempre fue cierto. Lo que cambió es que antes bastaba con una condición razonada para que Code se autocontrolara; ahora, con el motor actualizado, la misma condición se leyó como autorización general y generó consumo de tokens no deseado en un proyecto real. La solución no es escribir una condición "más estricta" — es no dejar ninguna condición abierta a interpretación. La decisión de paralelizar deja de ser de Code y pasa a ser exclusivamente del humano, caso por caso.

## Interacción con plugins que promueven paralelismo por defecto

Si el proyecto tiene instalado un plugin de flujo de trabajo que activa subagentes automáticamente ante 2+ tareas independientes (ej. una skill tipo `dispatching-parallel-agents` o `subagent-driven-development`), esta skill **anula ese comportamiento por defecto sin excepción**. Cuando ese plugin esté a punto de lanzar subagentes, Code debe detenerse y preguntar al humano antes de proceder — nunca dejar que el default del plugin decida solo, ni siquiera en el caso que ese plugin documenta como "obviamente beneficioso".

**Esta autoridad no depende de que el otro plugin la reconozca.** La jerarquía "instrucciones del usuario > skills > comportamiento por defecto" suele vivir en un archivo *del otro plugin* (ej. `using-superpowers`), no en este. Esta skill no presta su autoridad de ese archivo ajeno — la declara acá, así que sigue aplicando aunque ese archivo cambie de redacción en una versión futura, o el proyecto ni siquiera lo tenga cargado en el momento de decidir.

**Puntos de choque conocidos, para reconocerlos sin tener que razonarlos cada vez:**

- `writing-plans`, sección "Execution Handoff": ofrece "Subagent-Driven (recommended)" como opción 1. No es una instrucción — es la preferencia por defecto de ese plugin. Preguntar al humano antes de tomarla.
- `executing-plans`: abre recomendando usar `subagent-driven-development` en su lugar "si hay subagentes disponibles". Misma regla: la disponibilidad técnica no es aprobación.
- Cualquier paso marcado `REQUIRED SUB-SKILL` que apunte a una skill de dispatch paralelo: "REQUIRED" describe cómo ese plugin encadena sus propias skills entre sí, no una autorización del humano en esta conversación.

| Racionalización | Por qué no aplica |
|---|---|
| "El plugin lo marca como 'recommended'" | Es la preferencia del plugin, no la aprobación del humano. |
| "Dice 'REQUIRED SUB-SKILL', así que es obligatorio" | Obligatorio para el flujo interno de ese plugin — no para saltarte el paso 2 (preguntar) de esta skill. |
| "Ya lo aprobaron para una tarea parecida antes" | La aprobación es puntual, no se hereda a tareas futuras similares (ver regla arriba). |

## Cómo pedir confirmación entre pasos (sin relación a subagentes)

El modo secuencial también incluye confirmar con el usuario antes de avanzar al siguiente paso de un plan, en vez de encadenar automáticamente paso 1 → paso 2 → paso 3 sin pausa. Esto aplica especialmente a:

- Antes de crear archivos nuevos o estructura de carpetas nueva
- Antes de ejecutar una migración de base de datos
- Antes de instalar una dependencia nueva
- Entre fases de un plan multi-paso ya aprobado, si cada fase representa una unidad de trabajo verificable por sí sola

No aplica a acciones triviales y reversibles dentro de una misma tarea ya confirmada (ej. no hace falta confirmar cada línea de código dentro de una función que ya se acordó escribir).

## Ejemplo de cómo se ve la pregunta correcta

> "Esta tarea tiene dos partes que no dependen entre sí: escribir tests para el módulo A y escribir tests para el módulo B. Podría lanzar un subagente por cada uno para que corran en paralelo — ¿lo apruebas para esta tarea, o prefieres que lo haga secuencial?"

Nunca:

> [Code lanza los subagentes directamente porque "las tareas son independientes y el beneficio es evidente"]

Esa segunda forma es exactamente el patrón que causó el problema real que motivó este endurecimiento — queda prohibida sin excepción.