# Decisiones

Cómo se registran y se mantienen las decisiones técnicas y metodológicas dentro de [Brain KMS](brain.md).

> **`brain.md` ≠ `decisions.md`.** [brain.md](brain.md) explica el sistema Brain KMS como metodología (qué es, qué carpetas y documentos tiene). Este documento explica cómo se gestionan las **decisiones** dentro de ese sistema: cuándo se registran, en qué categoría y cómo evolucionan.

La skill que gobierna esto es `brain-kms`.

---

## ¿Qué categoría uso?

| Prefijo | Documenta | Ejemplo |
|---|---|---|
| **ADR** | Una decisión que afecta **lo que el sistema hace o cómo se comporta** | Elegir un ORM; que `SPEC.md` se reemplace en vez de acumularse (ADR-006) |
| **INT** | Una decisión que afecta **solo cómo el humano y el agente trabajan juntos** | Test quirúrgico en vez de suite completa; ponerle un nombre humano a la instancia (INT-000) |
| **NOC** | Un riesgo o cuidado mixto, **a monitorear**, todavía no una decisión | Una tabla con datos sensibles creciendo rápido |
| **DEP** | El **retiro** de una herramienta, archivo, patrón o plugin | Dejar de usar un plugin obsoleto |
| **REF** | Contexto de dominio propio del proyecto, sin estructura de decisión | Notas de investigación |
| **REFX** | Material traído **desde otro proyecto**, con su procedencia explícita | Una solución vista en otro proyecto propio |

**Criterio de corte ADR vs. INT, en una frase:** si la decisión cambia lo que el sistema hace o cómo se comporta desde afuera, es ADR. Si solo afecta el proceso o la relación de trabajo, es INT — aunque sea algo tan poco técnico como un nombre.

Si una tarea siguió un patrón ya registrado, no genera registro nuevo: basta con `sesiones.md`.

---

## Cómo evoluciona una decisión

- Un **ADR o INT no se edita para cambiar la decisión original.** Si la decisión cambia, se crea uno nuevo y el anterior se marca `Obsoleto — reemplazado por ADR-XXX`.
- Un **NOC sí se actualiza** en el lugar, con entradas de seguimiento fechadas, porque es vigilancia activa.
- Un **DEP no cambia de estado**: es un hecho consumado. Si algo retirado se vuelve a adoptar, eso es un ADR o INT nuevo.
- **REF y REFX** no tienen vigencia: son contexto, no decisiones.
- Cada prefijo tiene su **propia numeración** secuencial. Excepción: un registro puede llevar `000` cuando es conceptualmente anterior a uno existente de su categoría (p. ej. INT-000).

## Estructura de un ADR

Contexto → opciones evaluadas → decisión → razones → consecuencias → (validación, si la hay) → commit. Se parte de `brain-adr-template.md` en `project-init/references/` (cada categoría tiene su propia plantilla ahí). Un ADR es formal; un NOC, menos; un DEP, breve.

## La sección `## Commit`

Todo ADR e INT termina con una sección `## Commit` que apunta a su entrada en `brain/sesiones.md`. Si el registro se creó antes de que exista ese commit, se anota explícitamente como "pendiente al próximo `ward` o cierre de sesión" en vez de omitir la sección o inventar una referencia.

## Cuándo se registran

No a mitad de la codificación. Las decisiones se registran en el **`ward`** o el **cierre de sesión (`listeilor`)** (ver [workflow.md](workflow.md)): el agente propone qué registrar y qué categoría corresponde, y muestra el resumen al humano **antes** de escribir. Si dos categorías compiten, pregunta.

## El índice

`brain/index.md` contiene únicamente la tabla de registros y un puntero a `sesiones.md`. Nunca un resumen de sesión.

---

Ejemplos reales: los registros de este mismo repo en [`brain/`](../brain/index.md).
