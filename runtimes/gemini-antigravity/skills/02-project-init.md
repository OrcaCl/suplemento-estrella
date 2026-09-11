# Project Init (Gemini)

Punto de entrada de todo proyecto bajo la metodología Suplemento Estrella cuando se trabaja con Gemini en Antigravity IDE. Equivalente funcional de `project-init` en el runtime de Claude Code — misma lógica, adaptada a los archivos que Gemini espera (`GEMINI.md`, `.geminiignore`).

## Por qué existe esta skill

Agregar `brain/` (Brain KMS) a mitad de proyecto, cuando el historial ya creció demasiado, es un retrofit costoso. Esta skill no pregunta el tamaño del proyecto para decidir si vale la pena `brain/` — se asume que sí, siempre.

## Paso 0 — Detectar estado existente antes de asumir que es un proyecto nuevo

Antes de crear nada, revisar el directorio actual. No asumir que se está partiendo de cero — un directorio con contenido previo cambia completamente qué proponer.

Chequear, en este orden:

1. **¿Existe `.git` con historial?**
   ```bash
   git status
   git log --oneline -5
   ```
   Si hay commits previos, cualquier estructura que se proponga debe convivir con lo que ya existe, no reemplazarlo.

2. **¿Ya existen `SPEC.md` o `brain/` en este directorio?**
   Si cualquiera de los dos existe, `project-init` no aplica en modo "crear desde cero" — ofrecer revisar/completar lo que falta, no proponer una estructura paralela. `SPEC.md` y `brain/` son agnósticos de agente (markdown plano): si el proyecto ya los tiene, **no se recrean ni se reescriben** — se adoptan tal cual.

3. **¿Ya existe `CLAUDE.md` pero no `GEMINI.md`?** — ver el caso especial siguiente, es la situación más probable al retomar con Gemini un proyecto que arrancó con Claude Code.

### Caso especial — adoptar un proyecto iniciado con otro agente (ej. Claude Code)

Escenario típico: el proyecto ya se inicializó con Claude Code (existen `SPEC.md`, `brain/`, `CLAUDE.md`) y ahora se quiere seguir trabajando desde Gemini en Antigravity IDE, en la misma carpeta — no es un cambio de directorio dentro del mismo editor, es un cambio real de agente e IDE.

Si el Paso 0 detecta `SPEC.md` y/o `brain/` ya existentes, **y no existe `GEMINI.md` todavía**, entrar en **modo adopción**:

1. Confirmar explícitamente con el usuario:
   > "Este proyecto ya tiene contexto (`SPEC.md`, `brain/`) generado con otro agente. Voy a adoptar ese contexto tal cual —sin recrearlo— y solo generar lo que falta para que Gemini pueda trabajar aquí: `GEMINI.md` y `.geminiignore`. ¿Confirmas?"
2. **No tocar** `SPEC.md`, `brain/`, `spec/`, ni `CLAUDE.md` — pertenecen al proyecto, no al agente. `CLAUDE.md` se deja intacto (Claude Code lo sigue necesitando si se vuelve a usar).
3. Leer `SPEC.md` completo y `brain/index.md` + `brain/sesiones.md` (última entrada) para construir el contexto real del proyecto — igual que al iniciar cualquier sesión normal.
4. Generar `GEMINI.md` (ver `references/gemini-template.md`) con el contenido real leído en el paso anterior — no una plantilla en blanco. En particular:
   - `## Contexto del proyecto` — el resumen real del proyecto (de `SPEC.md` §1), no un placeholder.
   - El nombre humano de la instancia: si `CLAUDE.md` ya tiene uno asignado (Paso 3a / INT-000), **preguntar si se reutiliza el mismo nombre para Gemini o se asigna uno distinto** — no asumir ninguna de las dos.
5. Generar `.geminiignore` si no existe (ver `references/ignore-template.md`). No tocar `.gitignore`/`.claudeignore` existentes.
6. Emitir el mensaje de confirmación de contexto estándar (ver skill `01-brain-kms.md` / protocolo de apertura de sesión en `GEMINI-RUNTIME.md`) una vez completada la adopción.

**No se necesita un script de instalación distinto para este caso.** `install-gemini.sh` ya no sobreescribe un `GEMINI.md` existente (solo vincula el `@import` si falta) — el trabajo real de detectar y adoptar contexto existente lo hace esta skill al ejecutarse, no el instalador.

Si la respuesta del usuario en el paso 1 es no, tratar como proyecto nuevo y continuar con el Paso 1 siguiente.

## Paso 1 — Crear la estructura completa: spec/ + brain/, siempre (solo si es proyecto nuevo)

Misma estructura que el runtime de Claude Code — ver `references/spec-folder-template.md` y las plantillas de `brain/` (`references/adr-template.md`, `int-template.md`, `noc-template.md`, `dep-template.md`, `ref-template.md`, `refx-template.md`).

`brain/index.md`, `sesiones.md`, `TOASK.md` y la estructura de `trackers/`/`files/` se crean desde el día 1. Los archivos sueltos `ADR-NNN.md`, `INT-NNN.md`, etc. no se crean vacíos — el primero de cada categoría se crea cuando ocurre la decisión real.

## Paso 2 — Archivos ignore, siempre como par

`.gitignore` y `.geminiignore` — ver `references/ignore-template.md`. Generar ambos juntos, nunca uno sin el otro. Ambos deben excluir explícitamente `brain/files/secure/`.

## Paso 3 — GEMINI.md base

Ver `references/gemini-template.md` para las 7 secciones mínimas.

## Paso 3a — Asignar un nombre humano a la instancia

Mismo criterio que en Claude Code (origen: `brain/INT-000` del repo constructor). Presentar las mismas 4 opciones: Gemini elige su nombre / el usuario lo asigna / default "Tomás" / sin nombre. Si el proyecto ya tiene un nombre asignado a Claude Code en `CLAUDE.md`, preguntar si se reutiliza o se asigna uno distinto para Gemini — no asumir.

## Paso 4 — Confirmar antes de escribir

Antes de crear los archivos, mostrar al usuario el árbol de carpetas completo y esperar confirmación explícita.

## Paso 5 — Primer commit y push

```bash
git add .
git commit -m "Inicializa estructura de proyecto (Suplemento Estrella + Gemini runtime)"
git push -u origin main
```

En modo adopción (proyecto existente), el mensaje de commit debe reflejar que se agregó soporte para Gemini, no que se inicializó el proyecto desde cero — ej. `"Agrega runtime Gemini a proyecto existente (Suplemento Estrella)"`.
