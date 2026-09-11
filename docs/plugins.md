# Ecosistema y qué incluye

## Ecosistema recomendado (Claude Code)

Suplemento Estrella nació pensado para Claude Code y se complementaba con los siguientes plugins:

| Plugin | Función |
|---|---|
| **suplemento-core** | Metodología, documentación, estructura del proyecto y contexto compartido entre el desarrollador y el agente. |
| Claude Mem | Memoria operativa del agente para conocimiento interno que no necesita formar parte de la documentación compartida. |
| Superpowers | *(Retirado, 2026-09-01)* Planificación, estrategias de implementación, subagentes y apoyo al proceso de desarrollo. |

**Estado actual:** Superpowers fue retirado — sus funciones de planificación, diseño colaborativo y depuración fueron reemplazadas por 3 skills propias del plugin (`disenar-antes-de-implementar`, `planificacion-por-fases`, `depuracion-sistematica`), con dos diferencias deliberadas: ejecución secuencial por defecto (sin ofrecer subagentes como recomendación) y rutas de guardado integradas con `brain/` (Brain KMS). Ver `CHANGELOG.md` (raíz) y `brain/` para el detalle de la decisión.

Suplemento Estrella evita duplicar funcionalidades que ya resuelven correctamente otros plugins.

---

## Multi-runtime

Desde v0.10.0, Suplemento Estrella dejó de ser exclusivo de Claude Code. Cada runtime adicional vive en `runtimes/` con su propia adaptación de la misma metodología — ver [Instalación](../README.md#instalación) en el README para el detalle de cada uno.

---

## ¿Qué incluye la metodología?

Suplemento Estrella incorpora skills para:

- Inicialización de proyectos.
- Spec-Driven Development.
- Brain KMS (documentación continua — ADR, INT, NOC, DEP, REF/REFX).
- Diseño antes de implementar (clasificar, entender, proponer, aprobar).
- Planificación por fases (plan de implementación con tareas del tamaño de un bocado).
- Depuración sistemática (causa raíz antes que fix).
- Testing (TDD quirúrgico).
- Desarrollo secuencial.
- Convenciones de frontend.
- Simplicidad de código (KISS, DRY y YAGNI).
- Organización del stack tecnológico.
- Auditoría de datos.
- Convenciones generales de desarrollo.

La metodología continúa evolucionando a medida que se utiliza en proyectos reales.
