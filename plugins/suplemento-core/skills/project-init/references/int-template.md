# Plantilla — brain/INT-NNN-{slug}.md

Documenta una decisión sobre **cómo el humano y Code trabajan juntos** — proceso, herramientas, o convenciones de comunicación — nunca sobre lo que el sistema construido hace o cómo se comporta (eso es `ADR`).

---

```markdown
# INT-{{NNN}} — {{Título de la decisión}}

**Estado:** {{Vigente | Obsoleto — reemplazado por INT-XXX}}
**Fecha:** {{fecha}}

## Contexto

{{Qué situación llevó a esta decisión. Puede ser tan técnica como "estábamos corriendo la suite completa en cada cambio y consumía tokens de más" o tan informal como "el usuario quería una forma menos mecánica de dirigirse a la instancia". Ambas son igual de válidas como contexto de un INT.}}

## Decisión

{{Qué se decidió. Si es una convención más que una regla — como el ejemplo del nombre propio — aclarar explícitamente que no es NO NEGOCIABLE, es una práctica a mantener conscientemente, no una regla de seguridad o proceso técnico.}}

## Consecuencias

- {{Qué archivo(s) necesitan reflejar esta decisión para que se sostenga entre sesiones — por ejemplo, una línea en CLAUDE.md, un cambio en otra skill}}
- {{Qué NO cambia — por ejemplo, "no cambia ninguna regla técnica del proyecto"}}

## Commit

{{Referencia a la entrada correspondiente en brain/sesiones.md. Si el registro se crea antes de que ese commit exista, escribir: "Pendiente al próximo /checkpoint o cierre de sesión."}}
```

---

## Notas de uso

- Usar `000` en vez del siguiente consecutivo cuando el registro es conceptualmente anterior a uno ya existente de la misma categoría — ver skill `brain-adr` para el criterio completo.
- La sección "Nota de alcance" (opcional, no incluida en la plantilla base arriba) puede agregarse al principio del documento cuando el INT se relaciona directamente con otro INT existente — un enlace corto explicando la relación, como en el ejemplo real: *"igual que [INT-001](INT-001-...), este documento usa el prefijo INT — es una decisión sobre cómo trabajamos con la herramienta, no sobre la arquitectura del sistema."*