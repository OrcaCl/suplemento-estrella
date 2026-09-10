# Plantilla — Carpeta spec/ (Desglose de SPEC.md)

Cuando `SPEC.md` supera las 500 líneas o el proyecto requiere modularización ágil, la información se desglosa en la carpeta `spec/` usando estos 5 archivos especializados:

---

## 1. spec/api.md (Consumo de APIs de Terceros)
*Documenta exclusivamente servicios externos consumidos por el proyecto (no la API que el proyecto expone).*


## API externa — {{nombre del sistema}}

### Autenticación
**Método confirmado:** {{HTTP Basic Auth | Bearer token | API key en header}}

{{lenguaje}}
{{snippet de código mínimo mostrando cómo autenticar}}

### Comandos / Endpoints disponibles

|Comando/endpoint |Qué hace | Parámetros clave |
|-|-|-|
|{{nombre}}|{{descripción}}|{{parámetros}}|

### Estructura de respuestas

{{ejemplo de respuesta real, con nombres de campos exactos}}

### Variables de entorno requeridas

|Variable	|Descripción|
|-|-|
|{{VAR_NAME}}|	{{qué es, nunca el valor real}}|

### Limitaciones conocidas

{{ej. "el parámetro tz es ignorado, la API siempre retorna UTC"}}

---

## 2. spec/completado.md (Índice Plano de Éxito)
*Listado plano de checkboxes marcados. Sin narrativas ni explicaciones.*

## Completado

- [x] {{tarea}} — {{fecha}}
- [x] {{tarea}} — {{fecha}}

## 3 HISTORIAL.MD DEPRECATED----

## 4. spec/datos.md (Diccionario y Convenciones)

Convenciones de nomenclatura, términos del dominio y anexos.

# Datos — convenciones y diccionarios

## Convenciones de nomenclatura
{{formato de IDs, prefijos usados, normalización}}

## Diccionario de términos del dominio
| Término | Significado |
|---|---|
| {{término}} | {{definición}} |

## Anexos
{{referencias técnicas de apoyo}}

*REGLA NO NEGOCIABLE: NUNCA almacenar contraseñas, tokens, claves API ni credenciales sensibles en este archivo.*


## 5. spec/objetivos.md (Backlog Vivo Adaptable)

El nombre de este archivo se adapta al dominio del proyecto (ej. roadmap.md, incidencias.md, features.md).

# {{Nombre del backlog — ej. Roadmap, Features, Objetivos}}

## En curso
- [ ] {{ítem}} — origen: {{usuario/agente}}

## Backlog
- [ ] {{ítem}}

## Descartado
- [x] ~~{{ítem}}~~ — razón: {{por qué se descartó}}


# Regla de Automatización (project-init)

Al inicializar o reestructurar un proyecto:

  1. Monitorear el tamaño de SPEC.md. Si excede las 500 líneas, proponer la migración/desglose hacia spec/.

  2. Consultar al usuario cómo desea nombrar el archivo de backlog (objetivos.md, roadmap.md, incidencias.md, etc.)