# Plantillas — brain/trackers/

Sistema de índice + plantilla + instancias generadas para bugs y propuestas hacia sistemas **externos** (no del propio proyecto). 

---

## 1. brain/trackers/bugs.md (Índice)


# Bugs reportados a sistemas externos

| ID | Descripción | Estado |
|---|---|---|
| BR-{{SISTEMA}}-{{NNNN}} | {{descripción breve}} | {{Pendiente envío | Enviado | Cerrado}} |

Ver detalle de cada bug en `generated/`.

## 2. brain/trackers/bugs-report-template.md (Plantilla)

# BR-{{SISTEMA}}-{{NNNN}} — {{Título breve}}

**Sistema afectado:** {{nombre del sistema externo}}
**Fecha detectado:** {{AAAA-MM-DD}}
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

Destino: Las instancias completas generadas van obligatoriamente en brain/trackers/generated/BR-{{SISTEMA}}-{{NNNN}}.md.



## 3. brain/trackers/features.md (Índice)

# Features solicitadas a sistemas externos

| ID | Descripción | Prioridad |
|---|---|---|
| FR-{{SISTEMA}}-{{NNNN}} | {{descripción breve}} | {{Baja | Media | Alta}} |

Ver detalle en `generated/`.

## 4. brain/trackers/features-proposal-template.md (Plantilla)

# FR-{{SISTEMA}}-{{NNNN}} — {{Título breve}}

**Sistema destino:** {{nombre del sistema externo}}
**Fecha propuesta:** {{AAAA-MM-DD}}
**Prioridad:** {{Baja | Media | Alta}}

## Problema que resuelve
{{Qué limitación actual motiva pedir esta feature}}

## Propuesta
{{Qué se le pediría al sistema externo que implemente}}

## Valor esperado
{{Qué desbloquea o mejora para el proyecto una vez implementado}}

## Alternativas evaluadas
{{Si existe alguna forma de resolverlo sin depender del sistema externo, documentarla aquí — y por qué no se eligió}}

Destino: Las instancias completas generadas van obligatoriamente en brain/trackers/generated/FR-{{SISTEMA}}-{{NNNN}}.md.

## 5. Convención de IDs

{{TIPO}}-{{SISTEMA}}-{{NNNN}} — ej. BR-API-0001, FR-STRIPE-0003.

  -  {{SISTEMA}} identifica la integración externa afectada (útil para proyectos con múltiples servicios externos).

  - Si el proyecto consume un único servicio externo, puede simplificarse a BR-0001 o FR-0001.

---

### Catálogo Completo de Referencias (`skills/references/`)

Con esto, el paquete de plantillas estáticas queda 100% cubierto:

```text
runtimes/gemini-antigravity/skills/references/
├── adr-template.md           # Plantilla ADR
├── int-template.md           # Plantilla INT
├── noc-template.md           # Plantilla NOC
├── dep-template.md           # Plantilla DEP
├── ref-template.md           # Plantilla REF
├── refx-template.md          # Plantilla REFX
├── ignore-template.md        # Plantilla .gitignore + .geminiignore
├── gemini-template.md        # Plantilla GEMINI.md
├── spec-folder-template.md   # Plantilla desglosada carpeta spec/ (> 500 líneas)
└── trackers-template.md      # Plantilla de trackers (bugs/features externos)