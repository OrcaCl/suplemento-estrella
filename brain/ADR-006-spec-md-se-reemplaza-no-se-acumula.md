# ADR-006 — SPEC.md se reemplaza, no se acumula: árbitro de destino y tope de tamaño

**Estado:** Vigente
**Fecha:** 2026-09-29

## Contexto

En un proyecto consumidor de Suplemento Estrella (`promatic-dashboard-pilot`), `SPEC.md` creció de 5 KB a 126 KB entre julio y septiembre de 2026. Una instancia de Code trabajando en ese proyecto detectó el problema y trajo la causa raíz a este repo, verificada en el historial de git del proyecto consumidor.

Las instrucciones de `suplemento-core` decían **qué** actualizar en `SPEC.md` en cada checkpoint y cierre de sesión, pero no decían que había que **reemplazar en vez de acumular**, no ponían tope de tamaño y no indicaban adónde iban los ítems cerrados. Síntomas concretos:

- El header "Última actualización" pasó de 39 a ~34.000 caracteres: cada checkpoint agregaba un bloque "Antes (fecha) — …" sin borrar el anterior.
- La tabla de la §2 acumuló ~30 filas "Sesión anterior".
- Los `[x]` quedaron en la §3 en vez de moverse a `spec/completado.md`.
- El footer pedía "conteo de tests", que no aplica a proyectos sin tests; se usó como bitácora.
- Al retirarse `spec/historial.md` en ese proyecto (DEP-001 de allá), la narrativa perdió destino y se duplicó entre el header del `SPEC.md` y `brain/sesiones.md`.

Ya estaba decidido con el humano, en ese proyecto, **no** restaurar `historial.md`: `brain/sesiones.md` es el historial. Lo que faltaba era un árbitro explícito de "qué va dónde" más un tope de tamaño.

**Opciones evaluadas:**
1. Solo agregar el tope de tamaño (chequeo con `wc -c`) y dejar el resto igual.
2. Árbitro de destino + regla de reemplazo + tope de tamaño con chequeo obligatorio antes del commit.

## Decisión

Se adopta la opción 2, en Core (Claude Code) y con paridad en el runtime de Gemini:

1. **Árbitro de destino.** Narrativa y hallazgos → `brain/sesiones.md` (o `spec/historial.md` en estructura simple), nunca `SPEC.md`. Ítems `[x]` → `spec/completado.md` (1 línea con fecha) y salen de la §3. Detalle técnico de componentes → `spec/features.md`. Schemas de API → `spec/api.md`. Decisiones → `brain/ADR|INT|NOC-*.md` + puntero.
2. **Reemplazar, no acumular.** "Última actualización" = solo la fecha. "Última sesión" (§2) = 1 fila de ≤ ~400 caracteres que sobrescribe la anterior (prohibidas las filas "Sesión anterior" y los bloques "Antes (…)"). Footer ≤ ~300 caracteres.
3. **Tope de tamaño.** `SPEC.md` ≤ ~15 KB, ninguna línea > 600 caracteres. Chequeo obligatorio antes del commit, tanto en el checkpoint como en el cierre de sesión: `wc -c SPEC.md` y `awk 'length>600{print NR}' SPEC.md`. Si excede, condensar y mover a su destino primero.
4. **Footer.** "Conteo de tests" pasa a "métricas clave del dominio (conteo de tests solo si el proyecto tiene tests; si no, solo versión y fecha)".
5. **Plantilla de `SPEC.md`.** Abre con un comentario HTML con los límites, para que aparezca en todo `SPEC.md` nuevo creado por `project-init`.
6. **Dónde vive la regla.** La versión completa está en `spec-driven-development` (Claude Code) y `11-spec-driven-development.md` (Gemini); el resto de los archivos que tocaban `SPEC.md` llevan la versión corta con puntero, para no duplicar la regla completa en 12 lugares.

## Razones

1. Un `SPEC.md` de 126 KB se carga completo al inicio de cada sesión (regla de apertura): el costo de contexto crece con cada checkpoint, y el archivo deja de ser "el panel de control corto" que la metodología promete.
2. El tope solo (opción 1) no ataca la causa: sin un destino para cada tipo de contenido, al llegar al tope no hay dónde mover lo que sobra. El árbitro de destino resuelve eso.
3. El chequeo con `wc`/`awk` es mecánico y barato — convierte la regla de "buena práctica" en un paso verificable del checkpoint, no en una intención.
4. Mantener la regla completa en una sola skill y punteros en el resto evita que las 12 redacciones diverjan con el tiempo — el mismo problema de fondo que causó el incidente (instrucciones parciales repartidas en varios archivos).

## Consecuencias

- Plugin `suplemento-core` sube a `0.10.1`; runtime Gemini a `0.1.1` con `core_version` `0.10.1`.
- Archivos modificados: `spec-driven-development`, `commands/checkpoint.md`, `documentation-convention`, `brain-adr`, `project-init/references/{spec-md,claude-md}-template.md`, `CLAUDE.md` (raíz), y en Gemini `01`, `06`, `11` y `references/gemini-template.md`.
- Los proyectos que ya usan el harness **no** se corrigen solos: al actualizar el plugin adoptan la regla para futuros checkpoints, pero un `SPEC.md` ya inflado hay que condensarlo a mano (como se hizo en el proyecto consumidor).
- Quedó fuera de alcance, y anotado como pendiente en `SPEC.md` y en `CHANGELOG.md`: el `[N] tests` del mensaje de confirmación de contexto, que tampoco aplica a proyectos sin tests (5 archivos entre Claude Code y Gemini).
- No cambia `sequential-mode`, `tdd-workflow` ni la regla de cuándo se documenta (`documentation-convention`); cambia *cómo* se actualiza `SPEC.md` cuando ese momento llega.

## Commit

Ver entrada "Sesión — 2026-09-29 — SPEC.md se reemplaza, no se acumula (v0.10.1)" en `brain/sesiones.md`. Cambios de código en el commit `596a57f`.
