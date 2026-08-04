# Plantilla — brain/DEP-NNN-{slug}.md

Documenta el **retiro** de una herramienta, archivo, patrón o plugin de la estructura de desarrollo — a diferencia de un ADR (decisión hacia adelante), esto documenta un cierre. Breve a propósito.

---

```markdown
# DEP-{{NNN}} — Retiro de {{qué se retira}}

**Fecha:** {{fecha}}

## Qué se retira

{{Nombre exacto de la herramienta, archivo, patrón, o plugin. Si es un plugin de Claude Code, versión en la que se retiró.}}

## Por qué

{{Razón del retiro — quedó obsoleto, fue reemplazado, dejó de mantenerse, generaba un problema conocido. Puede referenciar un NOC previo si el retiro es consecuencia de un riesgo que se venía vigilando.}}

## Qué lo reemplaza

{{Si algo lo reemplaza, nombrarlo — puede ser "nada, se elimina sin reemplazo" si corresponde.}}

## Impacto

{{Qué hay que ajustar en el proyecto como consecuencia — archivos a actualizar, configuración a limpiar, referencias que quedarían rotas si no se ajustan.}}

## Commit

{{Referencia a la entrada correspondiente en brain/sesiones.md, o "Pendiente al próximo /checkpoint o cierre de sesión."}}
```

---

## Notas de uso

- Un DEP no cambia de estado — es un hecho consumado desde el momento en que se crea, no una decisión que se pueda revertir editando el mismo archivo. Si algo retirado se vuelve a adoptar más adelante, eso es un `ADR` o `INT` nuevo (según corresponda), no una edición del `DEP` original.
- Referenciar el plugin de trackers: `trackers/deprecation-template.md` contiene esta misma plantilla como referencia rápida, pero el registro real siempre se crea como archivo de primer nivel en `brain/`, no dentro de `trackers/generated/`.