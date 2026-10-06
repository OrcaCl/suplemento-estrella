# Plantilla — CLAUDE.md

`CLAUDE.md` auto-carga contexto de proyecto en cada sesión de Claude Code. Independiente de si el proyecto usa estructura simple o completa, lleva estas secciones mínimas.

---

```markdown
## Confirmación de contexto

Al iniciar cada sesión, después de leer SPEC.md {{y brain/index.md si el proyecto usa brain/}}, confirmar con este mensaje exacto en consola antes de cualquier acción:

✅ Contexto cargado — SPEC.md v[VERSION]
| {{[N] tests | — solo si el proyecto tiene tests; si no, eliminar este segmento}}Próximo paso: [PRIMER_ITEM_PENDIENTE]

---

## Contexto del proyecto

{{2-3 líneas: qué hace el proyecto, para quién, en qué estado está}}

{{A la instancia de Code en este proyecto se le llama NOMBRE. — línea que define el Paso 3a de project-init; omitir por completo si el usuario eligió la opción 4 (sin nombre)}}

---

## Stack tecnológico

| Componente | Tecnología | Versión |
|---|---|---|
| {{...}} | {{...}} | {{...}} |

Tablas/entidades principales: {{lista breve, se actualiza a medida que crece}}

---

## Regla(s) crítica(s) — NO NEGOCIABLE

{{Si ya existe una regla crítica identificada, va aquí en mayúsculas con explicación de por qué es no negociable. Si el proyecto recién arranca y todavía no hay ninguna, dejar:}}

> _Sin reglas críticas registradas todavía. Se agregan aquí en cuanto una decisión de este tipo se identifique — no esperar a que el proyecto crezca para empezar a documentarlas._

---

## Estrategia de testing por niveles

Seguir siempre este orden. No saltar al nivel superior sin que el inferior pase primero.

### Nivel 1 — Tests del módulo afectado (correr siempre primero)
```bash
{{comando de test scoped al módulo}}
```

### Nivel 2 — Suite rápida sin tests lentos
```bash
{{comando de test suite completa, excluyendo marcados como lentos}}
```

### Nivel 3 — Suite completa (solo antes de commits importantes o cambios de schema)
```bash
{{comando de test suite completa, en paralelo si el proyecto lo soporta}}
```

---

## Comandos frecuentes

```bash
# Activar entorno
{{comando}}

# Tests con cobertura
{{comando}}

# Migraciones (si aplica)
{{comando}}

# Levantar servidor de desarrollo
{{comando}}
```

---

## Modo de trabajo

Trabajar siempre en modo secuencial — una tarea a la vez. No lanzar subagentes en paralelo salvo que las tareas sean completamente independientes entre sí Y el beneficio de tiempo sea evidente.

Razón: el paralelismo multiplica el consumo de tokens por el número de agentes activos. Ante la duda, preferir secuencial.

---

## Convención de documentación

Al finalizar cada sesión de trabajo, proponer actualizaciones a:

- `brain/sesiones.md` — hitos y descubrimientos de la sesión
- `SPEC.md` — reemplazar, no acumular: ítems cerrados salen de la §3 hacia `spec/cerrados.md` (mismo ID + fecha + evidencia, ordenado por ID), "Última sesión" y footer se sobrescriben (footer de una línea, con métricas clave del dominio; conteo de tests solo si el proyecto tiene tests). Tope por líneas (1000 por defecto) — se revisa al leerlo y antes de cada commit de `SPEC.md` (ver skill `spec-driven-development`)
- `brain/ADR-*.md` / `INT-*.md` / `NOC-*.md` / `DEP-*.md` — si se tomó una decisión de ese tipo

**No esperar instrucción explícita** — al cerrar sesión (`listeilor`), proponer qué registrar. A mitad de sesión, el humano guarda con `ward` (commit local, sin push).

### Configuración de SPEC

Valores por defecto de `suplemento-core`; borrar la línea que no se quiera cambiar (ver skill `spec-driven-development`).

- registro: diferido            # diferido = en `ward`/`listeilor` · inmediato = tras cada breakthrough
- spec_tope_lineas: 1000        # al superarlo hay que condensar; al 80 % se avisa
- sesiones_anteriores_en_spec: 0

---

## Comentarios en el código

El código explica QUÉ y CÓMO; los comentarios explican POR QUÉ. Documentar contratos con la convención del lenguaje (JSDoc, PHPDoc, docstrings) y usar comentarios inline solo para decisiones no obvias, reglas de negocio, workarounds y restricciones de seguridad o rendimiento. **Nunca eliminar un comentario solo porque el código parece suficientemente claro:** antes de una limpieza o refactorización, clasificarlo (ver skill `code-comment-convention`).
```

---

## Notas de uso

- Los bloques `{{...}}` condicionados a "si el proyecto usa brain/" deben eliminarse por completo (no dejar el placeholder vacío) si el proyecto eligió la estructura simple en `project-init`.
- La línea del nombre de la instancia en `## Contexto del proyecto` la define el Paso 3a de `project-init` — el default es "Tomás"; si el usuario elige la opción 4 (sin nombre), eliminar la línea entera.
- La sección de "Regla crítica" empieza vacía en un proyecto nuevo — eso es correcto y esperado. Se llena orgánicamente. No inventar una regla crítica ficticia solo para no dejar la sección vacía.
- Si el proyecto tiene plugins de Claude Code instalados (Superpowers, sistemas de memoria, etc.), agregar una sección adicional de "Plugins" con puntero a `PLUGINS.md` — ver convención en el proyecto de referencia para el formato de ese archivo.