# Plantillas — .gitignore y reglas `deny` de Claude Code

Dos mecanismos con propósitos distintos, generados juntos:

- **`.gitignore`** responde: "¿esto se versiona?"
- **`.claude/settings.json` → `permissions.deny`** responde: "¿puede el agente leer esto?"

> **`.claudeignore` no funciona.** La documentación oficial de permisos de Claude Code dice: *"If your project has a `.claudeignore` file, it has no effect, so move its entries into `Read` deny rules."* Hasta la versión 0.15 este plugin generaba un `.claudeignore` y lo presentaba como protección de secretos: era una protección que no existía. Si un proyecto tiene uno, trasladar sus entradas a reglas `deny` y eliminarlo.

---

## .gitignore

```gitignore
# Entorno / dependencias (ajustar según el lenguaje del proyecto — ver skill tooling-roles)
__pycache__/
*.py[cod]
*.pyo
.venv/
venv/
env/
node_modules/

# Variables de entorno y secretos
.env
.env.*
*.env
!.env.example
*.pem
*.key
id_rsa*
credentials*.json
secrets/

# Base de datos local
*.db
*.sqlite3

# Archivos subidos y datos de instancia
instance/

# Logs
*.log
logs/

# Editor
.vscode/

# Claude Code
.claude/cache/
.claude/settings.local.json

# Build artifacts
*.egg-info/
dist/
build/

# Test artifacts
.coverage
.pytest_cache/

# OS
.DS_Store
Thumbs.db

# Brain — archivos privados (solo si el proyecto usa la estructura completa)
brain/files/secure/*
brain/files/secure/backup/*
```

`.claude/settings.local.json` se ignora aunque Claude Code lo agregue a la exclusión global de git al escribirlo: si el archivo se crea a mano, nadie más lo ignora por ti.

---

## .claude/settings.json — impedir que el agente lea secretos

Archivo compartido del proyecto (se versiona). Las reglas `deny` se aplican de inmediato, sin esperar a que el equipo confíe en la carpeta.

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)",
      "Read(./brain/files/secure/**)",
      "Read(**/*.pem)",
      "Read(**/*.key)",
      "Read(**/id_rsa*)"
    ]
  }
}
```

Notas:
- Un `Read(./.env.*)` también bloquea `.env.example`; si el agente lo necesita, ajustar la regla.
- **Alcance real de `Read` deny** (según la documentación oficial): aplica a las herramientas de archivos del agente y a comandos de Bash que reconoce (`cat`, `head`, `tail`, `sed`…). **No** aplica a un script que abre archivos por su cuenta ni a `grep -r` sin nombrar el archivo. Para bloquear a todos los procesos, activar el sandbox de Claude Code.
- Si el proyecto ya tiene `.claude/settings.json`, **fusionar** las reglas; nunca sobrescribirlo.
- Para reducir tokens (lockfiles, `node_modules/`), preferir no leerlos por instrucción en `CLAUDE.md`; no hace falta una regla `deny`, que además impediría leerlos cuando sí hacen falta.

---

## Regla de generación

Al ejecutar `project-init`, generar `.gitignore` y `.claude/settings.json` en el mismo paso, **sin sobrescribir** ninguno de los dos si ya existen (fusionar). Si el proyecto no usa la estructura completa (sin `brain/`), omitir las líneas de `brain/files/secure/`. Si el stack no es Python, ajustar las líneas de entorno/dependencias según el lenguaje elegido (ver skill `tooling-roles`).

Cada exclusión nueva se evalúa contra las dos preguntas por separado: "¿se versiona?" y "¿puede el agente leerlo?". El lockfile es el ejemplo: sí se versiona (reproducibilidad) y el agente puede leerlo cuando haga falta.
