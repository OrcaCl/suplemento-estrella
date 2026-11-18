# ADR-002 — CHANGELOG.md único en la raíz, versionado por capa preservado

**Estado:** Vigente
**Fecha:** 2026-09-11

## Contexto

Desde el relanzamiento como Suplemento Estrella (2026-08-04), `CHANGELOG.md` vivía en `plugins/suplemento-core/`, no en la raíz del repo — decisión registrada solo como fila suelta en `SPEC.md` §5 ("el versionado real es del plugin distribuido, no del repo constructor"), sin ADR propio.

Con el harness pasando a multi-runtime (ver ADR-001), esa ubicación dejó de alcanzar: un changelog dentro de `plugins/suplemento-core/` documenta solo el runtime de Claude Code, y el runtime de Gemini (`runtimes/gemini-antigravity/`) no tenía changelog propio.

El usuario consultó a Gemini sobre cómo estructurar el changelog en un escenario multi-runtime. La recomendación de Gemini fue: un único `CHANGELOG.md` en la raíz, con entradas por sección etiquetadas por runtime/componente (`[Runtime: Gemini]`, `[Runtime: Code]`, `[Core]`), respaldado por Conventional Commits con scope (`feat(runtime-gemini): ...`). Esa parte del consejo es independiente del esquema de versionado y se adopta.

Gemini también asumía **SemVer unificado / lockstep** — una sola versión de proyecto compartida entre Core y todos los runtimes ("de v1.x a v2.0.0 por el gran hito de incorporar Gemini"), y volvía a usar `2.0.0` como ejemplo. Eso **contradice** la decisión de ADR-001 (mismo día, sesión anterior): versionado independiente por capa (Core / Claude Code / Gemini), cada uno con su propio número, con `core_version` de referencia cruzada. Se evaluó explícitamente si adoptar el lockstep de Gemini y **se descartó** — ver Decisión.

**Opciones evaluadas:**
1. CHANGELOG único en la raíz + versionado independiente por capa (mantener ADR-001 sin cambios, solo centralizar dónde se escribe el registro).
2. CHANGELOG único en la raíz + versionado lockstep (adoptar la propuesta de Gemini completa, lo que revierte parte de ADR-001).
3. Mantener changelogs separados por runtime (statu quo con un changelog nuevo en Gemini) — descartada de plano por Gemini y por el usuario: duplica entradas, se desincroniza, fácil de olvidar actualizar uno de los dos.

## Decisión

1. **Se consolida un único `CHANGELOG.md` en la raíz del repo**, reemplazando a `plugins/suplemento-core/CHANGELOG.md` (eliminado). Formato Keep a Changelog, con secciones `Added`/`Changed`/etc. y cada entrada etiquetada por capa afectada (`[Core]`, `[Runtime Claude Code]`, `[Runtime Gemini]`).
2. **Se preserva el versionado independiente por capa de ADR-001** — se descarta la parte lockstep del consejo de Gemini. Cada entrada del changelog cita explícitamente la versión de SU capa (ej. `[Runtime Claude Code v0.10.0]`, `[Runtime Gemini v0.1.0]`) en vez de asumir un número de versión compartido para todo el proyecto.
3. Se adopta la convención de **Conventional Commits con scope por runtime** sugerida por Gemini (`feat(runtime-gemini): ...`, `fix(core): ...`) como práctica recomendada para commits futuros — no retroactiva sobre historial ya commiteado.
4. La fila de `SPEC.md` §5 "`CHANGELOG.md` vive en `plugins/suplemento-core/`" queda **obsoleta y reemplazada** por este ADR.

## Razones

1. Un changelog por runtime replica exactamente el problema que motivó abandonar el versionado por hash de commit: información dispersa, fácil de desincronizar u olvidar — el propio Gemini lo señaló y coincide con la experiencia ya vivida en este proyecto.
2. El versionado lockstep resuelve el problema de "¿qué versión tiene el proyecto?" a costa de un problema peor para este harness en concreto: fuerza a subir la versión de Gemini cada vez que cambia algo solo de Claude Code (o viceversa), cuando ambos runtimes hoy tienen niveles de completitud muy distintos (Claude Code con historial real, Gemini recién lanzado). ADR-001 ya evaluó y descartó esto explícitamente horas antes — repetir esa discusión no cambia el resultado, así que se mantiene.
3. Centralizar el archivo no exige lockstep — son decisiones independientes. Etiquetar cada entrada por capa y citar su propia versión da la misma "visibilidad holística" que pedía Gemini sin sacrificar la independencia de versionado.
4. Conventional Commits con scope por runtime es una práctica de bajo costo y alto valor para que ambos agentes (Code y Gemini) sepan qué tocaron sin ambigüedad — se adopta sin reservas.

## Consecuencias

- `CHANGELOG.md` (raíz, nuevo) — changelog único, con el historial migrado desde `plugins/suplemento-core/CHANGELOG.md` más la entrada de hoy reestructurada por capas.
- `plugins/suplemento-core/CHANGELOG.md` — eliminado (`git rm`).
- `SPEC.md` §5 — la fila sobre ubicación del changelog se actualiza para reflejar la nueva ubicación y referenciar este ADR.
- `SPEC.md` §1 (tabla "Qué entrega") — agregar `CHANGELOG.md` como fuente de la raíz.
- Futuros commits: adoptar prefijo de scope por runtime cuando aplique (`feat(runtime-gemini)`, `fix(core)`, etc.) — sin reescribir commits pasados.
- No cambia el versionado independiente por capa de ADR-001 — este ADR lo confirma y lo hace explícito otra vez, no lo reemplaza.

## Commit

Ver entrada "Sesión — 2026-09-11 (continuación) — CHANGELOG.md único en la raíz" en `brain/sesiones.md`.
