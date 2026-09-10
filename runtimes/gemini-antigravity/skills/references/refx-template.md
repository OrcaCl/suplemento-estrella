
## REFX-NNN — referencia cruzada desde otro proyecto

```markdown
# REFX-{{NNN}} — {{Título del hallazgo}}

**Fecha:** {{fecha}}
**Proyecto de origen:** {{nombre del otro proyecto donde se encontró esto}}

## Qué se encontró en el otro proyecto

{{Descripción del hallazgo o patrón, tal como se documentó originalmente en el proyecto de origen — sin reescribirlo como si fuera propio de este proyecto.}}

## Por qué agrega contexto acá

{{Qué problema o pregunta de ESTE proyecto podría beneficiarse de este contexto. Puede quedar como "pendiente de adaptar" si todavía no se aplicó nada concreto.}}

## Estado de adopción

{{"Solo como referencia, sin adaptar todavía" | "Adaptado — ver ADR-XXX / INT-XXX que lo formalizó para este proyecto" | "Evaluado y descartado — razón"}}
```

---

## Notas de uso

- **Guardrail no negociable:** `REFX` es información que el humano trae manualmente al proyecto — **nunca un puntero que Code sigue por su cuenta**. Code no navega, lee, ni consulta el proyecto de origen mencionado en un `REFX`, ni siquiera "para entender mejor el contexto". Si hace falta más información del otro proyecto, eso requiere que el humano la traiga explícitamente en una sesión nueva o la pegue directamente — nunca una decisión autónoma de ir a buscarla. Esta restricción existe porque explorar otro proyecto consume contexto y tokens en una tarea que nadie pidió, y puede "marear" la sesión actual con información de un proyecto distinto.
- **La distinción REF vs. REFX no es sobre el contenido, es sobre la procedencia.** Un hallazgo hecho investigando directamente en este proyecto es `REF`. Un hallazgo que ya existía documentado en otro proyecto propio, y que se trae acá como contexto adicional, es `REFX` — y debe conservar la cita de origen (`Proyecto de origen`) siempre, no fusionarse silenciosamente con el conocimiento propio del proyecto actual.
- Ninguno de los dos tiene estado de vigencia (`Vigente`/`Obsoleto`) porque no son decisiones — son contexto. Si un `REFX` termina formalizándose como una decisión real para este proyecto, esa decisión se registra como `ADR` o `INT` nuevo, que puede referenciar el `REFX` como su origen — el `REFX` en sí no se convierte en otra cosa.