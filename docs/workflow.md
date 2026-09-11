# Flujo de trabajo

## 1. Inicializar el proyecto

Instalar el runtime correspondiente (ver [Instalación](../README.md#instalación)) y ejecutar la inicialización del proyecto.

El agente irá guiando al desarrollador para completar la información inicial y generar la estructura documental correspondiente.

---

## 2. Construir el contexto

El contexto inicial del proyecto se registra principalmente en:

- `SPEC.md`
- `CLAUDE.md` (Claude Code) / `GEMINI.md` (Gemini)
- `brain/` — Brain KMS (cuando corresponda)

El objetivo es que el agente comprenda el proyecto antes de comenzar a escribir código.

**Pasos a seguir:**

Completar los textos que están dentro de las plantillas de contexto:

- `SPEC.md` para la guía central del proyecto.
- `CLAUDE.md` / `GEMINI.md` para las reglas que deban aplicarse al iniciar una sesión.
- `PLUGINS.md` se llena solo — si decides instalar algo nuevo, el agente lo va a guardar ahí y si clonas tu repo en otro equipo, sabrá qué tenías instalado.

Esto se hace solo una vez, de forma manual o híbrida (le dices al agente que te guarde las cosas donde corresponde). Después se va llenando solo según las reglas ya preestablecidas (revisa las plantillas por más detalles).

---

## 3. Desarrollar

Antes de comenzar una sesión, dile al agente:

> Lee el `SPEC.md` y el `brain/` para iniciar este proyecto (primera sesión o "first run").
> Lee el `SPEC.md` y el `brain/` para continuar con este proyecto (desde la sesión 2 en adelante).

A partir de ese momento el desarrollo continúa normalmente.

### Checkpoints

Durante el desarrollo puedes pedirle al agente que haga un **checkpoint** para que genere una actualización de los hitos logrados a `SPEC.md`, a los otros sistemas de control y registro, commit y push — útil si estás cerca de quedarte sin tokens.

---

## 4. Cerrar la sesión

Antes de cerrar sesión, dile al agente:

> [nombre que le hayas puesto], hagamos un **checkpoint** y cerremos sesión.

El agente hará lo siguiente:

- actualizar `SPEC.md`
- registrar nuevos ADR, INT, NOC, DEP o REF/REFX cuando corresponda
- actualizar `sesiones.md`
- limpiar `TOASK.md`
- mover tareas resueltas a `spec/completado.md`
- realizar `commit`
- realizar `push`

De esta forma cualquier sesión futura podrá continuar sin reconstruir el contexto desde cero.
