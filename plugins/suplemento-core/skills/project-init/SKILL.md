---
name: project-init
description: Skill de onboarding para inicializar un proyecto nuevo bajo la metodología Suplemento Estrella. Úsala siempre que el usuario esté arrancando un repositorio nuevo, pida "inicializar el proyecto", "arrancar con la metodología", "crear la estructura base", o cuando detectes que un repo no tiene todavía SPEC.md ni carpeta spec/. Pregunta el tamaño esperado del proyecto y crea la estructura de archivos correspondiente (simple: SPEC.md + spec/ · complejo: además brain/ ADR desde el inicio) para evitar el retrofit costoso de agregar brain/ a mitad de proyecto.
---

# Project Init

Punto de entrada de todo proyecto nuevo bajo metodología Suplemento Estrella. Decide qué estructura de documentación crear según la escala esperada del proyecto, y deja los archivos base listos para empezar a trabajar.

## Por qué existe esta skill

Agregar `brain/` (sistema de ADR) a mitad de proyecto, cuando `spec/historial.md` ya creció demasiado y empieza a consumir tokens de más, es un retrofit costoso: hay que decidir retroactivamente qué contenido histórico se convierte en ADR y cuál se queda en `spec/`, sin la claridad que sí existe al planificar desde el principio. Esta skill evita ese problema preguntando el tamaño esperado **antes** de escribir la primera línea de documentación.

## Paso 1 — Preguntar el tamaño del proyecto

No asumir el tamaño. Preguntar directamente algo como:

> "¿Este proyecto lo ves como algo acotado y de alcance conocido, o esperas que crezca en complejidad con el tiempo (múltiples módulos, integraciones externas, decisiones de arquitectura que se van a acumular)?"

Dos respuestas posibles:

- **Simple / acotado** → estructura mínima (Paso 2)
- **Complejo / va a crecer** → estructura completa (Paso 3)

Si el usuario no está seguro, el criterio por defecto es: **si el proyecto va a integrar con sistemas externos (APIs de terceros, múltiples fuentes de datos) o va a tener más de un colaborador humano+agente trabajando en paralelo, es complejo.** Ante la duda, complejo es la opción más segura — es más barato no usar `brain/` que crearlo tarde.

## Paso 2 — Estructura simple

```
<proyecto>/
├── SPEC.md
├── CLAUDE.md
├── README.md
├── .gitignore
├── .claudeignore
└── spec/
    ├── api.md
    ├── completado.md
    ├── historial.md
    ├── datos.md
    └── objetivos.md
```

Nota sobre `objetivos.md`: en el proyecto de referencia este archivo se llamaba `incidencias.md` porque el dominio era gestión de incidencias — el nombre debe adaptarse al dominio del proyecto nuevo (ej. `features.md`, `roadmap.md`, o el nombre que mejor describa el backlog vivo de ese proyecto específico). La función es siempre la misma: lo que el usuario necesita + lo que el agente sugiere, fusionado en un solo backlog.

Contenido inicial de cada archivo — ver `references/spec-md-template.md` y `references/spec-folder-templates.md` para las plantillas completas de cada uno.

## Paso 3 — Estructura completa (agrega brain/ desde el día 1)

Todo lo de Paso 2, más:

```
<proyecto>/
└── brain/
    ├── index.md            # SOLO catálogo de ADRs + puntero a sesiones.md — nunca resúmenes de sesión aquí
    ├── sesiones.md         # registro cronológico, entrada por sesión, más reciente arriba
    ├── TOASK.md            # preguntas/ideas tangenciales, categorizadas por audiencia
    ├── trackers/
    │   ├── bugs.md
    │   ├── bugs-report-template.md
    │   ├── features.md
    │   ├── features-proposal-template.md
    │   └── generated/
    └── files/
        ├── (raíz — lo que el usuario sube, público)
        ├── manual/         # lo que el agente crea/parsea para contexto, público
        └── secure/         # privado — nunca se commitea, nunca se lee en contexto
```

**Regla no negociable, aprendida de un caso real:** `brain/index.md` contiene únicamente la tabla de ADRs (ID, título, estado) y un puntero a `sesiones.md`. Nunca pegar el resumen de una sesión directamente en `index.md` — esa duplicación de responsabilidad ocurrió orgánicamente en un proyecto de referencia y terminó con ~30 secciones redundantes entre los dos archivos. `sesiones.md` es el único lugar para el detalle cronológico de cada sesión.

Ver `references/brain-adr-template.md` para la plantilla de un ADR individual, y `references/trackers-templates.md` para las plantillas de bug report y feature proposal.

## Paso 4 — Archivos ignore, siempre como par

`.gitignore` y `.claudeignore` no son intercambiables — responden preguntas distintas ("¿esto se versiona?" vs. "¿esto vale la pena que el agente lo lea?"). Generar ambos juntos en este paso, nunca uno sin el otro. Ver `references/ignore-files-templates.md`.

Si se creó `brain/files/secure/` en el Paso 3, ambos archivos ignore deben excluirlo explícitamente — es la única carpeta que requiere protección doble (nunca se commitea Y nunca se lee en contexto).

## Paso 5 — CLAUDE.md base

Independiente del tamaño elegido, todo proyecto nuevo lleva un `CLAUDE.md` con estas secciones mínimas (ver `references/claude-md-template.md` para el texto completo):

1. Mensaje de confirmación de contexto al iniciar sesión
2. Contexto breve del proyecto (2-3 líneas)
3. Stack tecnológico (tabla)
4. Regla(s) crítica(s) no negociable(s) — si las hay; puede quedar vacío al inicio y llenarse cuando aparezca la primera
5. Estrategia de testing por niveles
6. Modo de trabajo: secuencial por defecto, subagentes solo si hay independencia clara y beneficio evidente
7. Convención de documentación: qué actualizar y cuándo (inmediato post-breakthrough, no acumular para el cierre)

## Paso 6 — Confirmar antes de escribir

Antes de crear los archivos, mostrar al usuario el árbol de carpetas que se va a generar (Paso 2 o Paso 3 según lo elegido) y esperar confirmación explícita. No escribir archivos sin este paso — es la aplicación directa del principio de confirmación explícita entre pasos que gobierna todo el resto de la metodología.