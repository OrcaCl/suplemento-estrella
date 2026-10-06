# Principios

Los principios concretos con los que trabaja Suplemento Estrella. Cada uno vive como skill del plugin — este documento explica el porqué y enlaza a la fuente.

> El **porqué de fondo** de la metodología (reutilizar método, no proyectos; el agente se adapta al proyecto) está en [philosophy.md](philosophy.md). Aquí están las reglas que se derivan de eso.

---

## Simplicidad de código — KISS, DRY y no sobreingeniería

Skill: `code-simplicity`. En este orden de prioridad cuando chocan entre sí:

1. **KISS.** La solución más simple que resuelva el problema *como está planteado hoy*, no como podría plantearse en el futuro. Tres líneas directas valen más que una abstracción prematura.
2. **DRY, con límite.** Duplicar dos veces está bien; la tercera vez se evalúa abstraer. Una abstracción con un solo caso de uso no es DRY, es sobreingeniería con otro nombre.
3. **Evitar sobreingeniería, salvo que sea inevitable.** "Salvo que sea inevitable" no es una puerta de escape para abstraer por costumbre: antes de introducir un patrón, una capa de indirección o una configuración genérica, hay que poder decir qué problema concreto resuelve ahora.

## Diseñar antes de implementar

Skill: `disenar-antes-de-implementar`. **El humano aprueba la intención antes de que el agente implemente.** La ceremonia escala con el tamaño de la tarea (sondeo, acotado o arquitectónico); la compuerta de aprobación, nunca. Ante la duda entre dos caminos, se toma el más pesado.

## Planificar por fases

Skill: `planificacion-por-fases`. Con un diseño aprobado y una tarea de varios pasos, se escribe un plan antes de tocar código: qué archivos toca cada tarea, cómo se prueba, y cada paso lo bastante chico como para tener su propio ciclo de test.

## TDD estricto y test quirúrgico

Skill: `tdd-workflow`.

- **Rojo antes que verde.** Se escribe el test, se confirma que falla, se escribe la implementación mínima, se confirma que pasa. Código escrito antes que su test no cuenta como TDD.
- **Alcance quirúrgico.** Después de un cambio se corre *solo* el test directamente relacionado. Ampliar a un módulo o a la suite completa requiere preguntar primero — nunca es una escalada automática.

## Depuración sistemática

Skill: `depuracion-sistematica`. **Causa raíz antes que fix.** Cuatro fases obligatorias — investigación, análisis de patrón, hipótesis, implementación — sin saltarse ninguna, sobre todo cuando el arreglo rápido parece obvio. Un fix al síntoma es una falla de depuración.

## Modo secuencial

Skill: `sequential-mode`. Una tarea a la vez, **cero subagentes por defecto**. Paralelizar solo es posible si el agente lo propone, describe qué dividiría y por qué, y el humano lo aprueba *para esa tarea puntual*. La aprobación no se extiende a tareas futuras.

## Spec-Driven Development (SDD)

Skill: `spec-driven-development`. `SPEC.md` y `spec/` son la fuente de verdad del proyecto: se lee primero en cada sesión y se mantiene corto. Un principio propio de esta metodología: **`SPEC.md` se reemplaza, no se acumula** — tope de 1000 líneas (configurable), revisado al leerlo y antes de cada commit; narrativa a `brain/sesiones.md`, ítems cerrados a `spec/cerrados.md` con ID + fecha + evidencia. Ver [spec.md](spec.md) y ADR-006.

## Documentar en momentos definidos

Skill: `documentation-convention`. Los commits de código son continuos; el registro en `brain/` y `SPEC.md` se difiere a un **`ward`** (lo pide el humano; guarda sin push) o al **cierre de sesión con `keepit`** (obligatorio; verifica, revisa pendientes y hace push). El agente no decide por su cuenta que algo "amerita" registrarse. Ver [workflow.md](workflow.md).

## Integración

El agente se adapta al proyecto, no al revés. Los cambios estructurales solo se proponen cuando hay una necesidad real y el desarrollador decide implementarlos. Ver [philosophy.md](philosophy.md#principio-de-integración).
