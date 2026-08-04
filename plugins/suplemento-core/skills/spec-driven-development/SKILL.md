---
name: spec-driven-development
description: Disciplina de trabajo diario con SPEC.md y la carpeta spec/ como fuente de verdad del proyecto. Úsala siempre que el usuario pida una tarea de desarrollo nueva, al iniciar cualquier sesión de trabajo (leer SPEC.md primero), al completar una tarea o breakthrough (actualizar SPEC.md y spec/ de inmediato), o cuando haya que decidir en qué archivo va cada pieza de información. También aplica cuando spec/historial.md empieza a crecer demasiado y hay que evaluar si el proyecto necesita escalar a brain/ ADR.
---

# Spec-Driven Development

Cómo trabajar día a día una vez que el proyecto ya tiene `SPEC.md` + `spec/` (creados por la skill `project-init`). Esta skill no crea estructura — gobierna el flujo de lectura/escritura sobre la estructura que ya existe.

## Regla de apertura de sesión

Antes de cualquier acción, leer `SPEC.md` completo (es corto a propósito, esto no debería costar tokens significativos) y confirmar contexto con el mensaje exacto definido en `CLAUDE.md`:

```
✅ Contexto cargado — SPEC.md v[VERSION]
| [N] tests | Próximo paso: [PRIMER_ITEM_PENDIENTE]
```

No empezar a trabajar sin esta confirmación — es la forma de detectar temprano si `SPEC.md` está desactualizado respecto al estado real del código (ver "Detección de inconsistencias" más abajo).

## Regla de cierre de sesión — registro inmediato, no acumulado

Después de cualquier breakthrough (feature completada, bug crítico resuelto, migración ejecutada), actualizar de inmediato, antes de seguir con la siguiente tarea:

1. `SPEC.md` — marcar ítems `[x]`, actualizar tabla de estado (sección 2) y footer con conteo de tests
2. `spec/completado.md` — agregar la línea del ítem completado
3. `spec/historial.md` — agregar contenido de references/historial-md-template.md
4. Si el proyecto usa `brain/`: evaluar si esta decisión amerita un ADR nuevo (ver skill `brain-adr` para el criterio)

**No esperar al cierre de sesión para hacer esto.** Acumular actualizaciones "para el final" es la causa más común de que `SPEC.md` quede desactualizado.

## Dónde va cada cosa — tabla de decisión

| Si estás documentando... | Va en... |
|---|---|
| Estado actual resumido, pendientes activos, reglas no negociables | `SPEC.md` |
| Cómo hablar con una API/sistema externo | `spec/api.md` |
| Que una tarea se completó (solo el hecho) | `spec/completado.md` |
| Por qué se completó de esa forma, qué se descubrió en el camino | `spec/historial.md` |
| Una convención, diccionario, o dato de referencia (nunca secretos) | `spec/datos.md` |
| Un ítem de backlog, venga del usuario o sugerido por el agente | `spec/{{objetivos}}.md` |
| Una decisión de arquitectura costosa de revertir | `brain/ADR-NNN.md` (solo si el proyecto usa estructura completa) |
| Una pregunta tangencial, no urgente, para otra audiencia | `brain/TOASK.md` (solo estructura completa) |

Si algo no encaja claramente en una fila, es señal de que puede necesitar su propio archivo dentro de `spec/` — pero antes de crear uno nuevo, confirmar con el usuario. No expandir la estructura de archivos sin esa confirmación.

## Detección de inconsistencias entre SPEC.md y el código real

`SPEC.md` puede desincronizarse del estado real del proyecto — por ejemplo, una sección de pendientes con checkboxes sin marcar que en realidad ya se completaron hace varias sesiones, simplemente porque nadie volvió a actualizar esa sección específica cuando el trabajo evolucionó por otro camino.

Cuando se detecta una inconsistencia de este tipo:
1. No asumir silenciosamente cuál versión es la correcta — confirmar con el usuario.
2. Una vez confirmado, corregir `SPEC.md` de inmediato (no dejarlo para después).
3. Si la sección quedó inconsistente por haber evolucionado en varios pasos (ADR tras ADR, por ejemplo), documentar en `spec/historial.md` o en el ADR correspondiente que hubo una corrección de documentación, con fecha — para que quede trazable que el código iba bien y era la documentación la que estaba atrás, no al revés.

## Señal de que el proyecto necesita escalar a brain/

`spec/completado.md` + `spec/historial.md` cumplen la función de un sistema de decisiones mientras el proyecto es chico. Señales de que conviene escalar a `brain/` (si el proyecto no lo tenía desde el inicio):

- `spec/historial.md` supera un tamaño que empieza a consumir contexto de forma notoria en cada sesión
- Han aparecido 3+ decisiones de arquitectura que valdría la pena poder referenciar individualmente por ID en vez de tener que buscarlas dentro de una narrativa larga
- El proyecto empezó a integrar con un segundo sistema externo o ganó un segundo colaborador (humano o agente) trabajando en paralelo

Si se detecta esta señal, proponerlo al usuario explícitamente — no migrar la estructura sin confirmación. Ver skill `brain-adr` para el proceso de migración.

## Relación con el "modo de trabajo secuencial"

Spec-driven development asume que las tareas se ejecutan una a la vez, confirmando con el usuario antes de avanzar al siguiente paso — coherente con el modo de trabajo secuencial ya definido en `CLAUDE.md`. No usar esta skill como excusa para lanzar trabajo en paralelo sobre múltiples secciones de `SPEC.md` a la vez.