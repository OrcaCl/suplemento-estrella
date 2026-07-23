# Plantilla — CLAUDE.md

`CLAUDE.md` auto-carga contexto de proyecto en cada sesión de Claude Code. Independiente de si el proyecto usa estructura simple o completa, lleva estas 7 secciones mínimas.

---

```markdown
## Confirmación de contexto

Al iniciar cada sesión, después de leer SPEC.md {{y brain/index.md si el proyecto usa brain/}}, confirmar con este mensaje exacto en consola antes de cualquier acción:

✅ Contexto cargado — SPEC.md v[VERSION]
| [N] tests | Próximo paso: [PRIMER_ITEM_PENDIENTE]

---

## Contexto del proyecto

{{2-3 líneas: qué hace el proyecto, para quién, en qué estado está}}

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

- `spec/historial.md` {{o `brain/sesiones.md` si el proyecto usa estructura completa}} — hitos y descubrimientos de la sesión
- `SPEC.md` — marcar ítems completados, actualizar footer con conteo de tests
- {{`brain/ADR-*.md` — si se tomó una decisión de arquitectura relevante (solo estructura completa)}}

**No esperar instrucción explícita** — al cerrar sesión, proponer qué registrar.

### Regla de registro inmediato — NO NEGOCIABLE

Después de cualquier breakthrough importante (feature completada, bug crítico resuelto, migración ejecutada) hay que registrar de inmediato, antes de continuar con la siguiente tarea. No acumular para el cierre de sesión.
```

---

## Notas de uso

- Los bloques `{{...}}` condicionados a "si el proyecto usa brain/" deben eliminarse por completo (no dejar el placeholder vacío) si el proyecto eligió la estructura simple en `project-init`.
- La sección de "Regla crítica" empieza vacía en un proyecto nuevo — eso es correcto y esperado. Se llena orgánicamente. No inventar una regla crítica ficticia solo para no dejar la sección vacía.
- Si el proyecto tiene plugins de Claude Code instalados (Superpowers, sistemas de memoria, etc.), agregar una sección adicional de "Plugins" con puntero a `PLUGINS.md` — ver convención en el proyecto de referencia para el formato de ese archivo.