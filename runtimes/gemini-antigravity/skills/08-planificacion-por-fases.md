# SKILL: Planificación por Fases (Implementation Planning)

## Propósito y Disparadores
Escribir un plan de implementación detallado y por fases **ANTES** de tocar código.
Aplica cuando:
- Exista un diseño o spec aprobado (proveniente de `disenar-antes-de-implementar`).
- La tarea involucra varios pasos, archivos o componentes.
- *Ubicación de guardado:* `brain/planes/YYYY-MM-DD-<nombre>.md` (en proyectos Brain KMS) o `spec/planes/YYYY-MM-DD-<nombre>.md` (en proyectos simples).

---

## 📢 Anuncio de Inicio
Al activar esta skill, Gemini debe declarar en consola:
> *"Estoy usando `planificacion-por-fases` para crear el plan de implementación."*

---

## 📐 Estructura y Granularidad de las Tareas

Cada tarea debe ser la unidad más pequeña que **lleva su propio ciclo TDD independiente** (2 a 5 minutos por paso).

### Estructura de Encabezado del Plan
```markdown
# Plan de implementación — [Nombre de la feature]

**Objetivo:** [Una frase del entregable final]
**Arquitectura:** [2-3 frases del enfoque técnico]
**Stack:** [Librerías/Tecnologías involucradas]
**Spec Original:** [Ruta al documento spec/ADR de origen]

## Restricciones globales
- [Requisito exacto copiado del spec]

## Estructura Atómica de Cada Tarea

### Tarea N: [Nombre del componente]

**Archivos:**
- Crear: `ruta/exacta/al/archivo.py`
- Modificar: `ruta/exacta/al/existente.py:123-145`
- Test: `tests/ruta/exacta/al/test.py`

**Interfaces:**
- Consume: [Firmas exactas consumidas de tareas previas]
- Produce: [Nombres de función, tipos de parámetros y retornos creados]

- [ ] **Paso 1: Escribir el test que falla (RED)**
```python
def test_comportamiento_especifico():
    resultado = funcion(entrada)
    assert resultado == esperado
```

- [ ] **Paso 2: Correr el test y confirmar que falla**
Correr: `pytest tests/ruta/test.py::test_nombre -v`
Esperado: FALLA con "function not defined" o similar.

- [ ] **Paso 3: Escribir la implementación mínima (GREEN)**
```python
def funcion(entrada):
    return esperado
```

- [ ] **Paso 4: Correr el test y confirmar que pasa**
Correr: `pytest tests/ruta/test.py::test_nombre -v`
Esperado: PASA

- [ ] **Paso 5: Commit local de la tarea**
```bash
git add tests/ruta/test.py src/ruta/archivo.py
git commit -m "feat([modulo]): agrega comportamiento especifico"
```

## Regla Estricta: Cero Placeholders

Son considerados fallas graves del plan las siguientes omisiones:

  - Comentarios tipo "TBD", "TODO", "completar después".

  - Indicaciones ambiguas como "Agregar validación de errores" sin mostrar el bloque de código exacto.

  - Instancias como "Escribir tests para lo anterior" sin incluir las funciones test_*.

  - Referencias vagas como "Similar a la Tarea 2". Cada tarea se redacta de forma independiente.

## Checklist de Auto-Revisión (Antes de entregar)

Antes de solicitar la aprobación del humano, Gemini debe auditar el plan contra el spec:

  - Cobertura 1:1: Cada requisito del spec está asignado a al menos una tarea.

  - Sin Placeholders: Escaneo de código vago o incompleto.

  - Consistencia de Tipos: Nombres de funciones, variables y parámetros coinciden exactamente a lo largo de todas las tareas.

## Ejecución

  - Secuencial por Defecto: Las tareas se ejecutan una a una dentro de la misma sesión, realizando checkpoints intermedios según la convención de documentación.

