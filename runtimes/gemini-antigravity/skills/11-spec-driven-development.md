# SKILL: Spec-Driven Development (Daily SDD Workflow)

## Propósito y Disparadores
Gobierna el flujo diario de lectura y actualización sobre `SPEC.md` y la carpeta `spec/` como fuente única de verdad.
Aplica cuando:
- Se inicie una sesión de trabajo con el proyecto.
- Se complete un requerimiento, bugfix o refactorización.
- Se deba determinar en qué archivo guardar un tipo específico de información.
- Se detecte que la documentación en `SPEC.md` difiere del estado real del código.

---

## 🚀 1. Apertura Obligatoria de Sesión

Antes de ejecutar cualquier acción de desarrollo, Gemini debe leer `SPEC.md` y confirmar el contexto en consola con este formato exacto:

✅ Contexto cargado — SPEC.md v[VERSION]
| [N] tests | Próximo paso: [PRIMER_ITEM_PENDIENTE]

---

## 📝 2. Tabla de Enrutamiento de Documentación

| Si estás documentando... | Va en... |
|---|---|
| Estado actual resumido, pendientes activos, reglas no negociables | `SPEC.md` |
| Integración y consumo de APIs o sistemas externos | `spec/api.md` |
| Confirmación plana de tarea completada (`- [x] [Fecha] [Tarea]`) | `spec/completado.md` |
| Explicación corta y aprendizajes del hito alcanzado | `spec/historial.md` |
| Convenciones, diccionarios de datos o anexos (sin secretos) | `spec/datos.md` |
| Backlog vivo entre usuario y agente | `spec/objetivos.md` |
| Decisión de arquitectura o producto (solo en Brain KMS) | `brain/ADR-NNN.md` |
| Pregunta no urgente categorizada por audiencia (solo en Brain KMS) | `brain/TOASK.md` |

---

## 🔄 3. Registro de Avances y Breakthroughs

Al finalizar una tarea o checkpoint, actualizar de forma sincronizada:
1. `SPEC.md` → Marcar ítems completados `[x]`, actualizar el contador de pruebas unitarias y el footer.
2. `spec/completado.md` → Agregar el checkbox marcado.
3. `spec/historial.md` (o `brain/sesiones.md` si el proyecto usa Brain KMS) → Registrar el contexto narrativo.
4. Si la solución involucra un cambio de arquitectura o regla de proceso, proponer el correspondiente registro `ADR` o `INT`.

---

## 🔍 4. Manejo de Inconsistencias

Si Gemini detecta que el código real avanzó más allá de lo registrado en `SPEC.md`:
1. Confirmar con el humano el estado real del requerimiento.
2. Actualizar `SPEC.md` de inmediato para reflejar la realidad del sistema.
3. Registrar brevemente en el historial la corrección de documentación para conservar la trazabilidad.

---

## 📈 5. Criterio de Escalado a Brain KMS

Si un proyecto iniciado en modo simple presenta:
- Un archivo `spec/historial.md` demasiado extenso que consume excesivos tokens por sesión.
- Mas de 3 decisiones de arquitectura que requieren ser referenciadas individualmente.
- Integración con múltiples sistemas externos o trabajo colaborativo con otros desarrolladores.

Gemini debe proponer formalmente al humano la migración hacia la estructura completa con **Brain KMS** (`brain/`).

