---
name: project-init
description: Skill de onboarding para inicializar un proyecto nuevo bajo la metodología Suplemento Estrella. Úsala siempre que el usuario esté arrancando un repositorio nuevo, pida "inicializar el proyecto", "arrancar con la metodología", "crear la estructura base", o cuando detectes que un repo no tiene todavía SPEC.md ni carpeta spec/. Verifica primero que git esté instalado localmente y que el repo esté conectado a un remoto en GitHub, y luego crea siempre la estructura completa (spec/ + brain/ desde el inicio, con las seis categorías de registro: ADR, INT, NOC, DEP, REF, REFX) — no pregunta el tamaño del proyecto.
---

# Project Init

Punto de entrada de todo proyecto nuevo bajo metodología Suplemento Estrella. Verifica que el entorno de git esté listo y deja lista, siempre, la estructura completa de documentación — `spec/` + `brain/` — desde el primer commit.

## Por qué existe esta skill

Agregar `brain/` a mitad de proyecto, cuando el historial ya creció demasiado, es un retrofit costoso: hay que decidir retroactivamente qué contenido se convierte en qué categoría de registro, sin la claridad que sí existe al planificar desde el principio.

Esta skill no pregunta el tamaño del proyecto para decidir si vale la pena `brain/` — se asume que sí, siempre. Quien instala esta metodología ya está aceptando el costo de mantener documentación estructurada de decisiones; no tiene sentido ofrecerle después una versión liviana sin ella.

También evita un problema más básico: proponer una estructura de documentación con la convención de registro por checkpoint (`documentation-convention`) cuando todavía no hay ni git instalado ni un remoto configurado. Sin eso, esa convención es imposible de cumplir desde el primer día.

## Paso 0 — Detectar estado existente antes de asumir que es un proyecto nuevo

Antes de crear nada, revisar el directorio actual. `project-init` no debe asumir que está partiendo de cero — un directorio con contenido previo cambia completamente qué proponer.

Chequear, en este orden:

1. **¿Existe `.git` con historial?**
   ```bash
   git status
   git log --oneline -5
   ```
   Si hay commits previos, no es un directorio vacío — cualquier estructura que se proponga debe convivir con lo que ya existe, no reemplazarlo.

2. **¿Ya existe `SPEC.md` o `brain/` en este directorio?**
   Si cualquiera de los dos existe, `project-init` no aplica en modo "crear desde cero" — ofrecer revisar/completar lo que falta, no proponer una estructura paralela.

3. **¿El directorio actual tiene estructura de plugin de Claude Code** (`.claude-plugin/`, `plugins/<algo>/skills/`)?
   La señal más importante y la más fácil de pasar por alto: si el directorio es el repo *constructor* de un plugin, "inicializar un proyecto nuevo" tiene un significado distinto al habitual. Ver la sección siguiente.

### Caso especial — inicializar dentro del propio repo del plugin (uso meta)

Si el Paso 0 detecta estructura de plugin en el directorio actual, **no asumir que se trata de un proyecto cliente nuevo**. Preguntar explícitamente:

> "Este directorio ya es el repo que construye y distribuye una metodología de Claude Code, no un proyecto que la consume. ¿Quieres que le demos a este mismo repo su propio `SPEC.md` + `brain/`, para documentar las decisiones de diseño de la metodología en sí? Eso es distinto a inicializar un proyecto que va a *usar* estas skills."

Si la respuesta es sí (uso meta):

- Aplica la misma estructura completa del Paso 1 — no hay ninguna variante de tamaño que considerar.
- Adaptar el nombre del backlog vivo (`spec/{{objetivos}}.md`) a algo como `spec/roadmap-skills.md`.
- Las decisiones documentadas en `brain/` son sobre la metodología en sí: por qué una skill se separó en dos, por qué se corrigió tal convención — no sobre código de negocio de un proyecto cliente.
- **No crear `spec/api.md` orientado a integración externa** si no aplica — un repo constructor de plugin normalmente no habla con APIs de terceros.
- Ver `references/project-init-changelog-patch.md` para el detalle de por qué `CHANGELOG.md` en este caso vive dentro de `plugins/<plugin>/`, no en la raíz del repo.

Si la respuesta es no, o si el directorio no tiene estructura de plugin, continuar normalmente con los pasos siguientes.

## Paso 0a — Verificar que git esté instalado y funcional localmente

```bash
git --version
```

**Si el comando falla o no existe**, dar las instrucciones de instalación según el sistema operativo:

| SO | Comando |
|---|---|
| macOS | `brew install git` o `xcode-select --install` |
| Linux (Debian/Ubuntu) | `sudo apt update && sudo apt install git` |
| Linux (Fedora/RHEL) | `sudo dnf install git` |
| Linux (Arch) | `sudo pacman -S git` |
| Windows | `winget install --id Git.Git -e --source winget`, o git-scm.com |

Después de instalar, confirmar con `git --version` de nuevo.

**Si git está instalado pero nunca se configuró identidad:**
```bash
git config --global user.name "Tu Nombre"
git config --global user.email "tu@email.com"
```

**Si el directorio actual no tiene `.git` todavía:**
```bash
git init
git branch -M main
```
No hacer un primer commit todavía en este paso — eso viene naturalmente en el Paso 5, no antes de tener contenido real que commitear.

## Paso 0b — Verificar conexión con un repositorio remoto en GitHub

```bash
git remote -v
```

**Si no muestra nada:**

1. Confirmar que el usuario tiene cuenta de GitHub y el nombre del repositorio a usar — no asumirlo.
2. Si el repo remoto ya existe en GitHub:
   ```bash
   git remote add origin git@github.com:<usuario-u-org>/<nombre-repo>.git
   # o HTTPS:
   git remote add origin https://github.com/<usuario-u-org>/<nombre-repo>.git
   ```
3. Si el repo remoto todavía no existe:
   - Con `gh` CLI: `gh repo create <nombre-repo> --private --source=. --remote=origin`
   - Sin `gh`: crear manualmente desde github.com (vacío, sin README/licencia si el local ya tiene contenido) y luego `git remote add origin` con la URL mostrada.
4. **Verificar autenticación antes del primer push:**
   ```bash
   git ls-remote origin
   ```
   - HTTPS con `gh`: `gh auth login`, luego `gh auth setup-git`.
   - SSH: confirmar llave (`ls ~/.ssh/id_ed25519.pub`); si no existe, `ssh-keygen -t ed25519 -C "tu@email.com"`, agregarla en GitHub → Settings → SSH and GPG keys, confirmar con `ssh -T git@github.com`.
5. **Primer push de prueba**, una vez que haya al menos un commit:
   ```bash
   git push -u origin main
   ```

**Si `git remote -v` ya muestra un remoto configurado:** confirmar brevemente que apunta al repo esperado y seguir.

## Paso 1 — Crear la estructura completa: spec/ + brain/, siempre

```
<proyecto>/
├── SPEC.md
├── CLAUDE.md
├── README.md
├── .gitignore
├── .claudeignore
├── spec/
│   ├── api.md
│   ├── completado.md
│   ├── historial.md        # deprecated — se mantiene sin uso activo, ver nota
│   ├── datos.md
│   └── objetivos.md
└── brain/
    ├── index.md            # SOLO tabla de registros (todas las categorías) + puntero a sesiones.md
    ├── sesiones.md         # registro cronológico, entrada por sesión, más reciente arriba
    ├── TOASK.md            # preguntas/ideas tangenciales, categorizadas por audiencia
    ├── trackers/
    │   ├── bugs.md
    │   ├── bugs-report-template.md
    │   ├── features.md
    │   ├── features-proposal-template.md
    │   ├── deprecation-template.md
    │   └── generated/
    └── files/
        ├── (raíz)          # lo que el usuario sube — público, sí se versiona
        ├── manual/         # lo que Code genera o parsea para contexto — público, sí se versiona
        └── secure/         # material para enseñarle algo puntual al modelo y luego retirarlo — nunca se commitea, nunca se lee en contexto de forma persistente
```

Los archivos sueltos `ADR-NNN.md`, `INT-NNN.md`, `NOC-NNN.md`, `DEP-NNN.md`, `REF-NNN.md`, `REFX-NNN.md` viven en la raíz de `brain/`, junto a `index.md` — pero **no se crean vacíos al inicializar**. `brain/` arranca sin ningún registro; el primero de cada categoría se crea recién cuando ocurre la decisión real, en un checkpoint o cierre de sesión (ver skill `brain-adr`). Lo único que este paso crea desde el día 1 es `index.md` (con la tabla vacía), `sesiones.md`, `TOASK.md`, y la estructura de `trackers/`/`files/`.

Nota sobre `objetivos.md`: el nombre debe adaptarse al dominio del proyecto (ej. `features.md`, `roadmap.md`) — la función es siempre la misma, backlog vivo entre lo que el usuario necesita y lo que el agente sugiere.

**Nota sobre `spec/historial.md`:** archivo deprecated — se mantiene por continuidad histórica, sin uso activo. `brain/sesiones.md` y los registros de `brain/` cubren completamente el rol narrativo que este archivo cumplía antes de que `brain/` existiera siempre desde el inicio. No completarlo con contenido nuevo.

**Nota sobre `files/secure/`:** no es solo "privado" en abstracto — es material que se usa para darle contexto puntual al modelo sobre algo (documentación de un sistema externo, un manual técnico) y que después de cumplir su propósito puede retirarse, a diferencia de los otros dos niveles de `files/` que se acumulan indefinidamente.

**Regla no negociable, aprendida de un caso real:** `brain/index.md` contiene únicamente la tabla de registros — de cualquier categoría (ADR, INT, NOC, DEP, REF, REFX) — y un puntero a `sesiones.md`. Nunca pegar el resumen de una sesión directamente en `index.md` — esa duplicación ya ocurrió una vez y terminó con ~30 secciones redundantes entre los dos archivos. `sesiones.md` es el único lugar para el detalle cronológico.

Ver `references/spec-md-template.md` y `references/spec-folder-templates.md` para `SPEC.md` y `spec/`. Ver `references/brain-adr-template.md` (plantilla de ADR, `index.md`, `sesiones.md`, `TOASK.md`), `references/int-template.md`, `references/noc-template.md`, `references/dep-template.md`, y `references/ref-refx-template.md` para cada categoría de registro. Ver `references/trackers-templates.md` para bug report y feature proposal.

## Paso 2 — Archivos ignore, siempre como par

`.gitignore` y `.claudeignore` no son intercambiables — responden preguntas distintas ("¿esto se versiona?" vs. "¿esto vale la pena que el agente lo lea?"). Generar ambos juntos, nunca uno sin el otro. Ver `references/ignore-files-templates.md`.

Ambos deben excluir explícitamente `brain/files/secure/` (creado en el Paso 1) — es la única carpeta que requiere protección doble: nunca se commitea y nunca se lee en contexto.

## Paso 3 — CLAUDE.md base

Todo proyecto nuevo lleva un `CLAUDE.md` con estas secciones mínimas (ver `references/claude-md-template.md`):

1. Mensaje de confirmación de contexto al iniciar sesión
2. Contexto breve del proyecto (2-3 líneas)
3. Stack tecnológico (tabla)
4. Regla(s) crítica(s) no negociable(s) — puede quedar vacío al inicio
5. Estrategia de testing por niveles, con alcance de test **quirúrgico por defecto** — ampliar solo con confirmación explícita del humano (ver skill `tdd-workflow`)
6. Modo de trabajo: **cero subagentes por defecto, sin excepción autónoma** — cualquier paralelismo requiere que Code se lo pida al humano y este lo apruebe para esa tarea puntual (ver skill `sequential-mode`)
7. Convención de documentación: commits de código con normalidad; registro de `brain/`/`SPEC.md` diferido a checkpoint explícito o cierre de sesión obligatorio — nunca inmediato ni automático (ver skill `documentation-convention`)

## Paso 4 — Confirmar antes de escribir

Antes de crear los archivos, mostrar al usuario el árbol de carpetas completo del Paso 1 y esperar confirmación explícita. No escribir archivos sin este paso.

## Paso 5 — Primer commit y push, ahora que ya hay contenido real

```bash
git add .
git commit -m "Inicializa estructura de proyecto (Suplemento Estrella)"
git push -u origin main
```

Si el Paso 0b no llegó a completarse, dejarlo señalado como pendiente explícito en vez de forzarlo — el commit local puede existir sin push, pero no queda "registrado" según `documentation-convention` hasta que el push se haga.