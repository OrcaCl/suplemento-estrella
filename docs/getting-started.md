# Primeros pasos

> **Bienvenido a Star Supplement.**

Si llegaste hasta aquí, probablemente ya descubriste lo mismo que nosotros:

Programar con agentes de código no consiste solamente en escribir prompts.

Consiste en construir y mantener un contexto compartido.

Star Supplement existe precisamente para eso.

---

# ¿Qué necesitas?

Actualmente la implementación oficial está diseñada para **Claude Code**.

Se recomienda trabajar con el siguiente ecosistema:

* Claude Code
* Superpowers
* Claude Mem
* Star Supplement

La metodología puede adaptarse a otros agentes de código, pero hoy la experiencia de referencia está construida sobre Claude Code.

---

# Instalación

Dentro de cualquier proyecto nuevo:

```bash
/plugin marketplace add OrcaCl/star-supplement
/plugin install star-supplement
```

Luego instala (o verifica) los plugins recomendados.

* Superpowers
* Claude Mem

Star Supplement intenta complementar estas herramientas, no reemplazarlas.

---

# Crear un proyecto nuevo

Una vez instalado el plugin, inicia un proyecto utilizando la skill **project-init**.

Durante la inicialización el agente irá haciendo preguntas para construir el contexto inicial del proyecto.

Dependiendo del tamaño esperado, preparará automáticamente una estructura simple o una estructura completa.

---

# Completar el contexto inicial

El objetivo no es comenzar escribiendo código.

El objetivo es que **el agente comprenda el proyecto antes de escribir la primera línea**.

Para ello se generan distintos documentos base, entre ellos:

```text
SPEC.md
CLAUDE.md
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

* el estado actual del proyecto
* las decisiones tomadas anteriormente
* las reglas importantes
* los pendientes activos
* las prioridades de la siguiente sesión

---

# Durante el desarrollo

Star Supplement favorece un desarrollo incremental.

En general se recomienda:

* comprender el problema antes de implementar
* mantener el foco en una tarea a la vez
* documentar únicamente aquello que merece permanecer en el tiempo
* evitar sobreingeniería
* escribir código simple antes que código inteligente

Las herramientas existen para ayudar al proyecto.

Nunca al revés.

---

# Cerrar una sesión

Una sesión no termina cuando el código funciona.

Termina cuando el contexto queda preparado para retomarlo mañana.

Antes de cerrar se recomienda:

* actualizar `SPEC.md`
* registrar nuevos ADR, REF, NOC o DEP cuando corresponda
* actualizar `sesiones.md`
* revisar `TOASK.md`
* mover preguntas resueltas a `spec/completado.md`
* realizar `commit`
* realizar `push`

Una buena sesión deja el proyecto listo para continuar aunque mañana:

* se acaben los tokens,
* cambie el modelo,
* falle internet,
* se corte la luz,
* o simplemente ninguno de los dos recuerde exactamente qué estaba haciendo.

---

# Un consejo

No intentes documentarlo todo.

Documenta aquello que agradecerás encontrar dentro de seis meses.

El resto puede volver a descubrirse.

El contexto importante no.

---

# Bienvenido

Star Supplement no pretende enseñarte a programar.

Tampoco pretende decirte cuál framework utilizar.

Su objetivo es mucho más simple.

Ayudarte a construir proyectos donde el conocimiento sobreviva a las conversaciones, a las sesiones y al paso del tiempo.

Porque el mejor contexto no es el que está en la cabeza del desarrollador.

Es el que cualquier miembro del equipo —humano o agente— puede recuperar cuando realmente lo necesita.

