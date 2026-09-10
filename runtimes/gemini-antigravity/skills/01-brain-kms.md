# SKILL: Brain KMS Governance, Structuring & Record Management (brain-adr)

## Propósito y Disparadores
Esta directiva gobierna el uso diario del sistema `brain/` (Brain KMS). Aplícala cuando:
- Se tome una decisión técnica o de negocio (`ADR`).
- Se acuerde una convención o cambio de proceso en la relación de trabajo entre el Humano y Gemini (`INT`).
- Se detecte un hallazgo de riesgo o cuidado mixto a monitorear (`NOC`).
- Se retire/depreque una herramienta, patrón o plugin (`DEP`).
- Se agregue material de referencia propio (`REF`) o descubierto en otro proyecto (`REFX`).
- Se reporte un bug o propuesta de feature para un sistema externo (`trackers/`).
- Se realice un cierre de sesión o checkpoint.

---

## 1. Ubicación de Plantillas Base (Referencias Estáticas)

Cuando Gemini deba crear o proponer un nuevo registro dentro de `brain/`, **debe leer obligatoriamente la plantilla correspondiente desde `runtimes/gemini-antigravity/skills/references/`** antes de escribir el archivo final:

| Tipo de Registro | Plantilla Base en `skills/references/` | Destino en el Proyecto |
|---|---|---|
| **`ADR`** | `references/adr-template.md` | `brain/ADR-NNN-{slug}.md` |
| **`INT`** | `references/int-template.md` | `brain/INT-NNN-{slug}.md` |
| **`NOC`** | `references/noc-template.md` | `brain/NOC-NNN-{slug}.md` |
| **`DEP`** | `references/dep-template.md` | `brain/DEP-NNN-{slug}.md` |
| **`REF`** | `references/ref-template.md` | `brain/REF-NNN-{slug}.md` |
| **`REFX`**| `references/refx-template.md`| `brain/REFX-NNN-{slug}.md` |

---

## 2. Las Seis Categorías de Registro (Tabla de Decisión)

| Prefijo | Nombre | Qué documenta | Tono / Formato |
|---|---|---|---|
| **`ADR-NNN`** | Architecture Decision Record | Decisión que afecta **lo que el sistema hace o cómo se comporta** (tecnología, patrón, convención que impacta el producto). | Formal: Contexto, Decisión, Razones, Consecuencias, Commit. |
| **`INT-NNN`** | Interno | Decisión que afecta **solo cómo el humano y Gemini trabajan juntos** (proceso, herramientas, comunicación). Nunca el comportamiento del producto. | Mismo formato que ADR, enfocado en la relación/proceso de trabajo. |
| **`NOC-NNN`** | Nota de Cuidado | Hallazgo de **riesgo o cuidado mixto** (arquitectura + seguridad) que no es una alarma formal ni decisión. Se monitorea. | Neutro, menos formal. Describe la preocupación a monitorear. |
| **`DEP-NNN`** | Retiro (Deprecation) | Retiro de una herramienta, archivo, patrón o plugin de desarrollo. Documenta un **cierre**. | Breve: Qué se retira, por qué, qué lo reemplaza. |
| **`REF-NNN`** | Referencia | Material de observación o contexto de dominio propio del proyecto (hallazgos, investigación). | Descriptivo, sin estructura de decisión. |
| **`REFX-NNN`** | Referencia Cruzada | Material descubierto **en otro proyecto** traído manualmente por el humano. Gemini **nunca** navega al proyecto origen por su cuenta. | Descriptivo, citando explícitamente la procedencia original. |

> **Criterio de corte ADR vs. INT vs. Sesiones:**
> - Si cambia lo que el sistema hace o cómo se comporta desde afuera $\rightarrow$ `ADR`.
> - Si afecta el proceso de trabajo o la relación con Gemini $\rightarrow$ `INT`.
> - Si es una decisión/enfoque costoso de revertir o limitación descubierta $\rightarrow$ `ADR`.
> - Si se completó una tarea siguiendo un patrón ya establecido o es un bug fix sin cambio de diseño $\rightarrow$ **Solo `sesiones.md`**.

---

## 3. Reglas de Numeración, Estado e Inmutabilidad

1. **Numeración Independiente:** Cada prefijo (`ADR`, `INT`, `NOC`, etc.) lleva su propia secuencia secuencial. Un número asignado **nunca se reutiliza** aunque el registro pase a estar obsoleto.
2. **Excepción `000`:** Asignar `000` únicamente si el registro es *conceptualmente anterior* a uno ya existente (ej. `INT-000` previo a `INT-001`). Usar con moderación.
3. **Inmutabilidad de Decisiones:** Un `ADR` o `INT` **NUNCA** se edita para cambiar la decisión original. Si la decisión cambia, se crea uno nuevo y el anterior se marca como `Obsoleto — reemplazado por ADR-XXX` (o `INT-XXX`).
4. **Mutabilidad de `NOC`:** Un `NOC` puede actualizarse in situ agregando secciones de seguimiento con fecha.
5. **Sección `## Commit`:** Todo `ADR` e `INT` debe finalizar con la sección `## Commit` apuntando al commit/checkpoint en `brain/sesiones.md`. Si aún no existe el commit, marcar como *"Pendiente al próximo checkpoint/cierre"*.

---

## 4. Reglas de Mantenimiento de Archivos `brain/`

### A. `brain/index.md` (Índice Consolidado)
**Regla No Negociable:** Este archivo contiene ÚNICAMENTE la tabla de registros, el puntero a `sesiones.md` y la referencia a `files/`. Prohibido pegar resúmenes de sesión o "estado actual del proyecto" aquí.

# Brain — Índice de decisiones y contexto acumulado

Este directorio complementa el `SPEC.md`. Documenta el **por qué** de las decisiones técnicas (ADRs) y el historial de sesiones de trabajo.

---

## Decisiones de arquitectura y registros (ADR / INT / NOC / DEP / REF / REFX)

| ID | Tipo | Título | Estado |
|---|---|---|---|
| [ADR-001](ADR-001-slug.md) | ADR | Título de la decisión | Vigente |

---

## Registro de sesiones

Ver [sesiones.md](sesiones.md) para el historial completo con hitos y descubrimientos.

---

## Documentos de referencia externos

Ver carpeta [files/](files/) para documentos de reuniones y referencias externas.





### B. brain/sesiones.md (Registro Cronológico)

Registro cronológico por entrada de sesión. Las entradas más recientes van arriba. Este es el único lugar para el detalle diario de "qué se hizo".

# Registro de sesiones

Hitos relevantes por sesión de trabajo. Las entradas más recientes van arriba.

---

## Sesión — {{AAAA-MM-DD}} — {{título breve}}

**Contexto:** {{1 línea de qué se pidió trabajar esta sesión}}

- **{{hito 1}}:** {{detalle}}
- **{{hito 2}}:** {{detalle}}

### Archivos modificados
- {{ruta}}

### Próximo
- {{siguiente paso}}

---

### C. brain/TOASK.md (Post-it Digital)

Categorías de audiencia: A = humano/administrador del proyecto · D = desarrollador/proveedor externo · S = investigable internamente por el agente.

# Preguntas pendientes (TOASK)

Categorías: **A** = humano :) /administrador del proyecto · **D** = desarrollador/proveedor externo · **S** = investigable internamente por el agente

## Pendientes

- [ ] **{{categoría}}** — {{pregunta o idea, fecha}}

## Resueltas

- [x] ~~{{pregunta}}~~ → {{respuesta encontrada}}


### 5. Trackers (brain/trackers/)

    Para reportes de fallas o propuestas de features hacia herramientas o sistemas externos, se deben usar las plantillas de brain/trackers/.

    Instancias creadas: Las instancias generadas de bugs/features se guardan obligatoriamente en brain/trackers/generated/.


### 6. Procedimiento al Cierre de Sesión o Checkpoint

Al ejecutar un checkpoint o cierre de sesión, Gemini debe proponer la actualización sincronizada en este orden exacto:

- brain/sesiones.md $\rightarrow$ Crear la nueva entrada en la parte superior con hitos, archivos modificados y próximo paso.

- El/los registro(s) correspondiente(s) (ADR, INT, NOC, DEP, REF, REFX) si aplican, consultando su respectiva plantilla en skills/references/.

- brain/index.md $\rightarrow$ Agregar la fila a la tabla consolidada por cada registro nuevo.

- SPEC.md $\rightarrow$ Actualizar el footer y la lista de pendientes.

- Completa la sección ## Commit de cualquier ADR/INT creado en la sesión con la referencia real del commit/checkpoint.