# ADR-018 — Reglas `deny` en `.claude/settings.json` en vez de `.claudeignore`

**Estado:** Vigente
**Fecha:** 2026-11-18

## Contexto

`project-init` generaba un `.claudeignore` junto al `.gitignore` y lo presentaba como "doble protección" para `brain/files/secure/` (material que "nunca se lee en contexto"). Al revisar la seguridad de las propias skills (ítem 22) se contrastó con la documentación oficial de permisos de Claude Code, que dice: *"If your project has a `.claudeignore` file, it has no effect, so move its entries into `Read` deny rules."* La protección que el harness decía dar no existía. La documentación indica además el alcance real de `Read` deny: cubre las herramientas de archivos y comandos de Bash reconocidos (`cat`, `head`, `tail`…), pero no scripts que abren archivos por su cuenta; para eso existe el sandbox.

## Decisión

1. **`project-init` deja de generar `.claudeignore`** y genera `.claude/settings.json` con reglas `permissions.deny` de `Read(...)` para `.env`, secretos, claves y `brain/files/secure/**`, fusionando con lo que ya exista.
2. **Se declara el alcance real** de esas reglas al humano, y se recomienda el sandbox cuando se necesite bloqueo por proceso.
3. **El `.gitignore` se amplía** (`.env.*`, `*.pem`, `*.key`, `id_rsa*`, `credentials*.json`, `secrets/`, `.claude/settings.local.json`).
4. **El primer push de `project-init` se revisa antes:** estado, búsqueda de secretos (`gitleaks`), agregar por ruta (nunca `git add .`/`-A`), destino confirmado, nunca `--force`. Lo mismo vale para `ward`, `keepit` y `housekeeping`, que agregan al índice solo por ruta.
5. Este repo aplica lo mismo: se elimina su `.claudeignore` y se agrega `.claude/settings.json`.
6. **Los proyectos ya inicializados** con `.claudeignore` quedan expuestos hasta migrarlos (ítem 23 de `SPEC.md`).

## Alternativas descartadas

- **Mantener el `.claudeignore` y solo avisar:** conserva una protección inexistente.
- **Usar `deny` para lockfiles y `node_modules/`:** habría impedido leerlos cuando sí hacen falta; se recomienda no leerlos por instrucción en `CLAUDE.md`.

## Consecuencias

- El plugin no incluye scripts (ADR-008): `settings.json` es una plantilla de datos, no código.
- `Read(./.env.*)` también bloquea `.env.example`; se documenta cómo ajustarlo.
- El error estuvo en el harness desde su origen (agosto de 2026): los proyectos del autor creados desde entonces pueden tener una protección que nunca funcionó.

## Commit

Ver entrada "Sesión — 2026-11-18 — revisión de seguridad de las skills propias" en `brain/sesiones.md`.
