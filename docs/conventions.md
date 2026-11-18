# Convenciones

Las convenciones de nombres, estructura y documentación de Suplemento Estrella. Casi todas las que se listan aquí ya las aplicaba este repo de forma implícita; aquí quedan por escrito.

> Los principios detrás de estas convenciones están en [principles.md](principles.md). Los términos, en el [glosario](glossary.md).

---

## Estructura del repositorio

| Ruta | Contenido |
|---|---|
| `plugins/suplemento-core/` | Runtime de referencia (Claude Code): `skills/`, `commands/`, `.claude-plugin/plugin.json` |
| `.claude-plugin/marketplace.json` | Definición del marketplace instalable |
| `docs/` | Documentación conceptual, dirigida a quien instala y usa el harness |
| `brain/` | Brain KMS del propio repo: decisiones y sesiones |
| `spec/` | Detalle de `SPEC.md` |
| Raíz | `README.md`, `SPEC.md`, `CLAUDE.md`, `CHANGELOG.md`, `LICENSE`, `SHAME.md` |

`SHAME.md` vive en la raíz porque es un archivo operativo del proyecto, no documentación conceptual. `docs/` es para lo conceptual.

**Regla de ubicación:** cada tipo de información tiene un solo destino. Ver la tabla "Dónde va cada cosa" en la skill `spec-driven-development`.

## Registros de `brain/`

- Nombre de archivo: `PREFIJO-NNN-slug-en-minusculas.md`, por ejemplo `ADR-006-spec-md-se-reemplaza-no-se-acumula.md`.
- Numeración secuencial e independiente por prefijo (`ADR`, `INT`, `NOC`, `DEP`, `REF`, `REFX`). `000` solo para un registro conceptualmente anterior a otro de su categoría.
- Cada registro nuevo entra como una fila en `brain/index.md`, con enlace.
- Todo ADR e INT cierra con la sección `## Commit`.
- Las entradas de `sesiones.md` van con la más reciente arriba, con título `Sesión — AAAA-MM-DD — resumen`.

Detalle en [decisions.md](decisions.md).

## Documentación

- **Idioma:** español.
- **Fechas:** formato ISO, `AAAA-MM-DD`.
- **`SPEC.md`:** referencia de 1000 líneas (configurable; solo avisa) y sin límite por línea; "Última actualización" es solo la fecha; se reemplaza, no se acumula (ADR-006).
- **Cuándo:** el registro en `brain/` y `SPEC.md` ocurre al terminar una tarea que cruce el umbral (`registro: umbral`, ADR-012), en un `ward` o al cierre de sesión (`keepit`), no a mitad del trabajo.
- **`CHANGELOG.md`:** uno solo, en la raíz. Cada entrada cita la versión de la capa que cambió (`[Core vX.Y.Z]`…). Registra hitos, no cada commit (ADR-002).
- **`docs/`:** cada archivo explica un tema y enlaza al resto en vez de repetirlo.

## Versionado

Semver, **independiente por capa**: Core y Claude Code (`plugin.json`), y cada runtime (`runtime.json`, con su campo `core_version` de referencia). Sin lockstep. Ver ADR-001.

- **Patch:** correcciones de contenido.
- **Minor:** cambios visibles para quien usa el harness (p. ej. renombrar una skill).

## Commits

Formato `tipo(alcance): descripción`, en español.

| Tipo | Uso |
|---|---|
| `feat` | Capacidad nueva o cambio visible del harness |
| `fix` | Corrección |
| `docs` | Documentación y registro en `brain/` |

Alcances usados: `core`, `brain`, `spec`, `docs`, `meta` (y `runtime-gemini` en el historial anterior a la 0.16.0). Si un cambio afecta a varias capas, se listan separadas por coma (`core,docs`).

- Los commits de código son continuos; un commit de código no implica tocar `brain/` ni `SPEC.md`.
- El commit de un `ward` cubre el período completo y es local (sin push); `keepit` hace el commit final y el push (el registro no existe hasta que está pusheado).
- Antes de commitear un cambio a `SPEC.md`: revisar la consistencia (versión de cabecera y footer, pendientes solo en §3, IDs únicos); si el tamaño pasa de la referencia de 1000 líneas, avisar sin frenar el commit (ver `spec-driven-development`).

## Material de terceros

Cuando se adapta material de otra persona u organización (guías, listas, texto o código), se hace esto antes de commitear:

1. **Leer la licencia de origen** y anotar cuál es (en su repositorio o en la portada del documento). Si no se puede verificar, no se copia: se cita por nombre.
2. **Escribir con redacción propia** (traducir, resumir, reorganizar); no pegar párrafos completos.
3. **Encabezado en cada archivo adaptado:** fuente con enlace, licencia, y qué cambios se hicieron. Si la licencia lo exige (por ejemplo Apache-2.0), incluir una copia junto al archivo.
4. **Registrar la fuente en `NOTICE.md`**: obra, titular, licencia, archivo derivado y cambios.
5. **Respetar la licencia del resultado:** el material CC BY-SA 4.0 se redistribuye bajo la misma licencia, aunque el resto del repo sea MIT.
6. **No sugerir respaldo** de los autores originales.
7. **Dejar constancia de la decisión** en un boletín (qué se leyó y qué no, y por qué) y fechar la información que envejece.

El resumen de licencias de terceros vive en el README, en la sección "Créditos y licencias de terceros".

## Skills

- Una skill por carpeta en `plugins/suplemento-core/skills/<nombre>/SKILL.md`, con `name` y `description` en el encabezado.
- El nombre va en minúsculas y con guiones. Las plantillas de `project-init` viven en su subcarpeta `references/`.
- La regla completa vive en un solo lugar; el resto de los archivos la resumen y enlazan a ella, en vez de duplicarla.
