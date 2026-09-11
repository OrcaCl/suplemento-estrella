#!/usr/bin/env bash
# ==============================================================================
# Script de Instalación Oficial: Suplemento Estrella Runtime para Gemini
# Diseñado para Antigravity IDE (VS Code)
# ==============================================================================
set -e

# Repositorio Oficial de Suplemento Estrella
GITHUB_REPO="OrcaCl/suplemento-estrella"
GITHUB_BRANCH="main"
RUNTIME_PATH="runtimes/gemini-antigravity"

RAW_BASE_URL="https://raw.githubusercontent.com/${GITHUB_REPO}/${GITHUB_BRANCH}/${RUNTIME_PATH}"
DEST_DIR=".gemini"

echo "======================================================================"
echo "🚀 Instalando Suplemento Estrella — Runtime Gemini para Antigravity IDE"
echo "======================================================================"

# 1. Crear la estructura local .gemini/ en el proyecto del usuario
echo "📂 Preparando espacio aislado en ./${DEST_DIR}..."
mkdir -p "${DEST_DIR}/skills/references/trackers"

# 2. Función auxiliar para descargar de GitHub Raw
download_file() {
  local remote_rel_path="$1"
  local dest_file="${DEST_DIR}/${remote_rel_path}"
  local url="${RAW_BASE_URL}/${remote_rel_path}"

  echo "  ⬇️ Descargando: ${remote_rel_path}"
  curl -sSL -f "$url" -o "$dest_file" || {
    echo "  ❌ Error al descargar: $url"
    return 1
  }
}

# 3. Descargar Master Spec y Metadata
echo "📦 Descargando orquestador del runtime..."
download_file "GEMINI-RUNTIME.md"
download_file "runtime.json"

# 4. Descargar el Catálogo de 13 Skills Oficiales
echo "🧠 Descargando catálogo de 13 skills..."
SKILLS=(
  "01-brain-kms.md"
  "02-project-init.md"
  "03-code-simplicity.md"
  "04-depuracion-sistematica.md"
  "05-disenar-antes-de-implementar.md"
  "06-documentation-convention.md"
  "07-frontend-conventions.md"
  "08-planificacion-por-fases.md"
  "09-raw-data-audit-trail.md"
  "10-sequential-mode.md"
  "11-spec-driven-development.md"
  "12-tdd-workflow.md"
  "13-tooling-roles.md"
)

for skill in "${SKILLS[@]}"; do
  download_file "skills/${skill}"
done

# 5. Descargar Plantillas Estáticas (references/)
echo "📄 Descargando plantillas base (references)..."
REFERENCES=(
  "adr-template.md"
  "int-template.md"
  "noc-template.md"
  "dep-template.md"
  "ref-template.md"
  "refx-template.md"
  "gemini-template.md"
  "ignore-template.md"
  "spec-folder-template.md"
  "trackers-templates.md"
)

for ref in "${REFERENCES[@]}"; do
  download_file "skills/references/${ref}"
done

# 6. Crear o actualizar el punto de entrada GEMINI.md en la raíz del usuario
if [ ! -f "GEMINI.md" ]; then
  echo "📝 Generando GEMINI.md en la raíz de tu proyecto..."
  cat << 'EOF' > GEMINI.md
# GEMINI.md — Local Context Gate

## Contexto del Proyecto
- **Estado:** Inicializado vía Suplemento Estrella Installer
- **Instancia:** Tomás

---

## Directivas del Runtime
Gemini en Antigravity IDE debe seguir estrictamente el protocolo de ejecución definido en el runtime de Suplemento Estrella.

@import ".gemini/GEMINI-RUNTIME.md"
EOF
  echo "  ✅ GEMINI.md creado correctamente."
else
  echo "⚠️ Se detectó un GEMINI.md existente. Vinculando runtime..."
  if ! grep -q "@import \".gemini/GEMINI-RUNTIME.md\"" GEMINI.md; then
    echo "" >> GEMINI.md
    echo '# Directivas Suplemento Estrella' >> GEMINI.md
    echo '@import ".gemini/GEMINI-RUNTIME.md"' >> GEMINI.md
    echo "  ✅ Importación vinculada en GEMINI.md."
  fi
fi

# 7. Crear .geminiignore inicial si no existe
if [ ! -f ".geminiignore" ]; then
  echo "🛡️ Generando .geminiignore..."
  cat << 'EOF' > .geminiignore
.git/
node_modules/
venv/
.venv/
__pycache__/
*.pyc
dist/
build/
coverage/
.pytest_cache/
EOF
  echo "  ✅ .geminiignore creado."
fi

echo ""
echo "======================================================================"
echo "🎉 ¡Instalación de Suplemento Estrella completada!"
echo "======================================================================"
echo "Ahora en el chat de Gemini en Antigravity IDE solo escribe:"
echo ""
echo "   project-init"
echo ""
echo "======================================================================"