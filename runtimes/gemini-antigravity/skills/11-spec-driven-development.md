# SKILL: Spec-Driven Development (Daily SDD Workflow)

## Propósito y Disparadores
Gobierna el flujo diario de lectura y actualización sobre `SPEC.md` y la carpeta `spec/` como fuente única de verdad.
Aplica cuando:
- Se inicie una sesión de trabajo con el proyecto.
- Se complete un requerimiento, bugfix o refactorización.
- Se deba determinar en qué archivo guardar un tipo específico de información.
- Se detecte que la documentación en `SPEC.md` difiere del estado real del código.

---

## ⚙️ 0. Configuración del Proyecto

Los proyectos ajustan esta skill con líneas `clave: valor` en su `GEMINI.md` (o `CLAUDE.md` si fue adoptado de Claude Code). Sin la línea, rige el defecto.

| Clave | Por defecto | Qué controla |
|---|---|---|
| `registro` | `diferido` | `diferido` = se registra en `ward`/`keepit`; `inmediato` = tras cada breakthrough (el cierre `keepit` sigue siendo obligatorio) |
| `spec_tope_lineas` | `1000` | Tope de líneas de `SPEC.md`. Al superarlo hay que condensar; al llegar al 80 % se avisa |
| `sesiones_anteriores_en_spec` | `0` | Cuántas filas "Sesión anterior" (≤ 2 líneas, ≤ 600 caracteres) se conservan en la §2 |

Un tope irreal se ignora: si no calza con el proyecto, se **ajusta** la clave — no se deja crecer el archivo sin límite.

---

## 🚀 1. Apertura Obligatoria de Sesión

Antes de ejecutar cualquier acción de desarrollo, Gemini debe leer `SPEC.md` y confirmar el contexto en consola con este formato exacto:

✅ Contexto cargado — SPEC.md v[VERSION]
| Próximo paso: [PRIMER_ITEM_PENDIENTE]

Si el proyecto tiene tests, se agrega el segmento `[N] tests |` antes de `Próximo paso`; si no los tiene, se omite.

**Control de tamaño al leer:** la lectura informa cuántas líneas tiene `SPEC.md`. Si supera `spec_tope_lineas` (1000 por defecto), avisar al humano antes de seguir y proponer condensarlo (ver `references/spec-migracion-0.12.md`); si está al 80 % o más, mencionarlo. Es el único control de tamaño: no hay script.

---

## 📝 2. Tabla de Enrutamiento de Documentación

| Si estás documentando... | Va en... |
|---|---|
| Estado actual resumido, pendientes activos, reglas no negociables | `SPEC.md` |
| Integración y consumo de APIs o sistemas externos | `spec/api.md` |
| Ítem cerrado (ID original + fecha + evidencia) | `spec/cerrados.md` |
| Explicación corta y aprendizajes del hito alcanzado | `brain/sesiones.md` |
| Convenciones, diccionarios de datos o anexos (sin secretos) | `spec/datos.md` |
| Backlog vivo entre usuario y agente | `spec/objetivos.md` |
| Decisión de arquitectura o producto | `brain/ADR-NNN.md` |
| Pregunta no urgente categorizada por audiencia | `TOASK.md` (raíz del proyecto) |

---

## 🔄 3. Registro de Avances y Breakthroughs

Qué se actualiza en cada registro (igual en ambos modos):
1. `SPEC.md` → Reemplazar, no acumular (ver sección 3b): sacar de la §3 los ítems cerrados (regla de cierre abajo), sobrescribir la fila "Última sesión" de la §2 y el footer.
2. `spec/cerrados.md` → Insertar la entrada del ítem cerrado.
3. `brain/sesiones.md` → Registrar el contexto narrativo.
4. Si la solución involucra un cambio de arquitectura o regla de proceso, proponer el correspondiente registro `ADR` o `INT`.

**Cuándo:** con `registro: diferido` (defecto) solo al ejecutar `ward` o `keepit` (ver `06-documentation-convention.md`); con `registro: inmediato`, tras cada breakthrough. No mezclar: la regla "no esperar al cierre" solo aplica si el proyecto declaró `inmediato`.

### Regla de cierre de un ítem
Son tres movimientos, siempre juntos:
1. **Borrar su fila de la §3** (no dejarla marcada `[x]` — un cerrado en §3 es un ítem "fantasma").
2. **Pegarla en `spec/cerrados.md`**, con el **mismo ID que traía en la lista de pendientes** (nunca uno nuevo): `**ID — ✅ CERRADO (fecha)[, motivo].** Título. 1–2 frases de qué se hizo o por qué se descartó + evidencia medible.` **Se inserta en su posición por ID ascendente, no al final:** el archivo se ordena por ID, no por orden de llegada.
3. **Agregar el ID a la lista "Cerrados"** de la §3.

**Evidencia obligatoria y verificable:** cerrar por "ya estaba hecho" exige una consulta con su resultado, un test que pasa o un commit — "se implementó" no basta. `spec/completado.md` (0.11 o anterior) queda **deprecado**: se marca con un aviso apuntando a `spec/cerrados.md` y no se borra (ver `references/spec-migracion-0.12.md`).

### Lista única de pendientes
**La §3 es el único lugar donde existen ítems abiertos.** Prohibidas fuera de ella: secciones "Próxima sesión", "Prioridad N", "Pendientes de X" y checkboxes `- [ ]`. La §3 puede ordenarse por prioridad (Alta / Media / Baja / Externo), una línea de contexto por ítem. Los planes de sesiones pasadas van al archivo histórico. Todo ítem de la §3 lleva ID (la plantilla ya los trae). **Los IDs son estables y no se reutilizan**; los ítems nuevos siguen la numeración.

---

## 🧭 3b. Árbitro de Destino, Reemplazar y Tope de Tamaño

`SPEC.md` es un panel de control, no una bitácora. Un proyecto real pasó de 5 KB a 134 KB en cuatro meses porque cada checkpoint agregaba un bloque nuevo sin borrar el anterior.

**Árbitro de destino — qué NUNCA va en `SPEC.md`:**

| Qué | Dónde | Qué queda en `SPEC.md` |
|---|---|---|
| Narrativa de la sesión, hallazgos, el "por qué" | `brain/sesiones.md` | Nada — ni en el header, ni en el footer, ni en una fila (salvo las N de `sesiones_anteriores_en_spec`) |
| Ítem cerrado | `spec/cerrados.md` (ID + fecha + evidencia) | Nada — sale de la §3 |
| Detalle técnico de un componente | `spec/features.md` | 1 fila por componente en la §7 |
| Schema de API o hallazgo de integración | `spec/api.md` | Solo el puntero |
| Decisión de arquitectura, proceso o riesgo | `brain/ADR\|INT\|NOC-*.md` + `brain/index.md` | Solo el puntero, en la §5 |
| Planes de sesiones pasadas | `spec/cerrados.md` o `brain/sesiones.md` | Nada |

**Reemplazar, no acumular:**
- "Última actualización" (header) = solo la fecha.
- "Última sesión" (§2) = 1 fila de ≤ ~400 caracteres que **sobrescribe** la anterior.
- Filas "Sesión anterior": ninguna por defecto; si el proyecto declara `sesiones_anteriores_en_spec: N`, exactamente N (≤ 2 líneas, ≤ 600 caracteres cada una); la más antigua sale y queda solo en `brain/sesiones.md`.
- Footer = **una línea** ≤ ~300 caracteres: versión + fecha + métricas clave del dominio. Su versión coincide con la de la cabecera.

**Tope de tamaño — se controla al leer y antes del commit.** `SPEC.md` ≤ `spec_tope_lineas` líneas (defecto **1000**) y ninguna línea > 600 caracteres. No hay script. Al abrir la sesión la lectura informa el número de líneas; en `ward` y `keepit`, antes del commit, Gemini revisa esta lista (puede apoyarse en `wc -l` o `awk` puntuales):
- líneas ≤ `spec_tope_lineas`; ninguna línea > 600 caracteres
- filas "Sesión anterior" = exactamente `sesiones_anteriores_en_spec`
- footer de una sola línea (≤ ~300 caracteres) con la misma versión que la cabecera
- ningún `- [ ]` ni sección de pendientes fuera de la §3; ningún `[x]` dentro de la §3
- IDs de la §3 sin duplicados

Si algo excede, condensar y mover el contenido a su destino según la tabla **antes** de commitear. Para un `SPEC.md` ya degradado, seguir el procedimiento de normalización de `references/spec-migracion-0.12.md`.

---

## 🔍 4. Manejo de Inconsistencias

Si Gemini detecta que el código real avanzó más allá de lo registrado en `SPEC.md`:
1. Confirmar con el humano el estado real del requerimiento.
2. Corregir `SPEC.md` en el registro (de inmediato con `registro: inmediato`; en el próximo `ward`/`keepit` con `diferido`), verificando el ítem contra código o datos reales.
3. Registrar brevemente en `brain/sesiones.md` la corrección de documentación para conservar la trazabilidad.

---

## 📈 5. Proyectos heredados sin Brain KMS

`project-init` crea `brain/` siempre. Si aparece un proyecto heredado que solo tiene `spec/` (sin `brain/`) y presenta decisiones de arquitectura que requieren referencia individual, integración con múltiples sistemas externos o trabajo colaborativo, Gemini debe proponer formalmente al humano la migración hacia **Brain KMS** (`brain/`).
