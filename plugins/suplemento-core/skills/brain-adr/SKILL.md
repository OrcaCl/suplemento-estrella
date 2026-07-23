---
name: brain-adr
description: Disciplina de trabajo con el sistema brain/ (ADR — Architecture Decision Records) para proyectos que usan la estructura completa. Úsala siempre que se vaya a tomar una decisión de arquitectura, diseño, o tecnología que sería costosa de revertir; cuando el usuario pida documentar el "por qué" de un cambio; al cerrar una sesión de trabajo en un proyecto con brain/; o cuando un proyecto con estructura simple (solo spec/) muestre señales de necesitar escalar a brain/. También aplica al crear un bug report o feature proposal hacia un sistema externo.
---

# Brain ADR

Cómo trabajar día a día con el sistema `brain/` una vez creado (por `project-init`, en la estructura completa). Esta skill gobierna cuándo crear un ADR, cómo mantener `index.md` y `sesiones.md` sin que se dupliquen, y cómo usar `trackers/` y `TOASK.md`.

## Cuándo crear un ADR — el criterio, no solo el checklist

Un ADR documenta una decisión que sería costosa de revertir o que alguien (humano o agente) va a necesitar entender el "por qué" meses después, sin el contexto de la conversación original.

| Situación | ¿ADR? |
|---|---|
| Se eligió una tecnología, librería, o patrón arquitectónico entre varias opciones | Sí |
| Se descubrió una limitación de un sistema externo que cambia cómo se diseña algo propio | Sí |
| Se estableció una convención de código que va a aplicar de ahí en adelante (ej. "toda tabla de importación lleva columna raw_data") | Sí |
| Se completó una tarea siguiendo un patrón ya establecido en un ADR anterior | No — solo `sesiones.md` |
| Se corrigió un bug sin cambiar ningún diseño | No — solo `sesiones.md` |
| Se hizo un refactor que no cambia decisiones previas, solo prolijidad | No — solo `sesiones.md`, salvo que el refactor en sí mismo fije una convención nueva |

Ante la duda: si en 3 meses alguien preguntara "¿por qué se hizo así y no de otra forma?" y la respuesta no es obvia solo mirando el código, es un ADR.

## Numeración y estado

- Numeración secuencial, nunca se reutiliza un número.
- Un ADR **nunca se edita para cambiar la decisión original** — si la decisión cambia, se crea un ADR nuevo y el anterior se marca `Obsoleto — reemplazado por ADR-XXX`. Esto preserva el historial de *por qué* se decidió algo distinto después, que es tan valioso como la decisión vigente.
- Estados válidos: `Vigente`, `En progreso` (aprobado pero implementación pendiente), `Obsoleto — reemplazado por ADR-XXX`.

Ver `references/adr-template.md` (compartida con `project-init`, en `project-init/references/brain-adr-template.md`) para el formato completo.

## La regla más importante: index.md vs. sesiones.md nunca se duplican

Esta es una lección aprendida de un caso real, no una precaución teórica: en un proyecto de referencia, `brain/index.md` terminó acumulando ~30 secciones de "estado actual del proyecto" — una por cada sesión — que deberían haber vivido exclusivamente en `sesiones.md`. La causa fue querer tener "lo último" a mano sin scrollear hasta `sesiones.md`.

**Regla estricta:**

| Archivo | Contiene | No contiene |
|---|---|---|
| `brain/index.md` | Tabla de ADRs (ID, título, estado) + puntero a `sesiones.md` | Resúmenes de sesión, aunque sea "solo el último" |
| `brain/sesiones.md` | Registro cronológico completo, entrada por sesión | Nada — este es el único lugar para el detalle |

Si en algún momento sientes la tentación de agregar un resumen de sesión a `index.md` "para tenerlo a mano", esa es exactamente la señal de alerta — la solución correcta es que `sesiones.md` tenga las entradas más recientes arriba (ya es la convención), no duplicar contenido en otro archivo.

## Registro al cierre de sesión

Al finalizar cualquier sesión que haya tocado el proyecto, proponer sin esperar instrucción explícita:

1. `brain/sesiones.md` — nueva entrada con hitos, archivos modificados, próximo paso
2. `brain/ADR-NNN.md` — si se tomó una decisión que cumple el criterio de arriba
3. `brain/index.md` — solo si hay un ADR nuevo que agregar a la tabla (nunca para resumen de sesión)
4. `SPEC.md` — footer y sección de pendientes, como en `spec-driven-development`

## trackers/ — bugs y features hacia sistemas externos

`brain/trackers/` documenta problemas o pedidos que van dirigidos a un sistema **externo** al proyecto (una API de terceros, un proveedor) — no bugs propios, esos van directo a resolverse en el código.

- `bugs.md` + `bugs-report-template.md` → algo que el sistema externo hace mal
- `features.md` + `features-proposal-template.md` → algo que se le pediría al sistema externo que agregue

Instancias completas siempre van en `trackers/generated/`, nunca sueltas en la raíz de `trackers/`. Ver plantillas completas en `project-init/references/trackers-templates.md`.

## TOASK.md — el post-it digital, no un backlog formal

`brain/TOASK.md` es para preguntas o ideas que surgen mientras se trabaja en otra cosa, y que no son la tarea actual. La categorización por audiencia importa porque determina qué hacer con cada pregunta:

- **A** (usuario/administrador) — preguntar en la próxima interacción con esa persona
- **D** (desarrollador/proveedor externo) — acumular para la próxima coordinación formal
- **S** (investigable internamente) — el propio agente puede resolverla cuando tenga un momento, sin bloquear la tarea actual

No promover automáticamente un ítem de `TOASK.md` a una feature formal en `trackers/` sin que el usuario lo confirme — son etapas distintas de madurez de una idea.

## Migración desde estructura simple (spec/ → brain/)

Si un proyecto arrancó con estructura simple y la skill `spec-driven-development` detectó señales de que necesita escalar:

1. Confirmar con el usuario antes de mover nada.
2. Revisar `spec/historial.md` completo y decidir, entrada por entrada, cuáles corresponden a una decisión de arquitectura (se convierten en ADR retroactivo) y cuáles son simplemente historial operativo (se quedan en `spec/historial.md`, que sigue existiendo — `brain/` no reemplaza `spec/`, lo complementa).
3. Crear `brain/index.md` y `brain/sesiones.md` desde ese punto en adelante — no hace falta reconstruir retroactivamente todo el historial de sesiones pasadas en `brain/sesiones.md`, solo los ADRs que se identifiquen como tal.
4. Documentar en el primer ADR nuevo, o en `sesiones.md`, la fecha de la migración — para que quede claro por qué el historial de decisiones "empieza" en un punto intermedio del proyecto.