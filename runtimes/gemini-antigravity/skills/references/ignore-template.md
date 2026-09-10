# Plantillas — .gitignore y .geminiignore (siempre como par)

Dos archivos con propósitos distintos, generados juntos, nunca uno sin el otro:

- **`.gitignore`** responde: "¿Esto se versiona?"
- **`.geminiignore`** responde: "¿Esto vale la pena que Gemini lo lea en su contexto?"

Un archivo puede necesitar estar en git (reproducibilidad del entorno) pero no tener ningún valor si el agente lo carga en contexto. El caso canónico: los lockfiles de dependencias (`uv.lock`, `package-lock.json`, `poetry.lock`) se commitean siempre, pero jamás aportan contexto útil y solo queman tokens si el agente los lee.

---

## .gitignore

```gitignore
# Entorno / dependencias (ajustar según el lenguaje del proyecto)
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

# Editor / IDE
.vscode/
.idea/

# Agente / Caché de Runtime
.claude/cache/
.gemini/cache/

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

# Brain KMS — archivos privados (solo si el proyecto usa estructura completa)
brain/files/secure/*
brain/files/secure/backup/*

```



## .geminiignore

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

# Archivos de caché del agente
.gemini/
.claude/

# Archivos seguros / sensibles (doble protección junto con .gitignore)
brain/files/secure/







## Regla de generación

Al ejecutar la inicialización de un proyecto (project-init), Gemini debe generar ambos archivos en el mismo paso:

    Si el proyecto no usa la estructura completa (sin brain/), omitir las líneas relativas a brain/files/secure/ en ambos archivos.

    Si el proyecto genera archivos para compatibilidad multi-agente, puede escribir tanto .geminiignore como .claudeignore manteniendo exactamente el mismo contenido.

    Cualquier nueva exclusión futura debe evaluarse con las dos preguntas independientes.

