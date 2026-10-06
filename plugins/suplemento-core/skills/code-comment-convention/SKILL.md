---
name: code-comment-convention
description: Convención para documentar código fuente sin generar ruido — qué debe documentarse, cuándo usar JSDoc/docstrings u otras convenciones del lenguaje, cuándo escribir comentarios inline, cómo documentar decisiones y reglas de negocio, y qué comentarios un agente NO debe eliminar durante una limpieza o refactorización. Úsala al crear, modificar, revisar, refactorizar o limpiar código fuente.

---

# Code Comment Convention

Convención para mantener comentarios y documentación **útiles, mínimos y resistentes a la interpretación del agente**.

El objetivo no es maximizar la cantidad de comentarios, sino preservar dentro del código el conocimiento que **no puede inferirse de forma fiable leyendo la implementación**.

Esta skill complementa a `documentation-convention`, `spec-driven-development` y `brain-kms`.

* `documentation-convention` define **cuándo y dónde registrar cambios en la documentación del proyecto**.
* `spec-driven-development` define **dónde vive la especificación del comportamiento**.
* `brain-kms` define **cómo organizar y preservar conocimiento, contexto y decisiones del proyecto** para el desarrollador de carne y hueso.
* Esta skill define **qué debe permanecer dentro del código fuente y cómo documentarlo**.

---

## Principio fundamental

> **El código explica QUÉ y CÓMO. Los comentarios explican POR QUÉ.**

Un comentario debe aportar información que el código, los nombres y la estructura de la implementación no puedan expresar razonablemente por sí mismos.

### Comentario innecesario

```javascript
// Incrementar contador
counter++;
```

El código ya expresa completamente la intención.

### Comentario útil

```javascript
// ExtJS dispara una segunda consulta cuando usamos store.load().
// Cargamos los datos directamente para mantener una única petición.
store.loadData(data);
```

La razón de la decisión no puede inferirse de `store.loadData(data)`.

---

# Regla de no destrucción

**Un agente NO debe eliminar un comentario únicamente porque el código parece suficientemente claro sin él.**

Antes de eliminar un comentario, clasificarlo:

1. ¿Describe código obvio?

   * Puede eliminarse.

2. ¿Documenta un contrato público?

   * Conservar como JSDoc, docstring o equivalente.

3. ¿Explica una decisión no obvia?

   * Conservar.

4. ¿Documenta una regla de negocio?

   * Conservar.

5. ¿Explica un workaround o limitación de una dependencia?

   * Conservar.

6. ¿Documenta una restricción de seguridad, rendimiento o infraestructura?

   * Conservar.

7. ¿Documenta una decisión arquitectónica?

   * Conservar o mover a `brain-kms` si el conocimiento pertenece al nivel arquitectónico o de conocimiento del proyecto.

8. ¿Está desactualizado o contradice el código?

   * Verificar antes de eliminarlo. Si la información sigue siendo válida, actualizar el comentario.

**La limpieza de comentarios no equivale a eliminación masiva de comentarios.**

---

# Jerarquía de documentación

El conocimiento debe vivir en el nivel más apropiado.

```text
Código
│
├── WHAT / HOW
│   └── Código y nombres
│
├── CONTRACT
│   └── JSDoc / docstring / convención equivalente
│
├── WHY
│   └── Comentario inline
│
├── BUSINESS RULE
│   └── Comentario + documentación de dominio cuando corresponda
│
└── ARCHITECTURE / KNOWLEDGE
    └── brain-kms / documentación del proyecto
```

Regla práctica:

> **Cuanto más transversal y permanente sea el conocimiento, más arriba debe vivir.**

Ejemplos:

```text
"Esta función recibe un UUID"
→ JSDoc

"Este workaround existe por un bug de ExtJS"
→ Comentario inline

"Usamos Supabase para esta arquitectura"
→ brain-kms / documentación

"Hay que cambiar esta implementación cuando llegue backend #142"
→ TODO + issue/referencia

"Esta variable contiene el usuario"
→ No necesita comentario; el código debe ser explícito.
```

---

# Documentación de contratos

Utilizar la convención de documentación estándar del lenguaje cuando exista.

Para JavaScript utilizar **JSDoc**.

Para PHP utilizar **PHPDoc**.

Para Python utilizar **docstrings**.

Para otros lenguajes, utilizar la convención idiomática correspondiente en lugar de inventar una sintaxis propia.

## JavaScript / JSDoc

Utilizar JSDoc para:

* funciones públicas;
* métodos públicos;
* clases;
* módulos reutilizados por otros módulos;
* funciones cuya entrada o salida no sea evidente;
* funciones con efectos secundarios relevantes;
* funciones que interactúan con APIs externas;
* funciones que implementan reglas de negocio relevantes;
* funciones que puedan lanzar errores cuyo comportamiento sea importante conocer.

Ejemplo:

```javascript
/**
 * Obtiene el usuario asociado al identificador proporcionado.
 *
 * @param {string} id - Identificador UUID del usuario.
 * @returns {Promise<Object|null>} Usuario encontrado o null si no existe.
 * @throws {Error} Si Supabase devuelve un error.
 */
async function getUser(id) {
    const { data, error } = await supabase
        .from('users')
        .select('*')
        .eq('id', id)
        .maybeSingle();

    if (error) {
        throw error;
    }

    return data;
}
```

## JSDoc no debe convertirse en ruido

No documentar artificialmente cada función trivial.

Evitar:

```javascript
/**
 * Suma dos números.
 *
 * @param {number} a - Primer número.
 * @param {number} b - Segundo número.
 * @returns {number} La suma.
 */
function add(a, b) {
    return a + b;
}
```

si el proyecto no requiere esa documentación para una API pública.

El objetivo es documentar **contratos relevantes**, no llenar el código de texto redundante.

---

# Comentarios inline

Los comentarios inline deben utilizarse principalmente para explicar:

* decisiones no obvias;
* reglas de negocio;
* workarounds;
* limitaciones de frameworks o librerías;
* restricciones de seguridad;
* restricciones de rendimiento;
* compatibilidad;
* razones para no utilizar una alternativa aparentemente mejor;
* comportamiento externo que condiciona la implementación.

## Ejemplo: decisión de framework

```javascript
// No usamos store.load() aquí porque ExtJS dispara una segunda consulta
// mediante el proxy configurado. loadData() permite utilizar el resultado
// ya obtenido y mantener una única petición a Supabase.
store.loadData(data);
```

## Ejemplo: regla de negocio

```javascript
// Las incidencias cerradas durante el día actual siguen siendo visibles
// hasta el cierre operacional de las 00:00.
const visibleIncidencias = filterIncidencias(incidencias);
```

## Ejemplo: restricción de seguridad

```javascript
// Mantener la selección explícita de columnas.
// Las políticas RLS dependen de que esta consulta no exponga columnas
// adicionales mediante select('*').
const { data, error } = await supabase
    .from('incidencias')
    .select('id, estado, fecha, autopista_id');
```

Estos comentarios deben conservarse durante refactorizaciones mientras la razón que documentan siga siendo válida.

---

# Comentarios que NO deben utilizarse

No utilizar comentarios para narrar el código línea por línea.

Evitar:

```javascript
// Crear store
const store = new Ext.data.Store();

// Crear proxy
const proxy = new Ext.data.proxy.Ajax(...);

// Cargar datos
store.loadData(data);

// Retornar datos
return data;
```

El código ya comunica esas acciones.

Preferir:

```javascript
const store = new Ext.data.Store();

const proxy = new Ext.data.proxy.Ajax(...);

// Usamos loadData() para evitar una segunda petición generada por ExtJS.
store.loadData(data);

return data;
```

---

# Reglas de negocio

Cuando una implementación depende de una regla de negocio que no resulta evidente desde el código, documentarla.

Ejemplo:

```javascript
// Una incidencia cerrada no se elimina inmediatamente porque debe seguir
// disponible durante el período de revisión operacional.
if (incidencia.estado === 'cerrada') {
    return;
}
```

Si la regla es suficientemente importante o transversal como para afectar varias partes del sistema, considerar mover su definición a:

* `SPEC.md`;
* `brain-kms`;
* documentación de dominio;
* otro documento definido por `spec-driven-development`.

El comentario puede permanecer como contexto local, pero no debe convertirse en la única fuente de verdad de una regla crítica.

---

# Workarounds y HACK

Los workarounds deben documentar **por qué existen**.

Preferir:

```javascript
// HACK: ExtJS inicializa el ViewModel después del ciclo de render.
// defer permite acceder al estado una vez que el componente está listo.
Ext.defer(() => {
    initializeViewModel();
}, 1);
```

sobre:

```javascript
// HACK
Ext.defer(() => {
    initializeViewModel();
}, 1);
```

Cuando exista una referencia externa, agregarla:

```javascript
// HACK: ExtJS 6.2 no conserva el valor vacío del filtro.
// Ver issue #142.
```

Un `HACK` sin contexto tiene poco valor para un futuro desarrollador o agente.

---

# TODO / FIXME / HACK / NOTE

Estos marcadores tienen significados diferentes y no deben utilizarse indistintamente.

### TODO

Trabajo pendiente conocido.

```javascript
// TODO: Migrar esta consulta al RPC cuando backend #142 esté desplegado.
```

### FIXME

Problema conocido que debería corregirse.

```javascript
// FIXME: Esta conversión pierde milisegundos cuando recibe timestamps
// con zona horaria distinta de UTC.
```

### HACK

Solución deliberadamente no ideal necesaria por una restricción externa.

```javascript
// HACK: ExtJS requiere ejecución diferida para que el ViewModel exista.
```

### NOTE

Información importante que no corresponde a una tarea pendiente.

```javascript
// NOTE: Mantener selección explícita de columnas porque la política RLS
// depende de esta consulta.
```

Cuando sea posible, asociar `TODO` y `FIXME` con un issue, ticket o referencia concreta.

---

# Comentarios obsoletos

Un comentario incorrecto es peor que no tener comentario.

Cuando el código cambia, verificar si los comentarios relacionados siguen describiendo la realidad.

Si un comentario está desactualizado:

1. actualizarlo si la razón sigue siendo válida;
2. eliminarlo si la razón dejó de existir;
3. moverlo a `brain-kms` si su alcance ya no es local.

No conservar comentarios únicamente porque "siempre estuvieron ahí".

---

# Refactorización y limpieza

Antes de realizar una limpieza de comentarios:

```text
Comentario
    │
    ├── ¿Describe código obvio?
    │       └── ELIMINAR
    │
    ├── ¿Describe contrato?
    │       └── CONSERVAR / MEJORAR
    │
    ├── ¿Explica WHY?
    │       └── CONSERVAR
    │
    ├── ¿Explica regla de negocio?
    │       └── CONSERVAR
    │
    ├── ¿Explica workaround?
    │       └── CONSERVAR
    │
    ├── ¿Explica seguridad/rendimiento?
    │       └── CONSERVAR
    │
    └── ¿Explica arquitectura?
            └── CONSERVAR O MOVER A brain-kms
```

**Nunca ejecutar una limpieza indiscriminada de comentarios basada solamente en cantidad o longitud.**

Una función con muchos comentarios puede necesitar refactorización del código, no simplemente eliminación de documentación.

---

# Ejemplo completo

```javascript
/**
 * Actualiza el estado de una incidencia.
 *
 * @param {string} incidenciaId - UUID de la incidencia.
 * @param {string} estado - Nuevo estado de la incidencia.
 * @returns {Promise<Object>} Incidencia actualizada.
 * @throws {Error} Si Supabase devuelve un error.
 */
async function updateIncidencia(incidenciaId, estado) {
    // Las mutaciones de incidencias se centralizan aquí para evitar
    // que los ViewModels accedan directamente a Supabase.
    const { data, error } = await supabase
        .from('incidencias')
        .update({ estado })
        .eq('id', incidenciaId)
        .select()
        .single();

    if (error) {
        throw error;
    }

    return data;
}
```

El JSDoc documenta el **contrato**.

El comentario inline documenta el **por qué arquitectónico local**.

El código documenta el **cómo**.

---

# Aplicación a ExtJS + Supabase

En proyectos que utilicen ExtJS, HTML, CSS y Supabase:

### JavaScript / ExtJS

Utilizar JSDoc para contratos y comentarios inline para:

* comportamiento particular de ExtJS;
* ciclos de vida;
* eventos no evidentes;
* workarounds;
* decisiones de Store/Model/ViewModel;
* interacciones entre componentes;
* razones para evitar mecanismos aparentemente equivalentes.

### Supabase

Documentar:

* reglas de seguridad relevantes;
* consultas cuyo comportamiento no sea evidente;
* decisiones de selección de columnas;
* RPCs;
* dependencias con RLS;
* transformaciones de datos;
* workarounds de la API.

### HTML

Los comentarios deben limitarse a estructura cuando sea útil:

```html
<!-- Formulario de filtros de incidencias -->
<section class="incidencias-filters">
```

No comentar cada elemento:

```html
<!-- Input -->
<input>

<!-- Botón -->
<button>Buscar</button>
```

### CSS

Utilizar comentarios para separar componentes o secciones cuando el archivo lo justifique:

```css
/* --------------------------------------------------------------------------
   Incidencias
   -------------------------------------------------------------------------- */

.incidencias-list {
    /* ... */
}
```

No comentar reglas CSS individuales cuyo propósito sea evidente.

---

# Regla de decisión

Ante cualquier comentario nuevo o existente, preguntar:

> **¿Qué conocimiento se perdería si elimino este comentario?**

Si la respuesta es:

> "Ninguno; el código ya lo explica."

→ eliminar.

Si la respuesta es:

> "La razón de esta implementación."

→ conservar.

Si la respuesta es:

> "Una regla de negocio."

→ conservar y evaluar si también pertenece a `SPEC.md` o `brain-kms`.

Si la respuesta es:

> "Una decisión arquitectónica."

→ conservar como contexto local y evaluar si también corresponde a `brain-kms`.

Si la respuesta es:

> "Un problema temporal que debemos resolver."

→ utilizar `TODO`, `FIXME` o equivalente y asociarlo a una referencia cuando sea posible.

---

# Principio final

> **No buscamos más comentarios. Buscamos menos conocimiento perdido.**

Un código limpio no es un código sin comentarios.

Un código limpio es un código donde:

* el código expresa claramente lo que hace;
* los comentarios explican lo que el código no puede explicar;
* las reglas de negocio están preservadas;
* las decisiones importantes tienen contexto;
* la arquitectura y el conocimiento transversal están documentados en `brain-kms` cuando corresponde;
* y un agente puede refactorizar sin destruir conocimiento accidentalmente.
