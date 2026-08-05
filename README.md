# ⭐ Suplemento Estrella (Star Supplement)

**TL;DR:**

Suplemento Estrella es una Brújula con esteroides IA.

Permite orientar y definir **cómo colaboran un desarrollador humano y su Agente IA** durante todo el ciclo de vida de un proyecto: desde la planificación inicial hasta el cierre de cada sesión de trabajo. 

Tiene una metodología basada en mi experiencia personal, en estándares del desarrollo de software, base de conocimientos y un sistema de guía, tanto para el saco de carne y huesos, como para el super agente 86 de IA. En mi caso, Claude Code. 

**No es un framework. No es un boilerplate. No es una plantilla de proyecto.**

La implementación de referencia está pensada para **Claude Code**, pero la metodología es independiente del modelo de IA y puede adaptarse a otros agentes mediante forks o implementaciones específicas.


## Instalación

**No clones este repo directamente para usar el plugin.** (*) 

La forma correcta de instalarlo en un proyecto es:

```
/plugin marketplace add OrcaCl/suplemento-estrella
/plugin install suplemento-core@suplemento-estrella
```

Esto instala únicamente el contenido del plugin (`plugins/suplemento-core/`) y no el proyecto de desarrollo, su "brain" y todas las piezas que arman la estructura que crea el plugin.

El Plugin `Suplemento Estrella` está siendo mantenido por si mismo. Y puedes ver en sus tripas como está siendo usado para seguir desarrollándose. 

Si en cambio quieres explorar el código fuente sin instalarlo, usa `git clone` con sparse checkout apuntando solo a `plugins/suplemento-core/` — ver `docs/` para el detalle.

Cuando ya esté todo descargado, dile a Code que inicie el proyecto con 

```
project-init
```

Y sigue los pasos que te va a ir preguntando para que quede todo listo para darle con todo!

---

# ¿Qué problemas busca resolver?

Con el paso de las sesiones, gran parte del conocimiento de un proyecto deja de vivir en el código y pasa a vivir en la cabeza del desarrollador.

¿Por qué tomamos esta decisión? 
¿Qué probamos la semana pasada?
¿Qué quedó pendiente?
¿Qué riesgos descubrimos?
¿Qué ideas queremos implementar más adelante?

Cuando el contexto se pierde, el agente también lo pierde.

Suplemento Estrella busca que ese conocimiento permanezca disponible para ambos.

---

# Filosofía

Star Supplement reutiliza **metodología**, no proyectos.

Se extraen y generalizan prácticas reales de desarrollo, separando cuidadosamente:

✅ Lo que sí se reutiliza

* Metodologías de trabajo.
* Convenciones de documentación.
* Organización del proyecto.
* Patrones de arquitectura.
* Estrategias de testing.
* Buenas prácticas.
* Herramientas recomendadas.

❌ Lo que nunca se reutiliza

* Código de negocio.
* Información de clientes.
* Credenciales.
* Datos privados.
* Infraestructura específica.
* Configuraciones propietarias.

Si alguna parte de Star Supplement hace referencia a un proyecto específico, es un error y debe corregirse.

---

# Principio de Integración

Star Supplement propone herramientas, metodologías y convenciones, pero **siempre prioriza respetar los estándares, restricciones y decisiones del proyecto en el que se integra.**

El agente debe adaptarse al proyecto.

El proyecto no debe adaptarse al agente.

Los cambios estructurales sólo deben proponerse cuando exista una necesidad real y el desarrollador decida implementarlos.

---

# Ecosistema actual

Actualmente Star Supplement está diseñado para funcionar junto a Claude Code.

Se complementa especialmente con los siguientes plugins:

| Plugin              | Función                                                                                                               |
| ------------------- | --------------------------------------------------------------------------------------------------------------------- |
| **Superpowers**     | Planificación, estrategias de implementación, subagentes, trabajo paralelo, dry-run y apoyo al proceso de desarrollo. |
| **Claude Mem**      | Memoria operativa del agente para conocimiento interno que no necesita formar parte de la documentación compartida.   |
| **Star Supplement** | Metodología, documentación, estructura del proyecto y contexto compartido entre el desarrollador y el agente.         |

Star Supplement evita duplicar funcionalidades que ya resuelven correctamente otros plugins.

---

# Flujo de trabajo

## 1. Inicializar el proyecto

Instalar el plugin y ejecutar la inicialización del proyecto.

El agente irá guiando al desarrollador para completar la información inicial y generar la estructura documental correspondiente.

---

## 2. Construir el contexto

El contexto inicial del proyecto se registra principalmente en:

* `SPEC.md`
* `CLAUDE.md`
* `brain/` (cuando corresponda)

El objetivo es que el agente comprenda el proyecto antes de comenzar a escribir código.

**Pasos a seguir:**

Completar los textos que están dentro de las plantillas de contexto:

SPEC.md para la guía central del proyecto.
CLAUDE.md para las cosas que deban correr al iniciar una sesión
PLUGINS.md se llena solo pero si decides instalar algo nuevo, Code lo va a guardar acá y si clonas tu repo, sabrá qué tenias instalado en el otro endpoint.

Esto se hace solo una vez de forma manual o híbrida (le dices a Code que te guarde las cosas donde tienen que ir)
Y listo.

Después se irá llenando solo según las reglas ya preestablecidas.
(Revisa las plantillas por si quieres más detalles).



---

## 3. Desarrollar

Antes de comenzar una sesión dile a Code lo siguiente:

> Lee el `SPEC.md` y el `brain/` para iniciar este proyecto (En la primera sesión o "first run")
> Lee el `SPEC.md` y el `brain/` para continuar con este proyecto. (Desde la 2 en adelante) 

A partir de ese momento el desarrollo continúa normalmente.

**Checkpoints**

Durante el desarrollo, puedes pedirle a Code que haga un "checkpoint" para que genere una actualización de los hitos logrados a SPEC.md, a los otros sistemas de control y registro, commit y push. 
(Por si estás cerca a que se te acaben los tokens)

---

## 4. Cerrar la sesión

Antes de cerrar sesión, dile a Code lo siguiente:

> Code (o el nombre que hayas decidido ponerle), hagamos un **checkpoint** y cerremos sesión.

Lo que Code hará es: 

* actualizar `SPEC.md`
* registrar nuevos ADR, REF, NOC o DEP cuando corresponda
* actualizar `sesiones.md`
* limpiar `TOASK.md`
* mover tareas resueltas a `spec/completado.md`
* realizar `commit`
* realizar `push`

De esta forma cualquier sesión futura podrá continuar sin reconstruir el contexto desde cero.

---

# Brain

Brain es el sistema de memoria persistente del proyecto.

Su objetivo es conservar el conocimiento que normalmente sólo existe en la memoria del desarrollador.

No pretende reemplazar a Claude Mem. Ambos cumplen funciones distintas.

Mientras Claude Mem conserva conocimiento operativo del agente, Brain mantiene el contexto compartido del proyecto principalmente para el humano.
Sólo si Code olvida algo o se marea puedes decirle que revise index.md o sesiones.md de Brain para que comprenda las decisiones de arquitectura, diseño, seguridad o referencias en lenguaje humano como para recuperar su contexto sin gastar más tokens al tener que volver a "pensar".

Entre sus principales documentos se encuentran:

| Documento       | Propósito                                                       |
| --------------- | --------------------------------------------------------------- |
| **ADR**         | Decisiones permanentes de arquitectura.                         |
| **REF**         | Referencias técnicas vivas. (Manuales, documentación, SDKs, etc.|
| **NOC**         | Notas de cuidado, riesgos y observaciones.                      |
| **DEP**         | Registro histórico de elementos retirados o reemplazados.       |
| **sesiones.md** | Resumen de cada sesión de trabajo.                              |
| **TOASK.md**    | Preguntas pendientes clasificadas según quién debe resolverlas. |

En `TOASK.md` guardas todas esas ideas rándom que se te ocurren mientras estás desarrollando algo que pueden ser o no relevantes (o sobreingeniería) que anotas acá para poder revisar y resolver más adelante en el proyecto o cuando tengas un poco de tiempo para dedicarle. No son precisamente "features" pero podrían llegar a serlo o no. Acá se almacenan y se pueden consultar posteriormente.

---

# SPEC

`SPEC.md` es el panel de control del proyecto.

Resume el estado actual, las prioridades, las reglas críticas, las decisiones permanentes y el estado general del desarrollo.
Cuando el proyecto crece, la información se distribuye dentro de la carpeta `spec/`, manteniendo `SPEC.md` como índice principal.

**LONG**

Acá incorporé una recomendación del señor `Midudev` (aún no encuentro el link al video, apenas lo pille lo agrego), que sugería no dejar que `SPEC.md` tenga más de 1000 líneas de texto porque se empieza a marear con las directrices y dirección del proyecto. Por ende sugería que si SPEC.md crece demasiado, que mueva -no que borre- las decisiones importantes aprendidas durante el desarrollo dentro de los archivos específicos en una carpeta llamada spec/

La plantilla inicial de spec/ incluye api.md, datos.md, completado.md, objetivos.md, etc.

Code te preguntará si deseas dejar el archivo llamado "objetivos.md" o cambiarle el nombre a algo que represente mejor la tarea principal que desea lograr tu proyecto o que represente mejor sus objetivos. En el caso de este repo, cambié "objetivos.md" por "roadmap-skills.md".

---

# ¿Qué incluye?

Actualmente Star Supplement incorpora skills para:

* Inicialización de proyectos.
* SPEC Driven Development.
* Brain (Documentación continua).
* Testing (TDD).
* Desarrollo secuencial.
* Convenciones Frontend.
* Simplicidad de código (KISS, DRY y YAGNI).
* Organización del stack tecnológico.
* Auditoría de datos.
* Convenciones generales de desarrollo.

La metodología continúa evolucionando a medida que se utiliza en proyectos reales.

---

# Estado del proyecto

Star Supplement se encuentra en desarrollo activo.

La implementación oficial está orientada a Claude Code, aunque la metodología fue diseñada para poder adaptarse a otros agentes de código en el futuro.

Los forks y contribuciones son bienvenidos.

---

# Licencia

MIT

**Comparte metodología. No deuda técnica.**

