# Plantillas — brain/trackers/

Sistema de índice + plantilla + instancias generadas, para dos tipos de seguimiento: bugs en sistemas **externos** (no del propio proyecto) y features que se le gustaría pedir a un proveedor/sistema externo.

Solo aplica en la estructura completa (con `brain/`).

---

## brain/trackers/bugs.md (índice)

```markdown
# Bugs reportados a sistemas externos

| ID | Descripción | Estado |
|---|---|---|
| BR-{{SISTEMA}}-{{NNNN}} | {{descripción breve}} | {{Pendiente envío | Enviado | Cerrado}} |

Ver detalle de cada bug en `generated/`.
```

---

## brain/trackers/bugs-report-template.md (plantilla)

```markdown
# BR-{{SISTEMA}}-{{NNNN}} — {{Título breve}}

**Sistema afectado:** {{nombre del sistema externo}}
**Fecha detectado:** {{fecha}}
**Estado:** Pendiente envío

## Descripción

{{Qué comportamiento incorrecto se observa}}

## Pasos para reproducir

1. {{paso}}
2. {{paso}}

## Comportamiento esperado vs. observado

| Esperado | Observado |
|---|---|
| {{qué debería pasar}} | {{qué pasa realmente}} |

## Evidencia

{{logs, capturas, requests/responses de ejemplo}}

## Impacto

{{qué funcionalidad del proyecto se ve afectada mientras el bug no se resuelve}}
```

Instancias completas van en `brain/trackers/generated/BR-{{SISTEMA}}-{{NNNN}}.md`.

---

## brain/trackers/features.md (índice)

```markdown
# Features solicitadas a sistemas externos

| ID | Descripción | Prioridad |
|---|---|---|
| FR-{{SISTEMA}}-{{NNNN}} | {{descripción breve}} | {{Baja | Media | Alta}} |

Ver detalle en `generated/`.
```

---

## brain/trackers/features-proposal-template.md (plantilla)

```markdown
# FR-{{SISTEMA}}-{{NNNN}} — {{Título breve}}

**Sistema destino:** {{nombre del sistema externo}}
**Fecha propuesta:** {{fecha}}
**Prioridad:** {{Baja | Media | Alta}}

## Problema que resuelve

{{Qué limitación actual motiva pedir esta feature}}

## Propuesta

{{Qué se le pediría al sistema externo que implemente}}

## Valor esperado

{{Qué desbloquea o mejora para el proyecto una vez implementado}}

## Alternativas evaluadas

{{Si existe alguna forma de resolverlo sin depender del sistema externo, documentarla aquí — y por qué no se eligió}}
```

Instancias completas van en `brain/trackers/generated/FR-{{SISTEMA}}-{{NNNN}}.md`.

---

## Convención de IDs

`{{TIPO}}-{{SISTEMA}}-{{NNNN}}` — ej. `BR-API-0001`, `FR-API-0003`. El componente `{{SISTEMA}}` identifica de qué sistema externo se trata cuando el proyecto integra con más de uno (útil desde el segundo sistema externo en adelante; con uno solo puede omitirse y usar solo `{{TIPO}}-{{NNNN}}`).