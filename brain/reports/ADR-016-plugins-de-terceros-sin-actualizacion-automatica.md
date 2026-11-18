# ADR-016 — Plugins de terceros sin actualización automática por defecto

**Estado:** Vigente (complementa la ADR-015, no la reemplaza)
**Fecha:** 2026-11-17

## Contexto

La ADR-015 dejó abierto si activar AutoUpdate para Modern Web Guidance. La lectura de *Securing Agentic Applications V2* (OWASP, §6.4.3) señala como vulnerabilidad el modelo de "aprobar una vez y confiar siempre": un plugin, skill o servidor de herramientas puede cambiar su comportamiento en una actualización sin que nadie lo revise, y los cambios deben disparar una nueva aprobación.

## Decisión

1. **AutoUpdate desactivado por defecto** para todo plugin, skill o servidor MCP de terceros que recomiende el ecosistema (incluido Modern Web Guidance).
2. **Las actualizaciones se revisan con `ketchup`** (ítem 18), que informa qué versión hay, qué cambió y pide aprobación antes de actualizar.
3. Cada versión aprobada se registra en `PLUGINS.md` del proyecto.
4. Los plugins de los que depende el propio autor (por ejemplo `suplemento-core`) quedan fuera de esta regla: son suyos.

## Consecuencias

- Más trabajo manual para actualizar, a cambio de que ninguna actualización de terceros llegue sin revisión.
- `ketchup` pasa a ser el mecanismo de actualización, no solo de aviso.
- El ítem 20 de `SPEC.md` ya no necesita decidir sobre AutoUpdate: queda desactivado.

## Commit

Ver entrada "Sesión — 2026-11-17 — correcciones tras leer los documentos OWASP" en `brain/sesiones.md`.
