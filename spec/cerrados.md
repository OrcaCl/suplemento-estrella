# Cerrados

Archivo único de ítems cerrados de este repo (desde suplemento-core 0.12.0). Cada entrada conserva **el mismo ID que tenía en la lista de pendientes de `SPEC.md`**, con fecha y evidencia verificable, y se ordena **por ID ascendente** (no por orden de llegada).

Formato: `**ID — ✅ CERRADO (fecha)[, motivo].** Título. 1–2 frases de qué se hizo o por qué se descartó + evidencia.`

Los cerrados anteriores a 0.12.0 no tenían ID: están en [`completado.md`](completado.md) (deprecado, se conserva como histórico).

**1 — ✅ CERRADO (2026-09-30).** Validar bajo presión las 3 skills propias (`disenar-antes-de-implementar`, `planificacion-por-fases`, `depuracion-sistematica`). Las skills se usaron en el proyecto "paciente cero" y en otros proyectos en desarrollo, y funcionan bien. Evidencia: validación del autor en uso real (proyectos privados), 2026-09-30.

**4 — ✅ CERRADO (2026-10-06), ya estaba hecho.** Actualizar el plugin instalado localmente (0.11.0 → 0.12.0). La actualización se hizo el 2026-09-30, antes de agregar el ítem al SPEC. Evidencia: `~/.claude/plugins/installed_plugins.json` registra `suplemento-core` 0.12.0 (`lastUpdated` 2026-09-30, SHA `f72c699`, igual al último commit del repo); `ward` y `listeilor` aparecen como skills disponibles en la sesión; no existe `.claude/commands/` que los tape.
