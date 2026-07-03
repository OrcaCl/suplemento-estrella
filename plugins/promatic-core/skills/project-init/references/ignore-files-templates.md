# Plantillas — .gitignore y .claudeignore (siempre como par)

Dos archivos con propósitos distintos, generados juntos, nunca uno sin el otro:

- **`.gitignore`** responde: "¿esto se versiona?"
- **`.claudeignore`** responde: "¿esto vale la pena que el agente lo lea en su contexto?"

Un archivo puede necesitar estar en git (reproducibilidad del entorno) pero no tener ningún valor si el agente lo carga en contexto — ejemplo canónico: un lockfile de dependencias (`uv.lock`, `package-lock.json`) se commitea siempre, pero nunca aporta contexto útil y solo quema tokens si el agente lo lee.

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
.env.local
.env.prod
.env.test
.env.internal
*.env

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

---

## .claudeignore

```
# Entorno virtual / dependencias
.venv/
venv/
env/
node_modules/

# Bytecode / compilados
__pycache__/
*.pyc
*.pyo

# Artefactos de test y cobertura
.pytest_cache/
.coverage

# Base de datos local (binaria, sin valor como texto)
*.db
*.sqlite3

# Lockfile de dependencias — se versiona pero no aporta contexto
uv.lock
package-lock.json
poetry.lock

# Build artifacts
dist/
build/
*.egg-info/

# Git
.git/

# Logs
*.log
logs/

# Archivos seguros / sensibles (doble protección junto con .gitignore)
brain/files/secure/
```

---

## Regla de generación

Al ejecutar `project-init`, generar ambos archivos en el mismo paso. Si el proyecto no usa la estructura completa (sin `brain/`), omitir las líneas de `brain/files/secure/` de ambos. Si el stack no es Python, ajustar las líneas de entorno/dependencias según el lenguaje elegido (ver skill `tooling-roles` para el mapeo de equivalentes).

Cada exclusión nueva que se agregue en el futuro debe evaluarse contra las dos preguntas por separado — la respuesta puede ser distinta para cada archivo. El lockfile es el ejemplo de referencia: **no** va en `.gitignore` (sí se versiona, garantiza reproducibilidad del entorno) pero **sí** va en `.claudeignore` (no aporta contexto legible, solo consume tokens).