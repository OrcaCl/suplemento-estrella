# Plantillas — sistema brain/ (ADR)

Solo se crea si el proyecto eligió la estructura completa en `project-init`. Documenta el **por qué** de las decisiones de arquitectura — `spec/` documenta el día a día, `brain/` documenta las decisiones que van a importar dentro de 6 meses cuando nadie recuerde el contexto original.

---

## brain/index.md

**Regla no negociable:** este archivo contiene ÚNICAMENTE la tabla de ADRs y un puntero a `sesiones.md`. Nunca pegar resúmenes de sesión aquí — esa duplicación ocurrió en un proyecto real y terminó con ~30 secciones redundantes entre `index.md` y `sesiones.md`. Si sientes la tentación de agregar "estado actual del proyecto" a este archivo, esa información va en `sesiones.md`, no aquí.

```markdown
# Brain — Índice de decisiones y contexto acumulado

Este directorio complementa el `SPEC.md`. Documenta el **por qué** de las decisiones técnicas (ADRs) y el historial de sesiones de trabajo.

---

## Decisiones de arquitectura (ADRs)

| ID | Título | Estado |
|---|---|---|
| [ADR-001](ADR-001-{{slug}}.md) | {{título}} | Vigente |

---

## Registro de sesiones

Ver [sesiones.md](sesiones.md) para el historial completo con hitos y descubrimientos.

---

## Documentos de referencia externos

Ver carpeta [files/](files/) para documentos de reuniones y referencias externas.
```

---

## brain/ADR-NNN-{slug}.md

Un archivo por decisión. Numeración secuencial, nunca se reutiliza un número aunque el ADR se marque como obsoleto.

```markdown
# ADR-{{NNN}} — {{Título de la decisión}}

**Estado:** {{Vigente | En progreso | Obsoleto — reemplazado por ADR-XXX}}
**Fecha:** {{fecha}}

## Contexto

{{Qué problema o disyuntiva llevó a esta decisión. Qué opciones existían.}}

## Decisión

{{Qué se decidió, en 1-3 frases directas.}}

## Razones

1. {{razón 1}}
2. {{razón 2}}

## Consecuencias

- {{consecuencia, incluyendo trade-offs aceptados a propósito}}
```

**Regla de estado:** un ADR nunca se edita para cambiar la decisión — si la decisión cambia, se crea un ADR nuevo y el anterior se marca `Obsoleto — reemplazado por ADR-XXX`. El historial de decisiones es tan valioso como la decisión vigente.

---

## brain/sesiones.md

Registro cronológico, entrada por sesión, más reciente arriba. Este es el único lugar para el detalle de "qué se hizo hoy".

```markdown
# Registro de sesiones

Hitos relevantes por sesión de trabajo. Las entradas más recientes van arriba.

---

## Sesión — {{fecha}} — {{título breve}}

**Contexto:** {{1 línea de qué se pidió trabajar esta sesión}}

- **{{hito 1}}:** {{detalle}}
- **{{hito 2}}:** {{detalle}}

### Archivos modificados
- {{ruta}}

### Próximo
- {{siguiente paso}}

---
```

---

## brain/TOASK.md

Preguntas o ideas que surgen durante el desarrollo pero que no son la tarea actual — un post-it digital, categorizado por audiencia para saber a quién preguntarle después.

```markdown
# Preguntas pendientes (TOASK)

Categorías: **A** = humano :) /administrador del proyecto · **D** = desarrollador/proveedor externo · **S** = investigable internamente por el agente

## Pendientes

- [ ] **{{categoría}}** — {{pregunta o idea, fecha}}

## Resueltas

- [x] ~~{{pregunta}}~~ → {{respuesta encontrada}}
```

---

## Cuándo crear un ADR vs. solo anotar en sesiones.md

| Situación | Dónde va |
|---|---|
| Se eligió una tecnología, patrón, o enfoque que afecta la arquitectura y sería costoso revertir | ADR nuevo |
| Se completó una tarea siguiendo un patrón ya establecido | Solo `sesiones.md` |
| Se descubrió una limitación de una herramienta externa que cambia cómo se diseña algo | ADR nuevo |
| Se corrigió un bug sin cambiar el diseño | Solo `sesiones.md` |