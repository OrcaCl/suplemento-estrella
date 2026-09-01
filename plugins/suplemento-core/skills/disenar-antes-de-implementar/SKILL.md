---
name: disenar-antes-de-implementar
description: Disciplina de diseño colaborativo antes de escribir código — clasificar el tamaño del trabajo, entender la intención real, proponer enfoque(s), y obtener aprobación explícita del humano antes de cualquier acción de implementación. Úsala siempre que se vaya a crear una feature, construir un componente, agregar funcionalidad, o modificar comportamiento existente — antes de tocar código, antes de entrar a modo plan, y antes de invocar cualquier skill de implementación. También cuando una tarea que parecía chica revela complejidad oculta a mitad de camino.
---

# Diseñar antes de implementar

Convertir una idea en un diseño acordado, a través de diálogo, antes de escribir código. El principio: **el humano aprueba la intención antes de que Code implemente** — la ceremonia escala con el tamaño de la tarea, la compuerta de aprobación nunca.

Esta skill es el paso previo a `spec-driven-development` (que gobierna qué archivo registra qué) y a `planificacion-por-fases` (que convierte un diseño aprobado en un plan ejecutable). Diseñar es entender *qué* se va a construir y *por qué*; recién después se decide *cómo* documentarlo y *en qué orden* implementarlo.

## Compuerta dura

No invocar ninguna skill de implementación, no escribir código, no andamiar (scaffold) nada, no tomar ninguna acción de implementación **hasta haberle dicho al humano qué se pretende hacer y que el humano lo haya aprobado.** Esto aplica a toda tarea en todo camino de abajo. El artefacto de diseño puede ser dos frases en el chat; la aprobación no es opcional en ningún caso.

## Los tres caminos

Antes de la primera pregunta, clasificar la petición y **decir la clasificación en voz alta** — "esto se ve acotado, así que presento un diseño corto acá en vez de escribir un spec" — para que el humano pueda corregirla.

### Sondeo (spike)

Una pregunta de factibilidad ("¿se puede...?", "¿es posible...?", "rápido y sucio está bien"). La salida es una **respuesta, no código que se conserva**.

- Presentar la pregunta y qué se va a probar en 2-3 frases.
- Obtener un visto bueno (basta un "dale").
- Investigar tan barato como la corrección lo permita.
- Reportar hallazgos como recomendación. Cualquier cosa que se haya construido queda etiquetada como desechable.
- Sin documento de diseño, sin archivo de spec.

Si después el humano quiere conservar el código del sondeo, eso es una **petición nueva** — se clasifica de nuevo.

### Acotado (bounded)

Un cambio bien delimitado a código **que ya existe en este repo**: un flag nuevo, un endpoint chico, un fix de un archivo.

- **Acotado mide el repo, no la familiaridad de Code con el tipo de app.** Si el flujo que se va a cambiar no está ya acá para leerlo, la tarea no es acotada.
- Explorar el contexto del proyecto (archivos, docs, commits recientes).
- Hacer las preguntas de aclaración que importan — una por mensaje.
- Presentar un diseño corto **en el chat** (unas frases a un par de párrafos): enfoque, archivos que se tocan, cómo se va a probar.
- **PARAR y esperar un "sí" explícito.** Presentar el diseño y empezar a implementar en el mismo mensaje es saltarse la compuerta.
- Implementar por el flujo normal de desarrollo (aplica `tdd-workflow`). Sin documento de plan.

### Arquitectónico

Proyectos nuevos, subsistemas nuevos, cambios que reestructuran cómo encajan los componentes o alteran interfaces de las que otros dependen.

1. Explorar el contexto del proyecto.
2. Hacer preguntas de aclaración — una a la vez — sobre propósito, restricciones, criterios de éxito.
3. Proponer 2-3 enfoques con sus trade-offs, liderando con la recomendación y el porqué. YAGNI sin piedad — sacar toda feature innecesaria de cada enfoque.
4. Presentar el diseño **en secciones escaladas a su complejidad** (unas frases si es directo, hasta ~200-300 palabras si tiene matices). Preguntar después de cada sección si va bien. Cubrir: arquitectura, componentes, flujo de datos, manejo de errores, testing.
5. Obtener aprobación del humano sección por sección.
6. Escribir el spec/diseño validado donde corresponda según `spec-driven-development` (proyecto simple: `spec/`; proyecto con `brain/`: el registro `ADR` correspondiente + entrada en `sesiones.md`). Commitear.
7. Auto-revisión del spec: escanear por placeholders ("TBD", "TODO"), contradicciones internas, ambigüedad (¿algún requisito se puede interpretar de dos formas?), y alcance (¿esto es un solo plan, o hay que descomponerlo?). Arreglar inline.
8. Pedirle al humano que revise el spec escrito antes de seguir.
9. Recién ahí: invocar `planificacion-por-fases`.

**Ante la duda entre dos caminos, tomar el más pesado.** El trinquete es de una sola dirección: complejidad oculta descubierta a mitad de tarea sube el camino — parar, decirlo, y subir. Nada baja de camino a mitad de tarea.

## Anti-patrón: "demasiado simple para necesitar aprobación"

Todo camino termina con el humano aprobando la intención antes de implementar. Una lista de tareas, una función utilitaria de una línea, un cambio de config — el diseño puede ser dos frases en el chat, pero **hay que presentarlo y obtener aprobación**. Las tareas "simples" son donde las suposiciones no examinadas causan más trabajo perdido. Lo que escala con la simplicidad es el artefacto, nunca la aprobación.

## Señales de alerta — STOP

| Pensamiento | Realidad |
|---|---|
| "Esto es muy simple para necesitar diseño" | Simple significa un diseño corto, no ningún diseño. Dos frases en el chat, después aprobación. |
| "Le pongo la etiqueta de acotado y me salto el spec" | Buscar una etiqueta para saltarse trabajo ES la duda — tomar el camino más pesado. |
| "Es acotado y el diseño es obvio, empiezo mientras lo lee" | La compuerta es la aprobación, no el largo del diseño. Presentar y parar hasta escuchar el "sí". |
| "Entiendo este tipo de app, así que es acotado" | Acotado mide el repo, no la familiaridad. Un proyecto nuevo no tiene flujo existente — es arquitectónico. |
| "El sondeo funciona, conservo el código" | La salida de un sondeo es una respuesta. Conservar el código es una petición nueva — clasificarla. |
| "Creció, pero ya casi termino — no hace falta reclasificar" | La complejidad oculta sube el camino a mitad de tarea. Parar y decirlo. |
| "Aprobó el sondeo, entonces el cambio siguiente también está aprobado" | Cada tarea tiene su propia clasificación y su propia aprobación. |

## Relación con otras skills

- **`sequential-mode`** — el diálogo de diseño es secuencial, una pregunta por mensaje. Nada de lanzar subagentes para "explorar en paralelo" el contexto del proyecto sin aprobación explícita.
- **`spec-driven-development`** — define en qué archivo va el diseño una vez aprobado. Esta skill termina donde esa empieza.
- **`planificacion-por-fases`** — el único paso siguiente después de un diseño arquitectónico aprobado. Nunca saltar de diseño directo a implementar en el camino arquitectónico.
- **`code-simplicity`** — el "YAGNI sin piedad" de la fase de enfoques es esa skill aplicada al diseño.

## Nota sobre plugins de flujo de trabajo

Si el proyecto tiene instalada una skill de "brainstorming" de un plugin genérico (por ejemplo Superpowers), esta skill la reemplaza: cubre el mismo ciclo (clasificar → entender → proponer → aprobar) adaptado a la metodología Suplemento Estrella y en español. La pieza propia es la integración con `spec-driven-development` y el sistema `brain/` en el paso de documentación — un plugin genérico escribe a una ruta fija tipo `docs/specs/`, esta skill respeta la estructura del proyecto (simple o `brain/`).
