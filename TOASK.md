# Preguntas pendientes (TOASK) — suplemento-estrella

Categorías: **A** = Humano/decisión de producto · **D** = dependencia de terceros (plugins externos) · **S** = investigable internamente

## Pendientes

_Ninguna por ahora._

## Resueltas

- [x] ~~**S** — Resolver el solapamiento entre Superpowers (`writing-plans`, `subagent-driven-development`) y otros plugins de flujo de trabajo cuando ambos están instalados en el mismo proyecto.~~ → Se resolvió retirando Superpowers (2026-09-01): sus funciones de diseño, planificación y depuración pasaron a 3 skills propias de `suplemento-core` (`disenar-antes-de-implementar`, `planificacion-por-fases`, `depuracion-sistematica`), con ejecución secuencial por defecto y rutas de guardado integradas con `brain/`. Ya no hay dos plugins de flujo de trabajo que solapar. El runtime de Gemini trae las mismas skills traducidas a su formato.
- [x] ~~**S** — Evaluar si `code-simplicity` debería referenciar YAGNI de Superpowers en vez de mantener redacción propia paralela.~~ → Sin objeto: Superpowers ya no forma parte del ecosistema. `code-simplicity` mantiene su propia redacción (KISS/DRY/no sobreingeniería) y se quitó de la skill la sección que hablaba de Superpowers.
