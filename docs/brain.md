# Brain

> *La memoria compartida entre el desarrollador y su agente de código.*

---

## ¿Qué es Brain?

Brain es el sistema de memoria persistente de Star Supplement.

Su objetivo es preservar el contexto que normalmente sólo existe en la cabeza del desarrollador: decisiones, descubrimientos, riesgos, referencias técnicas, documentación auxiliar y el historial del proyecto.

No intenta reemplazar la memoria del agente de código.

Tampoco pretende documentar absolutamente todo.

Su propósito es permitir que tanto el desarrollador como el agente puedan reconstruir rápidamente el contexto del proyecto después de un cambio de sesión, agotamiento de tokens o incluso varios días sin trabajar en él.

En otras palabras:

> **Brain busca que el agente pueda pensar el proyecto como lo haría su desarrollador.**

---

# Filosofía

Brain documenta **conocimiento**, no conversaciones.

No busca registrar cada mensaje intercambiado con el agente.

Sólo conserva aquello que probablemente seguirá siendo útil dentro de una semana, un mes o incluso varios meses después.

Si una decisión sigue siendo importante mañana, probablemente merece vivir en Brain.

Si sólo fue parte del razonamiento para llegar a esa decisión, probablemente no.

---

# Brain y Claude Mem

Aunque ambos almacenan información, cumplen funciones distintas.

| Brain                                                                                 | Claude Mem                                                       |
| ------------------------------------------------------------------------------------- | ---------------------------------------------------------------- |
| Memoria compartida entre humano y agente.                                             | Memoria operativa del agente.                                    |
| Vive dentro del proyecto.                                                             | Vive dentro del agente.                                          |
| Documenta decisiones, contexto y conocimiento relevante para cualquier desarrollador. | Guarda detalles internos que ayudan al agente a programar mejor. |
| Forma parte del repositorio.                                                          | No necesariamente forma parte del repositorio.                   |

Una regla práctica:

> **Si una persona nueva que se incorpora al proyecto necesita conocer esa información, pertenece a Brain. Si sólo ayuda al agente a programar mejor, pertenece a Claude Mem.**

---

# Estructura

```text
brain/
├── files/
│   ├── manual/
│   └── secure/
│
├── trackers/
│   ├── generated/
│   ├── bugs.md
│   ├── bugs-report-template.md
│   ├── features.md
│   └── features-proposal-template.md
│
├── ADR-000.md
├── REF-000.md
├── NOC-000.md
├── DEP-000.md
│
├── index.md
├── sesiones.md
└── TOASK.md
```

Cada proyecto puede adaptar esta estructura según sus necesidades.

No todos los proyectos necesitarán todos los documentos desde el primer día.

---

# Carpeta files/

Contiene documentación de apoyo que el agente puede consultar libremente durante el desarrollo.

Por ejemplo:

* manuales
* PDFs
* archivos Markdown
* hojas de cálculo
* documentación técnica
* notas
* especificaciones
* cualquier otro material útil para comprender el proyecto

Su contenido puede evolucionar libremente durante el desarrollo.

---

## files/manual/

Aquí se almacenan documentos generados durante el propio desarrollo del proyecto que siguen siendo útiles, pero que ya no necesitan permanecer dentro del contexto inmediato del agente.

Por ejemplo:

* análisis extensos
* reportes
* resultados de investigaciones
* documentación técnica generada por el propio agente
* salidas de terminal que posteriormente fueron resumidas

En lugar de volver a consumir cientos de líneas de contexto, el agente puede consultar estos documentos cuando realmente los necesite.

---

## files/secure/

Contiene información sensible necesaria para desarrollar el proyecto pero que nunca debería distribuirse junto al repositorio público.

Por ejemplo:

* manuales propietarios
* documentación privada
* respaldos
* archivos internos
* información entregada bajo NDA

Cada proyecto define qué información corresponde mantener aquí.

---

# Documentos principales

## ADR — Architecture Decision Records

Los ADR registran decisiones de arquitectura que permanecerán en el tiempo.

Una vez publicados, normalmente no se modifican.

Si una decisión cambia, se genera un nuevo ADR explicando la evolución de la decisión anterior.

Star Supplement utiliza como referencia el formato clásico de Architecture Decision Records, adaptándolo al flujo de trabajo del proyecto.

---

## REF — Referencias

Los REF son documentos vivos de consulta.

No representan decisiones.

Tampoco registran riesgos.

Simplemente concentran información técnica que conviene mantener reunida en un solo lugar.

A diferencia de los ADR, los REF evolucionan continuamente.

Ejemplos:

* estructura de APIs
* catálogos
* diccionarios de datos
* convenciones
* tablas de referencia

---

## NOC — Notas de Cuidado

Los NOC documentan riesgos, advertencias o situaciones que merecen permanecer visibles durante el desarrollo.

No son decisiones arquitectónicas.

Tampoco son incidentes.

Son observaciones que ayudan a evitar errores futuros.

Por ejemplo:

* limitaciones conocidas
* riesgos de escalabilidad
* dependencias delicadas
* comportamientos inesperados
* recomendaciones importantes

---

## DEP — Deprecated

Los DEP registran documentos, procesos o convenciones que dejaron de utilizarse.

Su objetivo no es conservar código obsoleto.

Su objetivo es explicar **por qué** dejaron de utilizarse.

Muchas veces conocer la razón de una decisión antigua evita volver a cometer el mismo error algunos meses después.

---

# sesiones.md

Cada sesión de desarrollo deja un pequeño registro.

No pretende ser un diario.

Sólo conserva un resumen de:

* qué se hizo
* qué se descubrió
* qué decisiones aparecieron
* qué quedó pendiente

No todas las sesiones generan un ADR, un REF o un NOC.

Pero todas deberían dejar al menos un pequeño resumen en `sesiones.md`.

Esto permite recuperar rápidamente el contexto después de:

* agotar los tokens
* cambiar de modelo
* perder la conversación
* varios días sin trabajar
* cortes de internet
* apagones
* o simplemente porque el perro se comió la tarea.

---

# TOASK.md

TOASK concentra las preguntas pendientes del proyecto.

No es un backlog.

No es una lista de ideas.

Es una lista de preguntas que todavía necesitan una respuesta.

Cada pregunta se clasifica según quién debe resolverla.

| Código | Responsable                             |
| ------ | --------------------------------------- |
| **A**  | Humano, cliente o decisión de producto. |
| **D**  | Proveedor o servicio externo.           |
| **S**  | Investigable por el agente.             |

Las preguntas de tipo **S** representan tareas que el agente puede investigar por sí mismo...

...**cuando el desarrollador le diga que tiene tiempo para gastar en esa wea y no perder el foco de lo que están haciendo ahora.**

Porque no toda pregunta merece consumir tiempo, contexto o tokens inmediatamente.

Una vez resueltas, las preguntas dejan de vivir en TOASK.

Su respuesta consolidada pasa a `spec/completado.md`, mientras TOASK vuelve a representar únicamente el estado actual del proyecto.

---

# Features

Las ideas de mejora no pertenecen a TOASK.

Para eso existe `features.md`.

La diferencia es simple.

**TOASK responde:**

> Necesito una respuesta.

**Features responde:**

> Tengo una idea.

Las features representan desarrollo proactivo.

Son funcionalidades, mejoras o automatizaciones que todavía nadie ha solicitado explícitamente, pero cuya utilidad resulta evidente por experiencia.

No bloquean el desarrollo actual.

Simplemente esperan el momento adecuado.

---

# Principios

Brain intenta mantenerse pequeño, útil y fácil de consultar.

Documenta conocimiento.

No conversaciones.

Documenta decisiones.

No opiniones pasajeras.

Y siempre persigue el mismo objetivo:

> **Que cualquier desarrollador —humano o agente— pueda retomar el proyecto comprendiendo rápidamente por qué las cosas son como son, sin tener que reconstruir semanas de contexto desde cero.**

