# Plantilla — brain/REF-NNN-{slug}.md y brain/REFX-NNN-{slug}.md

Documentan material de **contexto u observación**, no una decisión — por eso no llevan estructura de contexto/decisión/consecuencias como ADR/INT. `REF` es hallazgo propio de este proyecto; `REFX` es material que vino de **otro proyecto** y se mantiene deliberadamente separado, citando su procedencia, sin mezclarse como si fuera propio.

---

## REF-NNN — hallazgo u observación propia de este proyecto

```markdown
# REF-{{NNN}} — {{Título del hallazgo}}

**Fecha:** {{fecha}}

## Qué se encontró

{{Descripción del hallazgo — puede ser una observación de dominio, un comportamiento de una API externa, un patrón de datos detectado.}}

## Por qué es relevante

{{Qué decisión, feature, o entendimiento del proyecto se apoya en este hallazgo.}}

## Fuente

{{De dónde viene la información — documentación externa, una sesión de investigación propia, una conversación con el cliente/administrador del proyecto.}}
```

---

## Notas de uso

- **Guardrail no negociable:** `REFX` es información que el humano trae manualmente al proyecto — **nunca un puntero que Code sigue por su cuenta**. Code no navega, lee, ni consulta el proyecto de origen mencionado en un `REFX`, ni siquiera "para entender mejor el contexto". Si hace falta más información del otro proyecto, eso requiere que el humano la traiga explícitamente en una sesión nueva o la pegue directamente — nunca una decisión autónoma de ir a buscarla. Esta restricción existe porque explorar otro proyecto consume contexto y tokens en una tarea que nadie pidió, y puede "marear" la sesión actual con información de un proyecto distinto.
- **La distinción REF vs. REFX no es sobre el contenido, es sobre la procedencia.** Un hallazgo hecho investigando directamente en este proyecto es `REF`. Un hallazgo que ya existía documentado en otro proyecto propio, y que se trae acá como contexto adicional, es `REFX` — y debe conservar la cita de origen (`Proyecto de origen`) siempre, no fusionarse silenciosamente con el conocimiento propio del proyecto actual.
- Ninguno de los dos tiene estado de vigencia (`Vigente`/`Obsoleto`) porque no son decisiones — son contexto. Si un `REFX` termina formalizándose como una decisión real para este proyecto, esa decisión se registra como `ADR` o `INT` nuevo, que puede referenciar el `REFX` como su origen — el `REFX` en sí no se convierte en otra cosa.