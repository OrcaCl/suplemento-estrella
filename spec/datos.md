# Datos — convenciones y diccionarios

## Convenciones de nomenclatura

- Categorías de registro en `brain/`: `ADR-NNN` (decisiones de arquitectura), `INT-NNN` (decisiones sobre cómo el humano y Code trabajan juntos), `NOC-NNN` (notas de cuidado / riesgo mixto), `DEP-NNN` (retiro de herramienta o patrón), `REF-NNN` y `REFX-NNN` (material de referencia propio o de otro proyecto).
- Numeración secuencial por categoría, nunca se reutiliza un número aunque el registro se marque como obsoleto.
- Versionado de plugin: hash de commit git (ej. `c3e815f6555c`), no versión fija en `plugin.json` — habilita seguimiento en vivo del repo durante el desarrollo.

## Diccionario de términos del dominio

| Término | Significado |
|---|---|
| `brain/` | Sistema de memoria persistente compartida entre desarrollador y agente — decisiones, riesgos, referencias |
| `SPEC.md` | Panel de control corto y vivo del proyecto |
| Uso meta | Cuando este mismo repo (constructor del plugin) usa su propia metodología para documentarse a sí mismo |
| Checkpoint | Registro diferido en `brain/`/`SPEC.md`, invocado explícitamente por el humano — no automático |

## Anexos

Ver `docs/brain.md` y `docs/getting-started.md` para la documentación conceptual completa de la metodología, dirigida a quien instala y usa Suplemento Estrella en otros proyectos.
