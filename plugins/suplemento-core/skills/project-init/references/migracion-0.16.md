# Migración a 0.16.0

La 0.16.0 es una actualización grande. El plugin se actualiza una vez por usuario, pero **cada proyecto** necesita revisión manual: actualizar el plugin no modifica `SPEC.md`, `brain/`, `spec/`, `CLAUDE.md` ni los archivos de ignore de tus proyectos.

## ⚠️ Importante — `.claudeignore` nunca fue un mecanismo oficial

**Qué pasó.** Desde agosto de 2026, `project-init` generaba un archivo `.claudeignore` junto al `.gitignore` y las skills lo describían como una "doble protección" para `brain/files/secure/` y otros archivos que el agente no debía leer. **Claude Code no reconoce ese archivo.** La documentación oficial de permisos lo dice textualmente: *"If your project has a `.claudeignore` file, it has no effect, so move its entries into `Read` deny rules."* Es un patrón difundido en tutoriales que parece oficial y no lo es; este plugin lo adoptó y lo presentó como si funcionara.

**Qué significa.**
- **No es una puerta trasera ni da acceso a terceros.** El fallo es otro: el agente **sí podía leer** archivos que tú creías protegidos.
- Lo que el agente lee viaja al proveedor del modelo como parte de la conversación, y puede quedar en el historial local de sesiones y en herramientas de memoria que capturen las sesiones.
- El alcance real depende de si el agente leyó esos archivos. Solo importa si en la carpeta del proyecto había material sensible (`.env`, claves, `brain/files/secure/`, credenciales).

**Qué hacer en cada proyecto** (de a uno, con calma):

1. Crea `.claude/settings.json` con las reglas `deny` de la plantilla `references/ignore-files-templates.md` (si ya existe, **fusiona**; no lo sobrescribas).
2. Elimina el `.claudeignore`: no hace nada.
3. Agrega `.claude/settings.local.json` y los patrones de secretos al `.gitignore` (la misma plantilla).
4. Comprueba que la regla funciona: pídele al agente que lea un archivo de prueba protegido (por ejemplo un `.env` vacío); debe rechazarlo.
5. Busca secretos versionados: `gitleaks detect` si lo tienes, o `git log --all --oneline -- .env '*.pem' '*.key'` y una revisión a ojo de lo que `git ls-files` lista.
6. Si hubo un secreto real al alcance del agente y puede haberlo leído, **rótalo**. Es la única forma de dejar de depender de si lo leyó o no.

**Alcance de las reglas `deny`.** Cubren las herramientas de archivos del agente y comandos de Bash que Claude Code reconoce (`cat`, `head`, `tail`, `sed`…). **No** cubren un script que abre archivos por su cuenta ni `grep -r` sin nombrar el archivo. Para bloquear a todos los procesos existe el sandbox de Claude Code.

## Los boletines pasan a `brain/reports/` (opcional)

En proyectos grandes `brain/` se llenaba de decenas de boletines (ADR, INT, NOC, DEP, REF, REFX). Desde la 0.16.0 los proyectos nuevos los guardan en **`brain/reports/`**, y la raíz de `brain/` solo conserva `index.md` y `sesiones.md` (ADR-019).

**No es obligatorio migrar.** El diseño plano sigue siendo válido; lo único que importa es no mezclar los dos en un mismo proyecto. Si quieres migrar un proyecto, de a uno y con el árbol limpio:

```bash
mkdir -p brain/reports
git mv brain/ADR-*.md brain/INT-*.md brain/NOC-*.md brain/DEP-*.md brain/reports/   # y REF-*.md / REFX-*.md si existen
sed -i -E 's#\]\(((ADR|INT|NOC|DEP|REFX?)-[0-9]+[^)]*)\)#](reports/\1)#' brain/index.md
```

Después: revisa que `brain/index.md` abra bien los enlaces, busca con `grep -rn "brain/ADR\|brain/INT\|brain/NOC\|brain/DEP" .` referencias a la ruta antigua en tu `README.md`, `SPEC.md` o `CLAUDE.md`, y actualízalas. Los textos antiguos de `brain/sesiones.md` que citan rutas viejas son historia: no hace falta tocarlos. `housekeeping` detecta los boletines sueltos y propone esta migración como hallazgo mecánico.

## Otros cambios que afectan a tus proyectos

| Cambio | Qué hacer |
|---|---|
| **El registro en `brain/` y `SPEC.md` pasa a `registro: umbral`** (por defecto): Code registra solo al terminar una tarea con conocimiento nuevo, commit local sin push, avisando después (ADR-012) | Si prefieres el comportamiento anterior, declara `registro: diferido` en la "Configuración de SPEC" de tu `CLAUDE.md` |
| **El tamaño de `SPEC.md` solo avisa** (ADR-011): se eliminó la regla de 600 caracteres por línea y las 1000 líneas ya no bloquean el commit | Nada; `spec_tope_lineas` sigue siendo una referencia |
| **Skill nueva `seguridad-por-diseno`** (OWASP Top 10:2025, ASVS 5.0, riesgos de agentes, STRIDE, SSDF; ADR-014) | Declara `asvs_nivel` en tu `CLAUDE.md` (1 por defecto; 2 si el proyecto maneja login o datos personales) |
| **Comando nuevo `housekeeping`** (ADR-013) | Úsalo cuando quieras una limpieza con calma |
| **`ward`, `keepit` y `housekeeping` agregan al commit solo por ruta**, nunca `git add -A`; `keepit` nunca empuja con `--force` | Nada |
| **Plugins de terceros sin actualización automática** por defecto (ADR-016) | Revisa los plugins que tengas con AutoUpdate y decide si lo mantienes |
| **`frontend-conventions` cambia la Regla 2** (parcial de template con `<link>` y `@layer` en vez de `styles.css` con `@import`) y precisa la Regla 3 (BEM solo para nombres; ADR-020) | Opcional: tu `styles.css` con `@import` sigue funcionando, solo pagas el costo de rendimiento. Migra cuando toques el frontend |
| **`frontend-conventions` trae listas de accesibilidad, formularios y componentes** (adaptadas de Modern Web Guidance, Apache-2.0; ADR-021) y ya no se recomienda instalar ese plugin | Nada que migrar; si lo tienes instalado, puedes desinstalarlo (`/plugin uninstall`) y quitar su permiso `npx` de tu configuración |
| **Los boletines viven en `brain/reports/`** en proyectos nuevos (ADR-019) | Opcional; ver la sección anterior |
| **Se retiró el runtime Gemini** (DEP-002) | Si algún proyecto tiene `.gemini/`, queda sin mantenimiento; puedes dejarlo o borrarlo |

## Referencias

- `brain/reports/ADR-018` — reglas `deny` en vez de `.claudeignore`; `brain/reports/ADR-019` — boletines en `brain/reports/`.
- `ignore-files-templates.md` — plantillas de `.gitignore` y `.claude/settings.json`.
- Documentación oficial: <https://code.claude.com/docs/en/permissions> (sección sobre cómo bloquear la lectura de archivos).
