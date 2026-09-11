# Primeros pasos

> **Bienvenido a Suplemento Estrella.**

Si llegaste hasta aquí, probablemente ya descubriste lo mismo que nosotros:

Programar con agentes de código no consiste solamente en escribir prompts.

Consiste en construir y mantener un contexto compartido.

Suplemento Estrella existe precisamente para eso.

---

# ¿Qué necesitas?

Suplemento Estrella es un harness multi-runtime — funciona con más de un agente de código. Elige tu runtime:

- **Claude Code** — runtime de referencia, con el historial más largo de uso real.
- **Google Gemini (Antigravity IDE)** — runtime adicional, ver `runtimes/gemini-antigravity/`.

Ver [Instalación](../README.md#instalación) en el README para el comando exacto de cada runtime.

---

# Instalación — Claude Code

Suplemento Estrella funciona de forma estrecha con Git/GitHub, por lo que necesitas un repo creado (vía navegador o `git init` local).

Instala el plugin de Claude Code para VS Code desde el Marketplace de VS Code si aún no lo tienes.

Luego instala Suplemento Estrella usando la terminal de Claude Code o la UI de chat:

```bash
/plugin marketplace add OrcaCl/suplemento-estrella
/plugin install suplemento-core@suplemento-estrella
```

Opcionalmente instala también **Claude Mem** (memoria operativa del agente) — ver `docs/plugins.md` para el detalle de cómo se complementan.

---

# Instalación — Google Gemini (Antigravity)

Ver el comando de instalación de una línea en el [README](../README.md#instalación).

---

# Crear un proyecto nuevo

Una vez instalado el runtime que corresponda, inicia un proyecto ejecutando la skill/comando **project-init**.

Durante la inicialización el agente irá haciendo preguntas para construir el contexto inicial del proyecto.

Dependiendo del tamaño esperado, preparará automáticamente una estructura simple o una estructura completa.

---

# Completar el contexto inicial

El objetivo no es comenzar escribiendo código.

El objetivo es que **el agente comprenda el proyecto antes de escribir la primera línea**.

Para ello se generan distintos documentos base, entre ellos:

```text
SPEC.md
CLAUDE.md (o GEMINI.md, según el runtime)
PLUGINS.md
TOASK.md
```

Y, cuando el proyecto lo requiere:

```text
brain/
```

No es necesario completar absolutamente todo el primer día.

El contexto crecerá junto con el proyecto.

---

# Comenzar una sesión

Antes de escribir código, acostúmbrate a sincronizar el contexto.

Una instrucción tan simple como esta suele ser suficiente:

> Lee el `SPEC.md` y el contenido de `brain/` para sincronizar el contexto del proyecto antes de comenzar.

Eso permite que el agente recuerde rápidamente:

- el estado actual del proyecto
- las decisiones tomadas anteriormente
- las reglas importantes
- los pendientes activos
- las prioridades de la siguiente sesión

---

# Durante el desarrollo

Suplemento Estrella favorece un desarrollo incremental. En general se recomienda:

- comprender el problema antes de implementar
- mantener el foco en una tarea a la vez
- documentar únicamente aquello que merece permanecer en el tiempo
- evitar sobreingeniería
- escribir código simple antes que código inteligente

Las herramientas existen para ayudar al proyecto. Nunca al revés.

Ver `docs/workflow.md` para el flujo de trabajo completo (inicializar → construir contexto → desarrollar → cerrar sesión).

---

# Un consejo

No intentes documentarlo todo.

Documenta aquello que agradecerás encontrar dentro de seis meses.

El resto puede volver a descubrirse.

El contexto importante no.

---

# Bienvenido

Suplemento Estrella no pretende enseñarte a programar.

Tampoco pretende decirte cuál framework utilizar.

Su objetivo es mucho más simple.

Ayudarte a construir proyectos donde el conocimiento sobreviva a las conversaciones, a las sesiones y al paso del tiempo.

Porque el mejor contexto no es el que está en la cabeza del desarrollador.

Es el que cualquier miembro del equipo —humano o agente— puede recuperar cuando realmente lo necesita.
