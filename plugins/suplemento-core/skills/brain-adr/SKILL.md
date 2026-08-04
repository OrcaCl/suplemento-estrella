---
name: brain-adr
description: Disciplina de trabajo con el sistema brain/ (registros de decisión — ADR, INT, NOC, DEP, REF/REFX) para proyectos que usan la estructura completa. Úsala siempre que se vaya a tomar una decisión de arquitectura, una decisión sobre cómo el humano y Code trabajan juntos, documentar un hallazgo de riesgo mixto, retirar una herramienta o patrón, o registrar material de referencia (propio o de otro proyecto); al cerrar una sesión o checkpoint en un proyecto con brain/; o cuando un proyecto con estructura simple muestre señales de necesitar escalar a brain/. También aplica al crear un bug report o feature proposal hacia un sistema externo.
---

# Brain ADR

Cómo trabajar día a día con el sistema `brain/` una vez creado (por `project-init`). Esta skill gobierna cuándo crear cada tipo de registro, cómo mantener `index.md` y `sesiones.md` sin que se dupliquen, y cómo usar `trackers/` y `TOASK.md`.

## Las cinco categorías de registro — tabla de decisión

`brain/` no documenta solo "decisiones de arquitectura". Hay cinco tipos de registro, cada uno con un propósito distinto.

| Prefijo | Nombre | Qué documenta | Tono |
|---|---|---|---|
| `ADR-NNN` | Architecture Decision Record | Una decisión que afecta **lo que el sistema hace o cómo se comporta** — tecnología elegida, patrón adoptado, convención de código que impacta el producto | Formal: contexto, decisión, razones, consecuencias |
| `INT-NNN` | Interno | Una decisión que afecta **solo cómo el humano y Code trabajan juntos** — proceso de desarrollo, herramientas, o incluso convenciones de comunicación (ej. cómo se dirige el usuario a la instancia) — pero nunca lo que el sistema construido hace o cómo se comporta | Mismo formato que ADR, pero el objeto de la decisión es la relación/proceso de trabajo, no el producto |
| `NOC-NNN` | Nota de Cuidado | Un hallazgo de **riesgo o cuidado mixto** — ni puramente arquitectura, ni puramente seguridad, sino algo que combina ambos y amerita registro sin encuadrarse como alarma de seguridad ni forzarse dentro del formato de decisión de un ADR | Neutro, menos formal que un ADR — describe una preocupación a **monitorear**, no una decisión tomada |
| `DEP-NNN` | Retiro (Deprecation) | El retiro de una herramienta, archivo, patrón o plugin de la estructura de desarrollo — documenta un **cierre**, no una decisión hacia adelante | Breve: qué se retira, por qué, qué lo reemplaza si algo lo reemplaza |
| `REF-NNN` | Referencia | Material de observación o contexto de dominio propio de este proyecto, que no es una decisión — hallazgos, notas de investigación | Descriptivo, sin estructura de decisión |
| `REFX-NNN` | Referencia cruzada | Material descubierto **en otro proyecto**, que agrega contexto a este proyecto pero se mantiene deliberadamente separado — no se mezcla ni se reescribe como si fuera propio, se registra citando su origen. **Guardrail:** es información que el humano trae manualmente; Code nunca navega ni consulta el proyecto de origen por su cuenta | Descriptivo, con procedencia explícita (de qué proyecto vino) |

**Criterio de corte ADR vs. INT, en una frase:** si la pregunta "¿esto cambia lo que el sistema hace o cómo se comporta desde afuera?" responde que sí, es `ADR`. Si solo afecta el proceso o la relación de trabajo — aunque sea algo tan no-técnico como un nombre que adopta la instancia de Code — es `INT`.

## Cuándo crear cada tipo — ejemplos de corte

| Situación | Categoría |
|---|---|
| Se eligió SQLAlchemy sobre otro ORM para el proyecto | `ADR` |
| Se decidió pasar a alcance de test quirúrgico en vez de suite completa automática | `INT` |
| El usuario le pidió a Code que adoptara un nombre propio para dirigirse a ella con menos fricción | `INT` |
| Se detectó una tabla de datos sensibles creciendo rápido con credenciales compartidas entre servicios — sin acción tomada, pero a vigilar | `NOC` |
| Se dejó de usar un plugin de Claude Code que quedó obsoleto | `DEP` |
| Se encontró en otro proyecto propio una forma de resolver un problema similar, útil como contexto pero sin adaptar todavía | `REFX` |
| Se completó una tarea siguiendo un patrón ya establecido en un registro anterior | Ninguno — solo `sesiones.md` |

## Numeración y estado

- Cada prefijo tiene su propia numeración secuencial independiente.
- **Excepción de numeración conceptual:** un registro puede llevar `000` en vez del siguiente número consecutivo cuando es *conceptualmente anterior* a un registro ya existente de la misma categoría — por ejemplo, `INT-000` documentando una convención de base que resulta ser lógicamente previa a `INT-001`, aunque se haya escrito después en el tiempo. Usar esto con moderación — es la excepción, no el patrón general.
- Un `ADR` o `INT` **nunca se edita para cambiar la decisión original** — si la decisión cambia, se crea uno nuevo y el anterior se marca `Obsoleto — reemplazado por ADR-XXX` (o `INT-XXX`).
- Un `NOC` puede actualizarse in situ agregando entradas de seguimiento con fecha, porque es vigilancia activa, no una decisión cerrada.
- Un `DEP` no cambia de estado una vez creado.
- `REF`/`REFX` no tienen estado de vigencia — son contexto, no decisiones.

## La sección `## Commit`, al cierre de todo registro tipo ADR/INT

Cada `ADR-*.md` e `INT-*.md` termina con una sección `## Commit` que apunta a la entrada correspondiente en `brain/sesiones.md` — si el registro se creó antes de que ese commit exista todavía (por ejemplo, a mitad de sesión, antes del próximo checkpoint), dejar anotado explícitamente que está "pendiente al próximo `/checkpoint` o cierre de sesión", en vez de omitir la sección o inventar una referencia que todavía no existe.

Ver `references/adr-template.md`, `references/int-template.md`, `references/noc-template.md`, `references/dep-template.md`, y `references/ref-template.md` en `project-init/references/` para el formato completo de cada uno.

## brain/index.md — una sola tabla con columna "Tipo"

```markdown
## Registros de decisión y contexto

| ID | Tipo | Título | Estado |
|---|---|---|---|
| ADR-001 | ADR | ... | Vigente |
| INT-000 | INT | ... | Vigente |
| INT-001 | INT | ... | Vigente |
| NOC-001 | NOC | ... | Monitoreo activo |
| DEP-001 | DEP | ... | — |
| REFX-001 | REFX | ... | — |
```

**Regla no negociable, sigue vigente sin cambios:** `index.md` contiene únicamente esta tabla y un puntero a `sesiones.md`. Nunca pegar resúmenes de sesión aquí, sin importar cuántas categorías se agreguen.

## Registro al cierre de sesión o checkpoint

Al ejecutar un checkpoint o cerrar sesión (ver skill `documentation-convention` y el comando `checkpoint`), proponer:

1. `brain/sesiones.md` — nueva entrada con hitos, archivos modificados, próximo paso
2. El registro que corresponda según la tabla de decisión (`ADR`, `INT`, `NOC`, `DEP`, `REF`, o `REFX`) — puede ser más de uno
3. `brain/index.md` — agregar la fila correspondiente a cualquier registro nuevo
4. `SPEC.md` — footer y sección de pendientes
5. Completar la sección `## Commit` de cualquier `ADR`/`INT` creado en la sesión, ahora que el commit real ya existe

## trackers/ — bugs, features, y plantilla de retiros

- `bugs.md` + `bugs-report-template.md` → algo que un sistema externo hace mal
- `features.md` + `features-proposal-template.md` → algo que se le pediría a un sistema externo
- `deprecation-template.md` → plantilla de referencia para registros `DEP` (el registro en sí vive en `brain/DEP-NNN.md`, de primer nivel, igual que ADR/INT/NOC — la plantilla vive en `trackers/` por convención de ubicación de plantillas, no el registro)

Instancias completas de bugs y features siempre van en `trackers/generated/`.

## TOASK.md — sin cambios

Preguntas o ideas tangenciales, categorizadas por audiencia (A/D/S). No promover automáticamente un ítem a un registro formal sin confirmación del usuario.

## Migración desde estructura simple

Ya no ocurre por defecto en proyectos nuevos (con `project-init` creando siempre la estructura completa), pero puede seguir siendo relevante para proyectos existentes de una versión anterior de la skill:

1. Confirmar con el usuario antes de mover nada.
2. Clasificar cada entrada del historial existente según la tabla de cinco categorías.
3. Crear `brain/index.md` y `brain/sesiones.md` desde ese punto en adelante.
4. Documentar la fecha de la migración.