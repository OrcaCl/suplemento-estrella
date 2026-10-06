# SKILL: Code Comment Convention (Comentarios en el código sin ruido)

## Propósito y Disparadores
Gobierna **QUÉ** se documenta dentro del código fuente y cómo, para que los comentarios sean útiles, mínimos y resistentes a la interpretación del agente. El objetivo no es maximizar la cantidad de comentarios, sino preservar el conocimiento que **no puede inferirse de forma fiable leyendo la implementación**.
Aplica cuando:
- Se cree, modifique o revise código fuente.
- Se haga una limpieza o refactorización que pueda tocar comentarios.
- Se decida cómo documentar una decisión, una regla de negocio o un workaround.

Complementa a `06-documentation-convention.md` (cuándo y dónde registrar cambios en la documentación del proyecto), `11-spec-driven-development.md` (dónde vive la especificación) y `01-brain-kms.md` (conocimiento y decisiones del proyecto). Esta skill define qué permanece **dentro del código**.

---

### 1. Principio fundamental

> **El código explica QUÉ y CÓMO. Los comentarios explican POR QUÉ.**

Un comentario debe aportar lo que el código, los nombres y la estructura no pueden expresar razonablemente por sí mismos.

- Innecesario: `// Incrementar contador` sobre `counter++;`
- Útil: `// ExtJS dispara una segunda consulta con store.load(); cargamos con loadData() para mantener una única petición.`

Regla de decisión ante cualquier comentario, nuevo o existente: **¿qué conocimiento se perdería si lo elimino?**
- "Ninguno; el código ya lo explica" → eliminar.
- "La razón de esta implementación" o "una regla de negocio" → conservar (la regla de negocio, además, evaluar si pertenece a `SPEC.md` o Brain KMS).
- "Una decisión arquitectónica" → conservar como contexto local y evaluar si corresponde a Brain KMS.
- "Un problema temporal por resolver" → `TODO`/`FIXME` con referencia.

---

### 2. Regla de no destrucción

**Gemini NO elimina un comentario únicamente porque el código parece suficientemente claro sin él.** Antes de eliminar, clasificar:

| Pregunta | Resultado |
|---|---|
| ¿Describe código obvio? | Eliminar |
| ¿Documenta un contrato público? | Conservar como JSDoc/PHPDoc/docstring |
| ¿Explica una decisión no obvia? | Conservar |
| ¿Documenta una regla de negocio? | Conservar |
| ¿Explica un workaround o limitación de una dependencia? | Conservar |
| ¿Documenta una restricción de seguridad, rendimiento o infraestructura? | Conservar |
| ¿Documenta una decisión arquitectónica? | Conservar o mover a Brain KMS si es transversal |
| ¿Está desactualizado o contradice el código? | Verificar; si la información sigue válida, **actualizar** en vez de eliminar |

**La limpieza de comentarios no equivale a eliminación masiva.** Nunca ejecutar una limpieza indiscriminada basada en cantidad o longitud: una función con muchos comentarios puede necesitar refactorizar el código, no borrar documentación.

---

### 3. Jerarquía: cada conocimiento en su nivel

| Tipo de conocimiento | Dónde vive |
|---|---|
| QUÉ / CÓMO | Código y nombres |
| Contrato (entradas, salidas, errores) | JSDoc / PHPDoc / docstring / convención idiomática |
| POR QUÉ | Comentario inline |
| Regla de negocio | Comentario + documentación de dominio (`SPEC.md`) cuando corresponda |
| Arquitectura / conocimiento transversal | Brain KMS / documentación del proyecto |

> Cuanto más transversal y permanente sea el conocimiento, más arriba debe vivir. El comentario puede permanecer como contexto local, pero no debe ser la única fuente de verdad de una regla crítica.

---

### 4. Contratos

Usar la convención estándar del lenguaje (JSDoc en JavaScript, PHPDoc en PHP, docstrings en Python; en otros lenguajes, la idiomática, sin inventar sintaxis propia) para: funciones y métodos públicos, clases, módulos reutilizados, funciones cuya entrada o salida no es evidente, con efectos secundarios relevantes, que interactúan con APIs externas, que implementan reglas de negocio o que pueden lanzar errores importantes.

**No documentar artificialmente cada función trivial** (`add(a, b)` con tres líneas de JSDoc) si el proyecto no lo requiere para una API pública: se documentan **contratos relevantes**, no se llena el código de texto redundante.

---

### 5. Comentarios inline

Usarlos principalmente para: decisiones no obvias, reglas de negocio, workarounds, limitaciones de frameworks o librerías, restricciones de seguridad o rendimiento, compatibilidad, razones para **no** usar una alternativa aparentemente mejor, y comportamiento externo que condiciona la implementación. Se conservan en refactorizaciones mientras la razón siga siendo válida.

**No** narrar el código línea por línea (`// Crear store`, `// Retornar datos`): preferir nombres claros y comentar solo el POR QUÉ.

---

### 6. Marcadores: TODO / FIXME / HACK / NOTE

No son intercambiables:

| Marcador | Significado |
|---|---|
| `TODO` | Trabajo pendiente conocido |
| `FIXME` | Problema conocido que debería corregirse |
| `HACK` | Solución deliberadamente no ideal, necesaria por una restricción externa — **debe decir por qué existe** (un `HACK` sin contexto tiene poco valor) |
| `NOTE` | Información importante que no es una tarea pendiente |

Cuando sea posible, asociar `TODO` y `FIXME` a un issue, ticket o referencia concreta.

---

### 7. Comentarios obsoletos

Un comentario incorrecto es peor que ninguno. Cuando el código cambia, verificar los comentarios relacionados: actualizarlo si la razón sigue válida; eliminarlo si la razón dejó de existir; moverlo a Brain KMS si su alcance ya no es local. No conservar un comentario solo porque "siempre estuvo ahí".

---

### 8. Aplicación por tipo de archivo (ejemplo ExtJS + Supabase)

- **JavaScript / ExtJS:** JSDoc para contratos; inline para comportamiento particular de ExtJS, ciclos de vida, eventos no evidentes, workarounds, decisiones de Store/Model/ViewModel y razones para evitar mecanismos aparentemente equivalentes.
- **Supabase:** documentar reglas de seguridad relevantes, consultas no evidentes, selección explícita de columnas (por ejemplo, cuando una política RLS depende de ella), RPCs, transformaciones de datos y workarounds de la API.
- **HTML:** solo comentarios de estructura cuando ayuden (`<!-- Formulario de filtros -->`); no comentar cada elemento.
- **CSS:** separar componentes o secciones cuando el archivo lo justifique; no comentar reglas individuales de propósito evidente.

---

### 9. Adopción en un proyecto existente

Un proyecto que ya existía y solo actualizó el runtime no adopta la convención automáticamente: su `GEMINI.md` debe declararla. `ward` y `keepit` la ofrecen **una sola vez** (paso 0a de `06-documentation-convention.md`). Si el humano acepta, agregar a `GEMINI.md` la sección `## Comentarios en el código`:

```markdown
## Comentarios en el código

El código explica QUÉ y CÓMO; los comentarios explican POR QUÉ. Documentar contratos con la convención del lenguaje (JSDoc, PHPDoc, docstrings) y usar comentarios inline solo para decisiones no obvias, reglas de negocio, workarounds y restricciones de seguridad o rendimiento. Nunca eliminar un comentario solo porque el código parece suficientemente claro: antes de una limpieza o refactorización, clasificarlo (ver skill 14-code-comment-convention).
```

Si rechaza, dejar en `GEMINI.md` la línea `Comentarios en el código: convención no adoptada (decisión del humano, AAAA-MM-DD)` para no volver a ofrecerla. No hace falta tocar el código existente: la convención rige hacia adelante.

---

> **Principio final:** no buscamos más comentarios, buscamos menos conocimiento perdido. Un código limpio no es un código sin comentarios: es uno donde el código expresa lo que hace, los comentarios explican lo que el código no puede, las reglas de negocio y las decisiones importantes conservan su contexto, y un agente puede refactorizar sin destruir conocimiento accidentalmente.
