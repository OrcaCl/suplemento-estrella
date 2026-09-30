# Plantillas — carpeta spec/

Cinco archivos, cada uno con un rol fijo. El nombre de `objetivos.md` es el único que se adapta al dominio del proyecto (ver nota al final).

---

## spec/api.md

Todo lo necesario para que el agente pueda comunicarse con sistemas **externos** al proyecto — no es documentación de la API que el proyecto expone, es documentación de las APIs de terceros que el proyecto consume.

```markdown
# API externa — {{nombre del sistema}}

## Autenticación

**Método confirmado:** {{ej. HTTP Basic Auth, Bearer token, API key en header}}

```{{lenguaje}}
{{snippet de código mínimo mostrando cómo autenticar}}
```

Métodos descartados (y por qué): {{si aplica}}

## Comandos / endpoints disponibles

| Comando/endpoint | Qué hace | Parámetros clave |
|---|---|---|
| {{nombre}} | {{descripción}} | {{parámetros}} |

## Estructura de respuestas

```json
{{ejemplo de respuesta real, con nombres de campos exactos}}
```

## Variables de entorno requeridas

| Variable | Descripción |
|---|---|
| {{VAR_NAME}} | {{qué es, nunca el valor real}} |

## Limitaciones conocidas

- {{ej. "el parámetro tz es ignorado, la API siempre retorna UTC"}}
```

---

## spec/cerrados.md

Archivo **único** de ítems cerrados (reemplaza a `completado.md` desde suplemento-core 0.12.0). Cada entrada lleva ID, fecha y evidencia.

```markdown
# Cerrados

**1 — ✅ CERRADO ({{fecha}}).** {{Título}}. {{1–2 frases: qué se hizo o por qué se descartó}}. Evidencia: {{consulta, test o commit verificable}}.
**2 — ✅ CERRADO ({{fecha}}), descartado.** {{Título}}. {{motivo}}. Evidencia: {{...}}.
```

**Regla de cierre:** borrar la fila de la §3 de `SPEC.md` → pegarla aquí con ID + fecha + evidencia → agregar el ID a la lista "Cerrados" de la §3. Cerrar por "ya estaba hecho" exige evidencia verificable, no solo "se implementó". Los IDs no se reutilizan. La narrativa del *por qué* va en `historial.md` (o `brain/sesiones.md`), no aquí.

Si el proyecto ya tiene un `spec/completado.md` (de 0.11 o anterior), no se borra: se marca `DEPRECATED` con un aviso que apunta a este archivo.

---

## spec/historial.md

La narrativa detrás de cada ítem de `cerrados.md`. Entradas cronológicas, más reciente arriba.

```markdown
# Historial

## {{fecha}} — {{título breve}}

{{2-4 líneas explicando qué se hizo, por qué, y cualquier hallazgo relevante}}

---
```

**Nota de escala:** en un proyecto simple, `cerrados.md` + `historial.md` cumplen la función que en un proyecto complejo cumple el sistema `brain/` ADR. Si este archivo empieza a crecer mucho y a consumir tokens de contexto en cada sesión, es la señal de que conviene migrar a `brain/` — ver skill `brain-kms`.

---

## spec/datos.md

Convenciones, diccionarios, anexos triviales para la implementación.

```markdown
# Datos — convenciones y diccionarios

## Convenciones de nomenclatura

{{ej. formato de IDs, prefijos usados, normalización de campos}}

## Diccionario de términos del dominio

| Término | Significado |
|---|---|
| {{término}} | {{definición}} |

## Anexos

{{cualquier referencia técnica de apoyo}}
```

**REGLA NO NEGOCIABLE:** este archivo **nunca** contiene contraseñas, tokens, API keys, ni ningún tipo de credencial. Es información de convención y contexto, no de configuración sensible.

---

## spec/objetivos.md (nombre adaptable al dominio)

Backlog vivo — combina lo que el usuario pide con lo que el agente sugiere para resolver el problema. En el proyecto de referencia se llamó `incidencias.md` porque ese era el dominio; el nombre debe reflejar el dominio del proyecto nuevo.

```markdown
# {{Nombre del backlog — ej. Roadmap, Features, Objetivos}}

## En curso

- [ ] {{ítem}} — origen: {{usuario/agente}}

## Backlog

- [ ] {{ítem}}

## Descartado

- [x] ~~{{ítem}}~~ — razón: {{por qué se descartó}}
```

---

## Nota sobre el nombre de objetivos.md

Al ejecutar `project-init`, preguntar al usuario cómo quiere llamar a este archivo si el nombre por defecto (`objetivos.md`) no encaja con el dominio. La función es siempre la misma independientemente del nombre.