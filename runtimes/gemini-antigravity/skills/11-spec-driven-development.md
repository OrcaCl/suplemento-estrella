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
| Próximo paso: [PRIMER_ITEM_PENDIENTE]

Si el proyecto tiene tests, se agrega el segmento `[N] tests |` antes de `Próximo paso`; si no los tiene, se omite.

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
1. `SPEC.md` → Reemplazar, no acumular (ver sección 3b): sacar de la §3 los ítems cerrados, sobrescribir la fila "Última sesión" de la §2 y el footer.
2. `spec/completado.md` → Agregar el checkbox marcado (1 línea, con fecha).
3. `spec/historial.md` (o `brain/sesiones.md` si el proyecto usa Brain KMS) → Registrar el contexto narrativo.
4. Si la solución involucra un cambio de arquitectura o regla de proceso, proponer el correspondiente registro `ADR` o `INT`.

---

## 🧭 3b. Árbitro de Destino, Reemplazar y Tope de Tamaño

`SPEC.md` es un panel de control, no una bitácora. Un proyecto real pasó de 5 KB a 126 KB en dos meses porque cada checkpoint agregaba un bloque nuevo sin borrar el anterior.

**Árbitro de destino — qué NUNCA va en `SPEC.md`:**

| Qué | Dónde | Qué queda en `SPEC.md` |
|---|---|---|
| Narrativa de la sesión, hallazgos, el "por qué" | `brain/sesiones.md` (o `spec/historial.md` en modo simple) | Nada — ni en el header, ni en el footer, ni en una fila |
| Ítem terminado (`[x]`) | `spec/completado.md` (1 línea, con fecha) | Nada — sale de la §3 |
| Detalle técnico de un componente | `spec/features.md` | 1 fila por componente en la §7 |
| Schema de API o hallazgo de integración | `spec/api.md` | Solo el puntero |
| Decisión de arquitectura, proceso o riesgo | `brain/ADR\|INT\|NOC-*.md` + `brain/index.md` | Solo el puntero, en la §5 |

**Reemplazar, no acumular:**
- "Última actualización" (header) = solo la fecha.
- "Última sesión" (§2) = 1 fila de ≤ ~400 caracteres que **sobrescribe** la anterior. Prohibidas las filas "Sesión anterior" y los bloques "Antes (fecha) — …".
- La §3 contiene solo pendientes `[ ]`.
- Footer ≤ ~300 caracteres: versión + fecha + métricas clave del dominio (conteo de tests solo si el proyecto tiene tests).

**Tope de tamaño — chequeo obligatorio antes del commit** (checkpoint, cierre de sesión o registro inmediato): `SPEC.md` ≤ ~15 KB y ninguna línea > 600 caracteres.

```
wc -c SPEC.md
awk 'length>600{print NR}' SPEC.md
```

Si excede, condensar y mover el contenido a su destino según la tabla **antes** de commitear.

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

