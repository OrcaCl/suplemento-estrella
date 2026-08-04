# Plantilla — brain/NOC-NNN-{slug}.md

Documenta un hallazgo de **riesgo o cuidado mixto** — ni puramente arquitectura, ni puramente seguridad, algo que combina ambos y amerita vigilancia sin ser todavía una decisión tomada. Tono neutro y menos formal que un ADR — describe una preocupación, no una elección.

---

```markdown
# NOC-{{NNN}} — {{Descripción breve de la preocupación}}

**Estado:** Monitoreo activo | Resuelto — ver {{ADR/INT/DEP que lo cerró}} | Descartado — {{razón}}
**Fecha de apertura:** {{fecha}}

## Observación

{{Qué se notó. Describir la mezcla de factores que hace que esto no encaje limpiamente como alarma de seguridad pura ni como decisión de arquitectura pura — por ejemplo, "el volumen de la tabla X crece a un ritmo que en Y meses podría requerir replanificar el modelo de datos, Y las credenciales de acceso a esa misma tabla están compartidas entre dos servicios sin rotación — ninguno de los dos hechos por separado amerita acción inmediata, pero juntos valen la pena vigilar."}}

## Por qué no es un ADR ni una alarma de seguridad todavía

{{Explicar brevemente por qué se registra como NOC en vez de escalar — ej. "no hay evidencia de explotación activa" o "el crecimiento todavía es proyectado, no medido con certeza".}}

## Qué vigilar

- {{Señal concreta que, de aparecer, ameritaría escalar esto a un ADR, INT, o reporte de seguridad formal}}

## Seguimiento

{{Esta sección se actualiza in situ con nuevas entradas fechadas a medida que la situación evoluciona — a diferencia de ADR/INT, un NOC sí se edita directamente en vez de crear uno nuevo.}}

- **{{fecha}}:** {{qué cambió, si algo cambió}}

## Commit

{{Referencia a la entrada correspondiente en brain/sesiones.md, o "Pendiente al próximo /checkpoint o cierre de sesión."}}
```

---

## Notas de uso

- Un NOC no tiene por qué resolverse nunca — puede quedar en "Monitoreo activo" indefinidamente si el riesgo es real pero de baja prioridad.
- Si el riesgo se materializa o se decide actuar sobre él, el NOC se marca "Resuelto" apuntando al `ADR`, `INT`, o `DEP` que lo cerró — no se convierte en esos formatos, se referencia desde ellos.