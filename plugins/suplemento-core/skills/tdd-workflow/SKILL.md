---
name: tdd-workflow
description: Disciplina de TDD estricto (red-green) con ejecución de tests QUIRÚRGICA por defecto — solo el test directamente relacionado al cambio actual. Correr una suite más amplia (módulo completo, o la suite entera) requiere preguntar al humano primero, nunca es una escalada automática de Code. Úsala siempre que se vaya a implementar una feature o corregir un bug, antes de escribir cualquier código de implementación, o al decidir qué comando de test correr después de un cambio.
---

# TDD Workflow

TDD estricto (tests primero) combinado con una regla de alcance de test que cambió de "niveles que se recorren en orden" a "quirúrgico por defecto, ampliar solo con permiso". El cambio se hizo tras observar que, en la práctica, escalar automáticamente a suites más amplias consumía tiempo y tokens sin que el humano lo hubiera pedido.

## TDD estricto — red antes que green (sin cambios respecto a la versión anterior)

Para cualquier feature o bugfix, el orden es siempre:

1. **Escribir el test primero**, que exprese el comportamiento esperado.
2. **Correrlo y confirmar que falla** (rojo) — no es opcional. Confirmar el rojo es lo que garantiza que el test realmente prueba algo.
3. **Escribir la implementación mínima** que hace pasar el test.
4. **Confirmar verde.**
5. Si hace falta, refactorizar con los tests en verde como red de seguridad.

**Regla no negociable:** código de implementación escrito antes que su test correspondiente no cuenta como TDD, aunque el test se agregue inmediatamente después.

## Alcance de ejecución — quirúrgico por defecto

**Regla nueva, reemplaza la estrategia de niveles anterior:** después de cualquier cambio, correr **únicamente** el archivo de test directamente relacionado al cambio actual — no el módulo completo, no la suite.

```bash
{{comando}} tests/ruta/al/archivo_de_test_especifico.py -v
```

Este es el default siempre, sin excepción automática.

### Ampliar el alcance requiere preguntar primero

Si Code considera que valdría la pena correr algo más amplio (los tests del módulo completo, o la suite entera) porque el cambio podría tener efectos en otro lado, **la acción correcta es preguntarle al humano, no correrlo directamente**:

> "El cambio que acabo de hacer en `X` podría afectar a `Y` y `Z`. ¿Corro solo el test puntual que ya pasó, o prefieres que corra también los tests de esos módulos, o la suite completa?"

Code no decide por su cuenta escalar el alcance de los tests — ofrece la opción y espera la respuesta, igual que con subagentes en `sequential-mode`. Ambas reglas comparten el mismo principio: decisiones que consumen tiempo/tokens de forma no trivial pasan a control explícito del humano, no a criterio autónomo de Code.

### Cuándo sí correr la suite completa sin preguntar

Solo cuando el humano lo pide explícitamente, o como parte del checkpoint/cierre de sesión si el humano lo solicita en ese momento (ver `documentation-convention`) — nunca como paso automático "antes de un commit importante", que era el comportamiento de la estrategia de niveles anterior.

## Verificación antes de declarar trabajo completo

Nunca declarar una tarea como "lista", "arreglada", o "funcionando" sin haber corrido al menos el test quirúrgico correspondiente y haber visto el resultado real. Si algo impide correrlo, decirlo explícitamente en vez de reportar éxito sin haberlo verificado.

## Marcado de tests lentos

Sigue aplicando si el proyecto los usa: los tests que dependen de recursos externos o procesamiento pesado deben marcarse explícitamente (ej. `@pytest.mark.slow`), para que si el humano pide correr "todo excepto lo lento" sea una opción disponible.

## Relación con sequential-mode

Escribir el test, confirmar rojo, implementar, confirmar verde es un ciclo secuencial — no se escribe la implementación de dos features en paralelo saltándose la confirmación de rojo de cada una. Ver `sequential-mode` para el criterio de cuándo el paralelismo se aprueba (nunca por decisión autónoma de Code, siempre con confirmación explícita del humano, caso por caso).

## Nota sobre plugins de flujo de trabajo

Si el proyecto tiene instalado un plugin que fuerza TDD estricto como parte de su flujo (por ejemplo, una skill de "test-driven-development" de Superpowers), la disciplina rojo-verde de esta skill es compatible. La regla de **alcance quirúrgico por defecto** es la pieza específica de esta metodología que un plugin genérico de TDD probablemente no trae — y toma precedencia sobre cualquier comportamiento del plugin que intente correr suites más amplias sin preguntar.