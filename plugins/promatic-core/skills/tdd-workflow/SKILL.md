---
name: tdd-workflow
description: Disciplina de TDD estricto (red-green) combinada con estrategia de testing por niveles para no gastar tiempo/tokens corriendo la suite completa en cada cambio pequeño. Úsala siempre que se vaya a implementar una feature o corregir un bug, antes de escribir cualquier código de implementación, al decidir qué comando de test correr después de un cambio, o antes de declarar cualquier trabajo como completo o terminado.
---

# TDD Workflow

Dos piezas que trabajan juntas: disciplina estricta de tests-primero, y una estrategia de niveles para no pagar el costo de la suite completa en cada iteración pequeña.

## TDD estricto — red antes que green

Para cualquier feature o bugfix, el orden es siempre:

1. **Escribir el test primero**, que exprese el comportamiento esperado.
2. **Correrlo y confirmar que falla** (rojo) — esto no es opcional ni un paso que se pueda saltar "porque ya se sabe que va a fallar". Confirmar el rojo es lo que garantiza que el test realmente está probando algo, y no pasando por accidente (test mal escrito, fixture incorrecta, etc.).
3. **Escribir la implementación mínima** que hace pasar el test.
4. **Confirmar verde.**
5. Si hace falta, refactorizar con los tests en verde como red de seguridad.

**Regla no negociable:** código de implementación escrito antes que su test correspondiente no cuenta como TDD, aunque el test se agregue inmediatamente después "para completar". El valor del rojo confirmado se pierde si se escribe en ese orden — no hay forma de saber retroactivamente si el test habría fallado correctamente.

## Verificación antes de declarar trabajo completo

Nunca declarar una tarea como "lista", "arreglada", o "funcionando" sin haber corrido los tests correspondientes y haber visto el resultado real — no inferirlo, no asumirlo por la lógica del código. Si algo impide correr los tests (falta de tiempo, entorno no disponible), decirlo explícitamente en vez de reportar éxito sin haberlo verificado.

## Estrategia de testing por niveles

Correr la suite completa después de cada cambio pequeño es caro en tiempo y, si el proyecto usa tests marcados como lentos (OCR, llamadas a servicios externos simulados, etc.), también caro en algo más que tiempo de espera. La estrategia de niveles evita ese costo sin sacrificar cobertura antes de un commit importante.

### Nivel 1 — Tests del módulo afectado (correr siempre primero)

Después de cualquier cambio, correr solo los tests del módulo o carpeta directamente afectada.

```bash
{{comando}} tests/<módulo_afectado>/ -v
```

Este es el ciclo de feedback rápido durante el desarrollo activo de una feature — se corre muchas veces por sesión.

### Nivel 2 — Suite rápida sin tests lentos

Una vez que el Nivel 1 pasa, correr la suite completa excluyendo los tests marcados como lentos.

```bash
{{comando}} tests/ -m "not slow" -v
```

Correr esto antes de considerar una tarea terminada, para confirmar que el cambio no rompió nada en otro módulo.

### Nivel 3 — Suite completa, incluyendo tests lentos

Solo antes de commits importantes, o al cambiar modelos de datos / migraciones — situaciones donde un efecto secundario no obvio en otro módulo es más probable.

```bash
{{comando}} tests/ -n {{N-1}} --durations=10
```

Si el framework de testing soporta paralelización, usar `N-1` hilos (dejar un núcleo libre) para no saturar la máquina de desarrollo.

**Regla de progresión:** no saltar a un nivel superior sin que el nivel inferior haya pasado primero. Correr la suite completa cuando el Nivel 1 todavía falla es ruido — va a fallar por la misma razón, solo que más lento y con más output que revisar.

## Marcado de tests lentos

Los tests que dependen de recursos externos, procesamiento pesado (OCR, renderizado), o cualquier operación que tome notablemente más tiempo que el resto de la suite, deben marcarse explícitamente (ej. `@pytest.mark.slow` o el equivalente del framework de testing del proyecto) para que el Nivel 2 pueda excluirlos automáticamente.

## Relación con sequential-mode

Escribir el test, confirmar rojo, implementar, confirmar verde es en sí mismo un ciclo secuencial — no se escribe la implementación de dos features en paralelo "para ahorrar tiempo" saltándose la confirmación de rojo de cada una por separado. Ver skill `sequential-mode` para el criterio general de cuándo el paralelismo sí se justifica.

## Nota sobre plugins de flujo de trabajo

Si el proyecto tiene instalado un plugin que ya fuerza TDD estricto como parte de su flujo (por ejemplo, una skill de "test-driven-development" que borra implementación escrita antes que su test), esta skill es compatible y no debería generar conflicto — ambas apuntan al mismo comportamiento. La estrategia de niveles (Nivel 1/2/3) es la pieza específica de esta metodología que un plugin genérico de TDD no necesariamente trae, y vale la pena mantenerla como capa adicional incluso si el plugin ya cubre la disciplina rojo-verde.