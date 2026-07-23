# Suplemento Estrella v0.2

Marketplace de Claude Code con la metodología, convenciones y personalidad de agente de Suplemento Estrella — punto de partida para proyectos nuevos, en vez de reconstruir desde cero cada vez.

No es una plantilla de código (no trae modelos, endpoints, ni lógica de negocio de ningún proyecto específico). Es metodología: cómo se documenta, cómo se decide, cómo se prueba, y qué convenciones de código se siguen — extraído y generalizado a partir de proyectos reales de Suplemento Estrella (`--redacted--`, `--redacted--`).

## Instalación

Dentro de una sesión de Claude Code, en cualquier proyecto:

```
/plugin marketplace add OrcaCl/suplemento-estrella
/plugin install Suplemento Estrella-core@suplemento-estrella
```

Esto instala las skills del plugin `Suplemento Estrella-core`, que se activan automáticamente según el contexto de la tarea — no hace falta invocarlas por nombre.

## Qué incluye — plugin `Suplemento Estrella-core`

| Skill | Cuándo se activa |
|---|---|
| `project-init` | Al inicializar un proyecto nuevo — pregunta el tamaño esperado y crea la estructura de documentación correspondiente |
| `spec-driven-development` | Trabajo diario con `SPEC.md` + `spec/` como fuente de verdad |
| `brain-adr` | Decisiones de arquitectura, sistema de ADR, para proyectos con estructura completa |
| `sequential-mode` | Modo de trabajo por defecto — secuencial, sin subagentes salvo independencia clara y beneficio evidente |
| `documentation-convention` | Registro inmediato post-breakthrough, mantenimiento de `PLUGINS.md` |
| `raw-data-audit-trail` | Auditoría de datos importados de fuentes externas — captura + exposición controlada |
| `tdd-workflow` | TDD estricto (rojo antes que verde) + estrategia de testing por niveles |
| `frontend-conventions` | CSS/JS atómico, BEM, y el puente `data-*` entre templates server-side y JavaScript |
| `tooling-roles` | Mapeo de roles funcionales de herramientas (gestor de paquetes, ORM, testing, etc.) a stacks distintos de Python |
| `code-simplicity` | KISS, DRY, y evitar sobreingeniería salvo que sea inevitable |

## Filosofía

Metodología, no contenido. Cada skill fue extraída deliberadamente separando:
- **Lo que sí se lleva:** estructura de decisión, convenciones de nomenclatura, reglas de proceso, patrones de arquitectura genéricos
- **Lo que NO se lleva:** nombres de tablas, tipos de incidencia, IPs, credenciales, cualquier detalle específico de un proyecto o cliente

Si en algún momento una skill de este starter menciona algo que suena a un proyecto específico, es un error — repórtalo para corregirlo.

## Estado

Versión `0.1.0` — primera iteración. Pendientes conocidos, ver `TOASK.md`:
- Resolver el solapamiento entre Superpowers (`writing-plans`, `subagent-driven-development`) y otros plugins de flujo de trabajo que pudieran instalarse en paralelo — decisión diferida hasta tener más evidencia de uso real.
- Evaluar si `code-simplicity` debería referenciar directamente YAGNI de Superpowers en vez de mantener redacción propia paralela, cuando ambos plugins están activos en el mismo proyecto.

## Estructura del repo

```
suplemento-estrella/
├── .claude-plugin/
│   └── marketplace.json
├── plugins/
│   └── Suplemento Estrella-core/
│       ├── .claude-plugin/
│       │   └── plugin.json
│       └── skills/
│           ├── project-init/
│           │   ├── SKILL.md
│           │   └── references/
│           ├── spec-driven-development/
│           ├── brain-adr/
│           ├── sequential-mode/
│           ├── documentation-convention/
│           ├── raw-data-audit-trail/
│           ├── tdd-workflow/
│           ├── frontend-conventions/
│           ├── tooling-roles/
│           └── code-simplicity/
├── TOASK.md
└── README.md
```

## Origen

Metodología extraída y generalizada a partir del trabajo real de [OrcaCl](https://github.com/OrcaCl).
