# ⭐ Star Supplement

**TL;DR:**

Suplemento Estrella es una Brújula con esteroides IA.

La creé para orientar el desarrollo entre un desarrollador humano y su Agente IA. Tiene una metodología, base de conocimientos y un sistema de guía, tanto para el saco de carne y huesos, como para el superagente de IA. En mi caso, Claude Code.

> **Una metodología, base de conocimiento y punto de partida para desarrolladores y agentes de código.**

Star Supplement es una metodología para desarrollar software junto a agentes de código.

No es un framework. No es un boilerplate. No es una plantilla de proyecto.

Su objetivo es definir **cómo colaboran un desarrollador y un agente de código** durante todo el ciclo de vida de un proyecto: desde la planificación inicial hasta el cierre de cada sesión de trabajo.

La implementación de referencia está pensada para **Claude Code**, pero la metodología es independiente del modelo de IA y puede adaptarse a otros agentes mediante forks o implementaciones específicas.


## Instalación

**No clones este repo directamente para usar el plugin.** La forma correcta de instalarlo en un proyecto es:

```
/plugin marketplace add OrcaCl/suplemento-estrella
/plugin install suplemento-core@suplemento-estrella
```

Esto instala únicamente el contenido del plugin (`plugins/suplemento-core/`) — no trae `docs/`, `.old/`, ni el resto del andamiaje de construcción del propio repo.

Si en cambio quieres explorar el código fuente sin instalarlo, usa `git clone` con sparse checkout apuntando solo a `plugins/suplemento-core/` — ver `docs/` para el detalle.

---

# ¿Qué problemas busca resolver?

Con el paso de las sesiones, gran parte del conocimiento de un proyecto deja de vivir en el código y pasa a vivir en la cabeza del desarrollador.

¿Por qué tomamos esta decisión?

¿Qué probamos la semana pasada?

¿Qué quedó pendiente?

¿Qué riesgos descubrimos?

¿Qué ideas queremos implementar más adelante?

Cuando el contexto se pierde, el agente también lo pierde.

Star Supplement busca que ese conocimiento permanezca disponible para ambos.

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

Dependiendo del tamaño esperado del proyecto, podrá crear una estructura simple o una estructura completa.

---

## 2. Construir el contexto

El contexto inicial del proyecto se registra principalmente en:

* `SPEC.md`
* `CLAUDE.md`
* `PLUGINS.md`
* `brain/` (cuando corresponda)

El objetivo es que el agente comprenda el proyecto antes de comenzar a escribir código.

---

## 3. Desarrollar

Antes de comenzar una sesión suele bastar con una instrucción como:

> Lee el `SPEC.md` y el `brain/` para sincronizar el contexto del proyecto.

A partir de ese momento el desarrollo continúa normalmente.

---

## 4. Cerrar la sesión

Antes de finalizar se recomienda:

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

No pretende reemplazar a Claude Mem.

Ambos cumplen funciones distintas.

Mientras Claude Mem conserva conocimiento operativo del agente, Brain mantiene el contexto compartido del proyecto.

Entre sus principales documentos se encuentran:

| Documento       | Propósito                                                       |
| --------------- | --------------------------------------------------------------- |
| **ADR**         | Decisiones permanentes de arquitectura.                         |
| **REF**         | Referencias técnicas vivas.                                     |
| **NOC**         | Notas de cuidado, riesgos y observaciones.                      |
| **DEP**         | Registro histórico de elementos retirados o reemplazados.       |
| **sesiones.md** | Resumen de cada sesión de trabajo.                              |
| **TOASK.md**    | Preguntas pendientes clasificadas según quién debe resolverlas. |

---

# SPEC

`SPEC.md` es el panel de control del proyecto.

Resume el estado actual, las prioridades, las reglas críticas, las decisiones permanentes y el estado general del desarrollo.

Cuando el proyecto crece, la información se distribuye dentro de la carpeta `spec/`, manteniendo `SPEC.md` como índice principal.

---

# ¿Qué incluye?

Actualmente Star Supplement incorpora skills para:

* Inicialización de proyectos.
* SPEC Driven Development.
* Brain.
* Documentación continua.
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

