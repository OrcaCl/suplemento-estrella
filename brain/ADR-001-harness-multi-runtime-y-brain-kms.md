# ADR-001 — Metodología multi-runtime (v0.10.0) y rebautizo de brain/ como Brain KMS

**Estado:** Vigente
**Fecha:** 2026-09-11

## Contexto

Hasta la sesión anterior, Suplemento Estrella era una metodología (harness de desarrollo asistido por agentes de código) pensada exclusivamente para Claude Code: un único plugin (`plugins/suplemento-core/`) instalable vía `marketplace.json`, sin versión fija (versionado por hash de commit).

El autor empezó a trabajar, en sesiones anteriores, la conversión de las 13 skills del plugin al formato que espera Google Gemini (Antigravity), guiado por las indicaciones del propio modelo Gemini sobre dónde debía vivir su adaptación. El resultado quedó en `runtimes/gemini-antigravity/`, completo: 13 skills traducidas, templates propios, `GEMINI.md` y `.geminirules`.

En paralelo, el sistema `brain/` dejó de ser solo un registro de decisiones de arquitectura (ADR) hace tiempo — ya cubre INT (proceso de trabajo), NOC (riesgo mixto), DEP (retiros) y REF/REFX (referencias). Gemini sugirió el nombre **"Brain KMS: Brain Knowledge Management System"** para nombrar formalmente lo que el sistema ya es en la práctica. El autor evaluó la sugerencia como acertada "a medias" respecto al espíritu de la herramienta, pero suficiente para adoptarla como nombre definitivo.

Ambos cambios (multi-runtime + rebautizo) se identificaron y decidieron el mismo día, como parte de la misma evolución del harness.

**Sobre el salto de versión:** el uso de semver es una práctica que el autor adoptó recién ~1.5 semanas antes de esta sesión — no viene del origen del proyecto (que versionaba por hash de commit git). Gemini sugirió subir versión mayor (1.x o 2.x) para reflejar el paso de single-agent a multi-agent, pero el autor consideró que un salto directo a `2.0.0` exagera la madurez actual del harness — quedan pendientes de pulir (ver hallazgo sobre `docs/` incompleta, más abajo) y no hubo una serie previa de versiones 0.x/1.x reales que justifiquen cruzar a mayor=2. Se optó por `0.10.0`: refleja que el proyecto sigue en pre-1.0/desarrollo activo, dejando espacio para versionar los hitos intermedios que faltaron entre el origen del proyecto y hoy (por ejemplo, el ajuste de reglas del harness por el cambio de Claude Code a v5, ocurrido ~2 semanas antes de esta sesión, que no quedó registrado con número de versión en su momento).

**Causa raíz del ajuste por Claude Code v5 (contexto recuperado en esta sesión):** al retirar Superpowers y crear las 3 skills propias de reemplazo (`disenar-antes-de-implementar`, `planificacion-por-fases`, `depuracion-sistematica` — ver `CHANGELOG.md` 2026-09-01), el autor detectó que tanto Superpowers como `claude-mem` generaban "verborrea" excesiva — consumo de tokens disparado en pocas horas. La causa: el modelo v5 de Claude cambió el patrón de trabajo esperado — en vez de recibir una secuencia de tareas pequeñas para ensamblar un trabajo grande, espera el contexto completo de la tarea de una vez, para resolverla de punta a punta sin necesidad de supervisar el camino paso a paso. Ese cambio de patrón llevó a que `claude-mem` inyectara automáticamente "todo el contexto del universo" disponible — incluyendo el `SPEC.md` completo — en cada sesión, multiplicando el consumo de tokens. Este hallazgo no se resuelve en esta sesión (no hay acción tomada todavía, más allá del retiro de Superpowers ya registrado); queda como antecedente de por qué el harness ajustó reglas por esas fechas sin versión propia registrada en su momento.

**Hallazgo adicional, registrado pero no resuelto en esta sesión:** `docs/` tiene 10 archivos, de los cuales 8 están vacíos (`workflow.md`, `principles.md`, `philosophy.md`, `plugins.md`, `decisions.md`, `conventions.md`, `spec.md`, `glossary.md`). Solo `getting-started.md` y `brain.md` tienen contenido. El autor indica que quedaron a medias de una sesión de chat con otra instancia de Claude que no llegó a pasarse en limpio a este repo. No se reconstruye el contenido en esta sesión por no tener ese material disponible.

**Opciones evaluadas para la ubicación del runtime de Claude Code**, al formalizar la convención de `runtimes/`:
1. Dejar `plugins/suplemento-core/` donde está; `runtimes/` solo para otros agentes.
2. Mover también Claude Code a `runtimes/claude-code/`, por simetría estructural con los demás runtimes.

**Opciones evaluadas para versionar Core vs. cada runtime:**
1. Un número de versión por capa (Core/repo raíz, Claude Code, Gemini), cada uno independiente, con referencia cruzada de qué versión de Core implementa cada runtime.
2. Versionado sincronizado (lockstep) — un solo número para todo.

## Decisión

1. **Suplemento Estrella pasa a ser un harness multi-runtime desde v0.10.0.** Claude Code sigue siendo el runtime de referencia y su plugin permanece en `plugins/suplemento-core/` sin cambios de ubicación — se descartó moverlo a `runtimes/claude-code/` porque `marketplace.json` y la instalación activa del autor dependen de esa ruta, y el cambio no aportaba valor proporcional al riesgo de romper la instalación en medio de la migración.
2. **`runtimes/` queda reservada para adaptaciones a otros agentes** — Google Gemini (`gemini-antigravity/`) es la primera, y la carpeta queda abierta a futuros agentes adicionales.
3. **El sistema `brain/` se rebautiza formalmente como Brain KMS (Brain Knowledge Management System)**, reconociendo que ya cubre más categorías que solo ADR. El nombre se adoptó primero en el runtime de Gemini (`01-brain-kms.md`); la skill `brain-adr` de Claude Code **no se renombra en esta sesión** — queda como pendiente explícito en `SPEC.md`.
4. **`plugin.json` de `suplemento-core` fija versión semver (`0.10.0`) por primera vez**, dejando atrás el versionado exclusivo por hash de commit. Se descarta `2.0.0` — el proyecto no tiene una serie 0.x/1.x real detrás que justifique cruzar a versión mayor 2, y hay pulido pendiente (ver hallazgo de `docs/`) antes de considerar siquiera 1.0.0.
5. **Terminología**: se deja el eufemismo "brújula" (con esteroides IA) y se adopta el término técnico **"harness"** en la documentación de cara al usuario.
6. **Versionado por capas, independiente por runtime**: el Core (repo raíz / metodología) versiona en `SPEC.md`; Claude Code versiona en `plugins/suplemento-core/.claude-plugin/plugin.json`; Gemini versiona en `runtimes/gemini-antigravity/runtime.json` (nuevo, creado en esta sesión) — cada archivo de runtime incluye un campo `core_version` apuntando a qué versión del Core implementa, para poder rastrear desfases entre runtimes sin forzar un número compartido.

## Razones

1. El trabajo de conversión a Gemini ya estaba completo cuando se identificó como hito — formalizar la decisión después del hecho es más honesto que fingir que se planificó de antemano.
2. Mantener Claude Code en su ubicación actual evita fricción operativa inmediata a cambio de una simetría puramente cosmética.
3. Nombrar formalmente Brain KMS documenta una realidad que ya existía en la práctica (5 categorías de registro).
4. `0.10.0` en vez de `2.0.0`: semver recién adoptado, sin serie previa real que lo respalde, y quedan pendientes de pulido (docs/) que hacen prematuro un salto de versión mayor.
5. "Harness" es el término técnico correcto para lo que este repo construye — el eufemismo "brújula" quedó corto para comunicar qué es la herramienta.
6. Versionado independiente por runtime refleja la realidad: Claude Code y Gemini no tienen el mismo nivel de completitud ni el mismo ritmo de cambio, y forzar un número compartido (lockstep) obligaría a bumpear ambos aunque solo uno cambie.

## Consecuencias

- `runtimes/README.md` documenta la convención de ubicación (creado en esta sesión).
- `runtimes/gemini-antigravity/runtime.json` — nuevo, versiona el runtime de Gemini de forma independiente y referencia `core_version`.
- `plugins/suplemento-core/.claude-plugin/plugin.json` — fija `"version": "0.10.0"`, descripción actualizada con "harness".
- `.claude-plugin/marketplace.json` — descripción actualizada con "harness" y mención multi-runtime.
- `plugins/suplemento-core/CHANGELOG.md` — entrada 2026-09-11 corregida a v0.10.0, con nota explicando el punto de partida de semver.
- `SPEC.md` — versión del documento y hallazgos actualizados (pendiente: hallazgo `docs/` incompleta, pendiente: propagar renombre `brain-adr` → `brain-kms`).
- **Pendiente explícito, no resuelto en esta sesión:** renombrar `plugins/suplemento-core/skills/brain-adr/` a `brain-kms/` en Claude Code.
- **Pendiente explícito, no resuelto en esta sesión:** reconstruir el contenido de los 8 archivos vacíos de `docs/` cuando el autor recupere el material de la sesión de chat que no se pasó en limpio.
- **Pendiente explícito, no resuelto en esta sesión:** el launcher de Gemini sigue sin terminar — el autor lo retoma después de esta sincronización.
- No cambia ninguna regla técnica de `sequential-mode`, `tdd-workflow`, ni el resto de la disciplina — esta decisión es de estructura, versionado y nomenclatura, no de método de trabajo.

## Commit

Ver entrada "Sesión — 2026-09-11 — v0.10.0: harness multi-runtime + Brain KMS" en `brain/sesiones.md`.
