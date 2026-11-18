# NOC-001 — claude-mem: presión hacia el plan Pro y captura global de proyectos

**Estado:** Monitoreo activo
**Fecha de apertura:** 2026-11-17

## Observación

Con claude-mem 15.19.0 se observaron, juntas, tres cosas:

1. **Insistencia comercial.** El autor eligió dos veces seguir con memoria local y sin plan Pro. `~/.claude-mem/setup-state.json` lo confirma (`status: complete`, `branch: home`, `memoryBilling: existing`), pero el hook de inicio de sesión sigue avisando "Setup is waiting for your choices".
2. **Captura global.** Todas las sesiones de todos los proyectos (personales, laborales y privados) van a una sola base (`~/.claude-mem/claude-mem.db`, ~312 MB) y el panel local las muestra juntas.
3. **Telemetría activada por defecto.** `telemetry.json` traía `enabled: true` y se generaban resúmenes diarios (`telemetry-daily.json`) con conteos de uso, versión y sistema operativo; no se vio contenido de proyectos, pero solo se leyó el comienzo del archivo.

Verificado en la máquina: los campos `CLOUD_SYNC_*` y `PRO_MEMORY_*` de `settings.json` están vacíos y el worker escucha solo en `127.0.0.1:37700`. La documentación del propio plugin indica además que el instalador envía a cmem.ai un resumen numérico de uso cuando el setup crea un enlace de inicio de sesión; no se pudo comprobar si eso ocurrió en esta instalación.

## Por qué no es un ADR ni una alarma de seguridad todavía

- No hay evidencia de que datos de proyectos salgan de la máquina: sin sincronización a la nube, worker solo local.
- No es una decisión de arquitectura de este repo: claude-mem es una herramienta de terceros que el autor usa, no parte del harness.
- El riesgo es de dependencia y de privacidad por mezcla de proyectos, y depende de hacia dónde evolucione el producto.

## Qué vigilar

- Que cualquier actualización reactive la telemetría o reescriba `telemetry.json` (se mitiga con `DO_NOT_TRACK=1` en el shell).
- Que aparezcan valores en `CLOUD_SYNC_*` o `PRO_MEMORY_*` sin que el autor los haya puesto.
- Que funciones hoy locales pasen a requerir el plan Pro.
- Que el worker deje de escuchar solo en `127.0.0.1`.
- Que el tamaño de `claude-mem.db` siga creciendo sin respaldo.

## Seguimiento

- **2026-11-17:** telemetría apagada editando `~/.claude-mem/telemetry.json` (`enabled: false`, respaldo en `telemetry.json.bak`). El plugin se mantiene instalado. Se evaluó Graphify como alternativa: sirve para navegar código por proyecto, no reemplaza una memoria de sesiones. Se acordó el ítem 9 de `SPEC.md` (memoria propia local) como salida de fondo.

## Commit

Ver entrada "Sesión — 2026-11-17 — claude-mem: telemetría apagada y dos pendientes nuevos" en `brain/sesiones.md`.
