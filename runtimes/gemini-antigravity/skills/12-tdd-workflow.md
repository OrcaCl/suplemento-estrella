# SKILL: Strict TDD Workflow & Surgical Testing

## Propósito y Disparadores
Gobierna el ciclo de desarrollo orientado a pruebas (TDD) y la política de ejecución quirúrgica de tests.
Aplica cuando se esté:
- Creando una nueva funcionalidad, componente o refactorizando código existente.
- Corrigiendo un bug o comportamiento no deseado.
- Seleccionando qué comando de pruebas unitarias ejecutar tras una modificación.

---

## 1. El Ciclo Inviolable RED-GREEN-REFACTOR

Cualquier cambio de código debe seguir estrictamente este orden:

1. **Test Primero (RED):** Escribir la prueba unitaria que exprese el comportamiento requerido.
2. **Confirmar Falla (RED Assert):** Correr el test y verificar que falle por la razón esperada (función no definida, assert fallido). *Si no falla, el test no es válido.*
3. **Implementación Mínima (GREEN):** Escribir el código justo y necesario para hacer pasar la prueba.
4. **Confirmar Éxito (GREEN Assert):** Ejecutar la prueba quirúrgica y confirmar el pase limpio.
5. **Refactorización:** Limpiar el código conservando las pruebas en verde como red de seguridad.

> **Regla Innegociable:** Código de producción escrito antes que su correspondiente test NO se considera TDD, aun si el test se escribe inmediatamente después.

---

## 2. Alcance Quirúrgico por Defecto

Gemini ejecutará **ÚNICAMENTE** el archivo de prueba directamente asociado a la tarea activa:

```bash
# Ejemplo de ejecución quirúrgica dirigida
pytest tests/unit/test_calculo_impuestos.py -v
```

Protocolo para Ampliar el Alcance de Tests

Si Gemini considera necesario correr los tests de todo un módulo o la suite completa para evaluar impactos colaterales, DEBE consultar al humano antes de ejecutar:

    "El cambio en servicios/pagos.py podría impactar los módulos de facturación y notificaciones. ¿Ejecuto únicamente el test quirúrgico actual o prefieres correr los tests de esos módulos relacionados?"

## 3. Verificación Real Obligatoria

Prohibido reportar un requerimiento como "completado", "listo" o "resuelto" sin haber ejecutado la prueba quirúrgica y haber confirmado el resultado exitoso en consola. Si la ejecución no es posible, declarar la limitación explícitamente.