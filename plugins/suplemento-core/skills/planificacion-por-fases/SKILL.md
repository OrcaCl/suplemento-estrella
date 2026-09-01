---
name: planificacion-por-fases
description: Disciplina de escribir un plan de implementación detallado y por fases ANTES de tocar código, para cualquier tarea de varios pasos. El plan documenta qué archivos toca cada tarea, el código, cómo se prueba, y deja cada tarea como una unidad chica con su propio ciclo de test. Úsala cuando ya hay un diseño o spec aprobado (viene de disenar-antes-de-implementar) y la tarea tiene varios pasos o toca varios archivos — antes de empezar a implementar.
---

# Planificación por fases

Escribir un plan de implementación asumiendo que quien lo ejecuta no tiene contexto del codebase. Documentar todo lo que necesita saber: qué archivos tocar en cada tarea, el código, el testing, qué docs revisar, cómo probarlo. Entregar el plan como tareas del tamaño de un bocado. DRY, YAGNI, TDD, commits frecuentes.

Esta skill viene **después** de `disenar-antes-de-implementar` (camino arquitectónico) — el diseño ya está aprobado y registrado. El plan **argumenta desde el spec**: el spec viaja con el plan, quien ejecuta lee los dos.

**Anunciar al empezar:** "Estoy usando `planificacion-por-fases` para crear el plan de implementación."

**Dónde guardar el plan:** proyecto simple → `spec/planes/YYYY-MM-DD-<nombre>.md`; proyecto con `brain/` → `brain/planes/YYYY-MM-DD-<nombre>.md`. Las preferencias del proyecto ganan sobre este default.

## Chequeo de alcance

Si el spec cubre varios subsistemas independientes, debió descomponerse en sub-proyectos durante el diseño. Si no pasó, sugerir separarlo en varios planes — uno por subsistema. Cada plan debe producir software funcional y testeable por sí solo.

## Estructura de archivos, antes de definir tareas

Antes de definir tareas, mapear qué archivos se crean o modifican y de qué es responsable cada uno. Acá se fijan las decisiones de descomposición.

- Diseñar unidades con límites claros e interfaces bien definidas. Cada archivo con una responsabilidad clara.
- Code razona mejor sobre código que cabe en contexto de una vez, y sus ediciones son más confiables con archivos enfocados. Preferir archivos chicos y enfocados sobre archivos grandes que hacen demasiado.
- Los archivos que cambian juntos viven juntos. Dividir por responsabilidad, no por capa técnica.
- En codebases existentes, seguir los patrones establecidos. Si el codebase usa archivos grandes, no reestructurar unilateralmente — pero si un archivo que se está modificando creció demasiado, incluir una división en el plan es razonable.

## Tamaño correcto de una tarea

Una tarea es la unidad más chica que **lleva su propio ciclo de test** y vale la revisión de alguien con ojos frescos. Al trazar los límites: plegar setup, configuración, andamiaje y documentación dentro de la tarea cuyo entregable los necesita; dividir solo donde alguien podría razonablemente rechazar una tarea y aprobar la de al lado. Cada tarea termina con un entregable testeable de forma independiente.

## Granularidad de los pasos — del tamaño de un bocado

**Cada paso es una acción (2-5 minutos):**
- "Escribir el test que falla" — un paso
- "Correrlo para confirmar que falla" — un paso
- "Escribir la implementación mínima que hace pasar el test" — un paso
- "Correr los tests y confirmar que pasan" — un paso
- "Commit" — un paso

Esto es `tdd-workflow` desglosado paso a paso. El alcance de ejecución sigue siendo quirúrgico: cada paso de test corre solo el archivo de test de esa tarea.

## Encabezado del documento de plan

**Todo plan empieza con este encabezado:**

```markdown
# Plan de implementación — [Nombre de la feature]

**Objetivo:** [una frase de qué construye esto]

**Arquitectura:** [2-3 frases del enfoque]

**Stack:** [tecnologías/librerías clave]

**Spec:** [ruta al spec/diseño que este plan implementa]

## Restricciones globales

[Los requisitos del spec que aplican a todo el proyecto — versiones mínimas,
límites de dependencias, reglas de nombres, requisitos de plataforma — una
línea cada uno, con los valores exactos copiados del spec. Los requisitos de
cada tarea incluyen implícitamente esta sección.]

---
```

## Estructura de una tarea

````markdown
### Tarea N: [Nombre del componente]

**Archivos:**
- Crear: `ruta/exacta/al/archivo.py`
- Modificar: `ruta/exacta/al/existente.py:123-145`
- Test: `tests/ruta/exacta/al/test.py`

**Interfaces:**
- Consume: [qué usa esta tarea de tareas anteriores — firmas exactas]
- Produce: [de qué dependen las tareas siguientes — nombres de función
  exactos, tipos de parámetros y de retorno]

- [ ] **Paso 1: Escribir el test que falla**

```python
def test_comportamiento_especifico():
    resultado = funcion(entrada)
    assert resultado == esperado
```

- [ ] **Paso 2: Correr el test y confirmar que falla**

Correr: `pytest tests/ruta/test.py::test_nombre -v`
Esperado: FALLA con "funcion not defined"

- [ ] **Paso 3: Escribir la implementación mínima**

```python
def funcion(entrada):
    return esperado
```

- [ ] **Paso 4: Correr el test y confirmar que pasa**

Correr: `pytest tests/ruta/test.py::test_nombre -v`
Esperado: PASA

- [ ] **Paso 5: Commit**

```bash
git add tests/ruta/test.py src/ruta/archivo.py
git commit -m "feat: agrega comportamiento especifico"
```
````

## Nada de placeholders

Cada paso contiene el contenido real que se necesita. Estos son **fallas del plan** — nunca escribirlos:

- "TBD", "TODO", "implementar después", "completar detalles"
- "Agregar el manejo de errores apropiado" / "agregar validación" / "manejar edge cases"
- "Escribir tests para lo de arriba" (sin el código de test real)
- "Similar a la Tarea N" (repetir el código — quien ejecuta puede leer las tareas fuera de orden)
- Pasos que describen qué hacer sin mostrar cómo (los pasos de código llevan bloque de código)
- Referencias a tipos, funciones o métodos que no están definidos en ninguna tarea

## Auto-revisión

Después de escribir el plan completo, mirar el spec con ojos frescos y chequear el plan contra él. Es un checklist que corre Code, no un subagente.

1. **Cobertura del spec:** recorrer cada sección/requisito del spec. ¿Se puede apuntar a una tarea que lo implementa? Listar los huecos.
2. **Escaneo de placeholders:** buscar en el plan los patrones de la sección "Nada de placeholders". Arreglarlos.
3. **Consistencia de tipos:** ¿los tipos, firmas de métodos y nombres de propiedades usados en tareas posteriores coinciden con lo definido en tareas anteriores? Una función llamada `clearLayers()` en la Tarea 3 pero `clearFullLayers()` en la Tarea 7 es un bug.

Si hay problemas, arreglarlos inline. Si hay un requisito del spec sin tarea, agregar la tarea.

## Ejecución del plan

**Por defecto en Suplemento Estrella: ejecución secuencial en esta misma sesión**, tarea por tarea, con checkpoint para revisión del humano entre tareas (ver `sequential-mode`). Code no propone por su cuenta descomponer la ejecución en subagentes paralelos.

Si Code considera que el paralelismo con subagentes aportaría tiempo real y las tareas son genuinamente independientes, **la acción correcta es preguntarle al humano** — nunca es una escalada automática. Ver `sequential-mode` para el criterio exacto: incluye el momento en que un plugin de flujo de trabajo (como Superpowers) presenta su menú de "Execution Handoff" recomendando subagentes.

## Relación con otras skills

- **`disenar-antes-de-implementar`** — el paso previo. El plan no se escribe sin un diseño aprobado.
- **`spec-driven-development`** — define dónde vive el spec del que el plan argumenta, y dónde se registra el avance a medida que se completan tareas.
- **`tdd-workflow`** — cada tarea del plan es un ciclo rojo-verde. La granularidad de pasos de esta skill es ese ciclo desglosado.
- **`sequential-mode`** — gobierna cómo se ejecuta el plan (secuencial por defecto, subagentes solo con aprobación puntual del humano).
- **`code-simplicity`** — DRY y YAGNI aplicados a la descomposición en tareas.

## Nota sobre plugins de flujo de trabajo

Si el proyecto tiene instalada una skill de "writing-plans" de un plugin genérico (por ejemplo Superpowers), esta skill la reemplaza. Las diferencias propias: (1) las rutas de guardado respetan la estructura del proyecto (`spec/` o `brain/`) en vez de una ruta fija tipo `docs/plans/`; (2) el "Execution Handoff" no ofrece subagentes como opción recomendada por defecto — la ejecución es secuencial salvo que el humano apruebe lo contrario, caso por caso.
