---
name: code-simplicity
description: Principios de simplicidad de código para todo desarrollo dentro de proyectos PROMATIC — KISS, DRY y evitar sobreingeniería salvo que sea inevitable. Usar siempre que se esté diseñando una solución nueva, evaluando si abstraer código repetido, decidiendo entre una función directa y un patrón de diseño, o revisando si una implementación es más compleja de lo que el problema requiere. Aplica a Python, SQL, JavaScript, CSS y cualquier otro lenguaje del proyecto.
---

# Code Simplicity

Tres principios que gobiernan toda decisión de diseño de código en proyectos PROMATIC, en este orden de prioridad cuando entran en tensión entre sí.

## Los tres principios

### 1. KISS (Keep It Simple)

Preferir siempre la solución más simple que resuelva el problema tal como está planteado hoy, no como podría estar planteado en el futuro.

- Tres líneas directas son mejores que una abstracción prematura.
- Si una función hace lo que necesita en 5 líneas legibles, no la conviertas en una clase con métodos por "prolijidad".
- Preferir composición sobre herencia cuando ambas resuelven el problema igual de bien.

### 2. DRY (Don't Repeat Yourself) — con límite

Evitar duplicar lógica de negocio o reglas de validación. Pero DRY no es absoluto: **duplicar dos veces está bien, la tercera vez se evalúa abstraer.**

- No abstraigas después de la primera repetición — espera a ver el patrón real antes de generalizar.
- Una abstracción que solo tiene un caso de uso no es DRY, es sobreingeniería con otro nombre.

### 3. Evitar sobreingeniería — salvo que sea inevitable

La condición de excepción es la parte más importante de esta regla: **"salvo que sea inevitable" no es una puerta de escape para justificar abstraer por costumbre.** Antes de introducir un patrón de diseño, una capa de indirección, o una configuración genérica, confirmar que el problema concreto de hoy realmente lo necesita — no que podría necesitarlo en un escenario hipotético.

Preguntas para decidir si una abstracción es inevitable o prematura:
- ¿Existen hoy 2+ casos reales que la necesiten, o es 1 caso más una proyección a futuro?
- ¿El costo de NO abstraer ahora es mayor que el costo de refactorizar cuando aparezca el segundo caso real?
- ¿La complejidad que agrega es visible y explicable en una frase, o requiere documentación extensa para justificarse?

Si las respuestas apuntan a "no es necesario todavía", usar la solución directa.

## Relación con YAGNI (Superpowers)

Si el proyecto tiene el plugin Superpowers instalado, su skill `test-driven-development` incluye YAGNI (You Aren't Gonna Need It) como principio central. KISS/DRY/no-sobreingeniería de esta skill y YAGNI de Superpowers apuntan a la misma familia de disciplina — no son contradictorios, pero **conviene no duplicar la instrucción en dos lugares** del contexto del agente. Si ambos plugins están activos, esta skill puede referenciar YAGNI en vez de repetir la idea con otras palabras.

> Nota abierta (ver `TOASK.md` del proyecto): la relación exacta entre las skills de planning/ejecución de Superpowers y las de otros plugins de memoria (si están instalados) sigue sin resolverse formalmente. No asumir prioridad de una sobre otra sin que el usuario lo confirme para ese proyecto específico.

## Ejemplos de aplicación

**Sobreingeniería evitada (caso real):**
> Ante una regla de negocio con dos variantes conocidas, preferir un `if/else` directo con comentario explicando el porqué de cada rama, en vez de un patrón Strategy con clases separadas — a menos que ya existan 3+ variantes reales o se sepa con certeza que vienen más.

**DRY aplicado correctamente:**
> Una función de normalización usada en 3+ puntos distintos del código (ej. normalizar un identificador o un nombre antes de comparar entre fuentes) se extrae a un módulo compartido. Usarla en un solo lugar no justifica la extracción todavía.

**KISS aplicado correctamente:**
> Preferir una consulta directa con 2-3 líneas de SQL/ORM sobre construir una capa de query-builder genérica para un caso de uso único.
