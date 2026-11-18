# DEP-002 — Retiro del runtime Gemini

**Estado:** Vigente
**Fecha:** 2026-11-18

## Qué se retira

- `runtimes/gemini-antigravity/` completo (14 skills traducidas, plantillas, `runtime.json`, `GEMINI-RUNTIME.md`) y `install-gemini.sh`.
- La sección de Gemini del README, de `docs/getting-started.md` y las menciones al runtime en `docs/`, `marketplace.json` y `plugin.json`.

Última versión del runtime: `0.1.6`, con `core_version` `0.15.0`. Reemplaza al congelamiento de ADR-017.

## Por qué

1. El autor trabaja con Claude Code y prefiere ese entorno; no piensa usar Gemini en el futuro próximo.
2. La cuenta de Gemini que se usó para probar el runtime es compartida y tiene el mismo problema de reparto de tokens.
3. Mantener la paridad costaba trabajo en cada cambio del núcleo, sin uso real.
4. Dejar un runtime desactualizado visible en el repo daría una instalación sin los cambios de seguridad de la 0.16.0.

## Qué se conserva (para poder volver)

- **Etiqueta git `runtime-gemini-0.1.6`**, que apunta al último commit con el runtime (`51be929`). Recuperarlo: `git checkout runtime-gemini-0.1.6 -- runtimes install-gemini.sh`. La etiqueta es local hasta que se empuje (ítem 24).
- **Respaldo en `brain/files/secure/runtime-gemini-antigravity-0.1.6.tar.gz`** (31 archivos, verificado byte a byte contra la etiqueta). La carpeta no se versiona, así que ese respaldo vive solo en esta máquina.
- El historial de git conserva el runtime completo en los commits anteriores.
- Las ADR, el `CHANGELOG` y `brain/sesiones.md` conservan su historia sin editar.

## Consecuencias

- Los proyectos que instalaron `.gemini/` quedan sin mantenimiento y sin los cambios de la 0.16.0.
- `install-gemini.sh` deja de existir en la rama principal: el comando de instalación del README ya no funciona. Quien lo necesite debe usar la etiqueta.
- Si el autor vuelve a necesitar Gemini, hay que rehacer la paridad desde la etiqueta y traducir seis cambios del núcleo.

## Commit

Ver entrada "Sesión — 2026-11-18 — cierre de la 0.16.0" en `brain/sesiones.md`.
