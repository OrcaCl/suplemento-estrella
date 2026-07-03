# Plantilla — SPEC.md

Copiar esta estructura como `SPEC.md` en la raíz del proyecto. Reemplazar los placeholders entre `{{ }}`. Mantener las 8 secciones en este orden — es la convención fija de PROMATIC, independiente del dominio del proyecto.

`SPEC.md` es el panel de control: corto, vivo, se actualiza cada sesión. No es el lugar para narrativa extensa — eso vive en `spec/historial.md` o `brain/`.

---

```markdown
# {{Nombre del Proyecto}}

## Documento de contexto y descubrimientos

**Versión:** 0.1
**Última actualización:** {{fecha}}

---

## 1. Problema y objetivo

{{1 párrafo describiendo el problema que resuelve el proyecto}}

| Fuente | Qué entrega |
|---|---|
| {{fuente de datos 1}} | {{qué aporta}} |
| {{fuente de datos 2}} | {{qué aporta}} |

**Objetivo:** {{1-2 frases del resultado esperado}}

---

## 2. Estado actual

| Métrica | Valor |
|---|---|
| Tests en verde | {{N}} |
| {{métrica relevante al dominio}} | {{valor}} |
| Última sesión | {{fecha}} — **{{resumen de 1 línea}}**: {{detalle breve}} |

---

## 3. Pendientes activos

### 🗓 Próxima sesión

**Prioridad 0 — {{título}}**

- [ ] {{tarea}}
- [ ] {{tarea}}

**Prioridad 1 — {{título}}**

- [ ] {{tarea}}

---

## 4. Reglas críticas — NO NEGOCIABLE

> {{Regla que si se rompe causa daño grave — ej. "solo lectura sobre API externa", "nunca eliminar datos de producción sin confirmación explícita"}}

Si no hay ninguna regla crítica todavía, dejar esta sección con:
> _Sin reglas críticas registradas todavía. Agregar aquí la primera vez que una decisión de este tipo se tome._

---

## 5. Decisiones que el agente debe recordar siempre

| Decisión | Detalle |
|---|---|
| {{decisión}} | {{detalle accionable, no narrativo}} |

---

## 6. Stack tecnológico

| Componente | Tecnología | Versión |
|---|---|---|
| Lenguaje | {{lenguaje}} | {{versión}} |
| Gestor de paquetes | {{herramienta}} | {{versión}} |
| ORM / capa de datos | {{herramienta}} | — |
| Testing | {{herramienta}} | — |
| BD desarrollo | {{motor}} | — |
| BD producción | {{motor}} | — |

Ver `references/tooling-roles.md` (skill `tooling-roles`) para el mapeo completo de roles funcionales → herramientas por lenguaje si el stack no es Python.

---

## 7. Componentes / módulos implementados

| Componente | Módulo | Estado |
|---|---|---|
| {{nombre}} | {{ruta}} | {{estado}} |

---

## 8. Referencias a spec/

| Archivo | Contenido |
|---|---|
| [`spec/api.md`](spec/api.md) | Integración con sistemas externos: auth, comandos, estructura de respuestas |
| [`spec/{{objetivos}}.md`](spec/{{objetivos}}.md) | Backlog vivo — lo que el usuario necesita + lo que el agente sugiere |
| [`spec/datos.md`](spec/datos.md) | Convenciones, diccionarios, anexos — nunca secretos |
| [`spec/historial.md`](spec/historial.md) | Narrativa de decisiones y hallazgos de sesiones pasadas |
| [`spec/completado.md`](spec/completado.md) | Checklist plano de tareas completadas |

---

_Documento de trabajo interno — v0.1. {{footer con conteo de tests y métricas clave, se actualiza cada sesión}}_
```

---

## Notas de uso

- **Sección 4 (Reglas críticas)** debe mantenerse corta — si crece a más de 3-4 reglas, es señal de que el proyecto probablemente necesitaba la estructura completa (`brain/`) desde el principio, no la simple.
- **El footer de la última línea** se actualiza en cada sesión con las métricas más recientes — es lo primero que el agente debe leer para tener una foto rápida del estado sin cargar todo el archivo.
- Si el proyecto usa la estructura simple (sin `brain/`), la Sección 5 hace las veces de lo que en la estructura completa sería el catálogo de ADRs — mantenerla como tabla, no como narrativa.