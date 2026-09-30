# Plantilla — SPEC.md

Copiar esta estructura como `SPEC.md` en la raíz del proyecto. Reemplazar los placeholders entre `{{ }}`. Mantener las 8 secciones en este orden — es la convención fija de Suplemento Estrella, independiente del dominio del proyecto.

`SPEC.md` es el panel de control: corto (≤ 1000 líneas por defecto, configurable con `spec_tope_lineas`), vivo, se reemplaza —no se acumula— en cada sesión. No es el lugar para narrativa extensa — eso vive en `brain/`.

---

```markdown
<!-- LÍMITES DE ESTE ARCHIVO: ≤ 1000 líneas (spec_tope_lineas), ninguna línea > 600 caracteres.
     Al actualizar: REEMPLAZAR, no acumular. Narrativa → brain/sesiones.md · ítems cerrados → spec/cerrados.md (ID + fecha + evidencia) ·
     detalle técnico de componentes → spec/features.md · schemas de API → spec/api.md.
     Header = solo fecha · §2 "Última sesión" = 1 fila ≤ 400 car. que sobrescribe la anterior · footer = 1 línea ≤ 300 car.
     Pendientes: SOLO en §3 (sin "Próxima sesión"/"Prioridad N" ni `- [ ]` en otras secciones).
     Antes de commitear: revisar que no pase del tope de líneas ni tenga líneas > 600 caracteres. Si excede, condensar primero. -->

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
| Tests en verde | {{N — omitir esta fila si el proyecto no tiene tests}} |
| {{métrica relevante al dominio}} | {{valor}} |
| Última sesión | {{fecha}} — **{{resumen de 1 línea}}**: {{detalle breve, ≤ ~400 caracteres en total}} — _se sobrescribe cada sesión; filas "Sesión anterior" solo si el proyecto declara `sesiones_anteriores_en_spec: N` en `CLAUDE.md`_ |

---

## 3. Pendientes activos

> Lista única: los ítems abiertos existen **solo aquí**. Un ítem conserva su ID hasta cerrarse y el ID no se reutiliza. Al cerrarlo: borrar la fila → insertarla en `spec/cerrados.md` con su mismo ID + fecha + evidencia, en su posición por ID → agregar el ID a "Cerrados".

**Alta**

- [ ] **1** — {{tarea}}: {{una línea de contexto}}
- [ ] **2** — {{tarea}}: {{una línea de contexto}}

**Media**

- [ ] **3** — {{tarea}}: {{una línea de contexto}}

**Baja / Externo**

- _(vacío)_

Cerrados: _(ninguno todavía — ver `spec/cerrados.md`)_

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
| [`spec/cerrados.md`](spec/cerrados.md) | Archivo único de ítems cerrados: ID original + fecha + evidencia, ordenado por ID |

---

_Documento de trabajo interno — v0.1. {{footer ≤ 300 caracteres: versión + fecha + métricas clave del dominio (conteo de tests solo si el proyecto tiene tests)}}_
```

---

## Notas de uso

- **Sección 4 (Reglas críticas)** debe mantenerse corta — si crece a más de 3-4 reglas, es señal de que el proyecto probablemente necesitaba la estructura completa (`brain/`) desde el principio, no la simple.
- **El footer de la última línea** es una foto rápida del estado (versión, fecha, métricas clave), no una bitácora: se **reemplaza** en cada sesión, nunca se le agrega texto encima del anterior, y no pasa de ~300 caracteres.
- **Reemplazar, no acumular:** la narrativa de sesiones va a `brain/sesiones.md`, los ítems cerrados salen de la §3 hacia `spec/cerrados.md` (mismo ID + fecha + evidencia, ordenado por ID) y `SPEC.md` completo se mantiene bajo `spec_tope_lineas` (1000 por defecto), revisado al leerlo y antes de cada commit. Ver skill `spec-driven-development`.
- Si el proyecto usa la estructura simple (sin `brain/`), la Sección 5 hace las veces de lo que en la estructura completa sería el catálogo de ADRs — mantenerla como tabla, no como narrativa.