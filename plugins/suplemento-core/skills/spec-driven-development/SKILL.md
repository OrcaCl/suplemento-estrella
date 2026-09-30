---
name: spec-driven-development
description: Disciplina de trabajo diario con SPEC.md y la carpeta spec/ como fuente de verdad del proyecto. Úsala siempre que el usuario pida una tarea de desarrollo nueva, al iniciar cualquier sesión de trabajo (leer SPEC.md primero), al registrar avances en SPEC.md y spec/ (según el modo de registro del proyecto), al cerrar un ítem de pendientes, o cuando haya que decidir en qué archivo va cada pieza de información. También aplica cuando aparece un proyecto heredado sin brain/ y hay que evaluar si necesita escalar.
---

# Spec-Driven Development

Cómo trabajar día a día una vez que el proyecto ya tiene `SPEC.md` + `spec/` (creados por la skill `project-init`). Esta skill no crea estructura — gobierna el flujo de lectura/escritura sobre la estructura que ya existe.

## Configuración del proyecto

Los proyectos ajustan esta skill con líneas `clave: valor` en su `CLAUDE.md` (sección "Configuración de SPEC"). Sin la línea, rige el valor por defecto.

| Clave | Por defecto | Qué controla |
|---|---|---|
| `registro` | `diferido` | Cuándo se registra en `SPEC.md`/`spec/`/`brain/`: `diferido` (en `ward` o `listeilor`) o `inmediato` (tras cada breakthrough) |
| `spec_tope_lineas` | `1000` | Tope de líneas de `SPEC.md`. Al superarlo hay que condensar; al llegar al 80 % se avisa |
| `sesiones_anteriores_en_spec` | `0` | Cuántas filas "Sesión anterior" (≤ 2 líneas, ≤ 600 caracteres cada una) se conservan en la §2 |

Un tope irreal se ignora: si no calza con el proyecto, se **ajusta** la clave — no se deja crecer el archivo sin límite.

## Regla de apertura de sesión

Antes de cualquier acción, leer `SPEC.md` completo y confirmar contexto con el mensaje exacto definido en `CLAUDE.md`:

```
✅ Contexto cargado — SPEC.md v[VERSION]
| Próximo paso: [PRIMER_ITEM_PENDIENTE]
```

Si el proyecto tiene tests, se agrega el segmento `[N] tests |` antes de `Próximo paso`; si no los tiene, se omite.

**Control de tamaño al leer:** la lectura informa cuántas líneas tiene `SPEC.md`. Si supera `spec_tope_lineas` (1000 por defecto), avisar al humano antes de seguir y proponer condensarlo (ver `references/normalizacion-spec.md`); si está al 80 % o más, mencionarlo. Es el único control de tamaño: no hay script.

No empezar a trabajar sin esta confirmación — es la forma de detectar temprano si `SPEC.md` está desactualizado respecto al estado real del código (ver "Detección de inconsistencias" más abajo).

## Cuándo se registra — depende de `registro`

Qué se actualiza en cada registro (igual en ambos modos):

1. `SPEC.md` — reemplazar (no acumular) según "Reemplazar, no acumular": sacar de la §3 los ítems cerrados (ver "Regla de cierre de un ítem"), sobrescribir la fila "Última sesión" de la §2 y el footer
2. El archivo de cerrados — agregar la entrada del ítem cerrado
3. `brain/sesiones.md` — la narrativa de lo ocurrido
4. Evaluar si esto amerita un ADR/INT/NOC/DEP nuevo (ver skill `brain-kms`)

Cuándo ocurre:

- **`registro: diferido` (por defecto, y siempre que el proyecto use `ward`/`listeilor`):** se registra solo al ejecutar `ward` o al cerrar sesión con `listeilor` — nunca por iniciativa de Code a mitad del trabajo. Ver skill `documentation-convention`.
- **`registro: inmediato`:** tras cada breakthrough (feature completada, bug crítico resuelto, migración ejecutada), antes de seguir con la siguiente tarea. Aun así, el cierre de sesión (`listeilor`) sigue siendo obligatorio.

Si el proyecto usa `ward`/`listeilor` y no declara `registro`, es `diferido`. **No mezclar modos:** una regla de "no esperar al cierre" solo aplica si el proyecto declaró `registro: inmediato`.

## Dónde va cada cosa — tabla de decisión

| Si estás documentando... | Va en... |
|---|---|
| Estado actual resumido, pendientes activos, reglas no negociables | `SPEC.md` |
| Cómo hablar con una API/sistema externo | `spec/api.md` |
| Que una tarea se cerró (ID, fecha, evidencia) | `spec/cerrados.md` |
| Por qué se completó de esa forma, qué se descubrió en el camino | `brain/sesiones.md` |
| Una convención, diccionario, o dato de referencia (nunca secretos) | `spec/datos.md` |
| Un ítem de backlog, venga del usuario o sugerido por el agente | `spec/{{objetivos}}.md` |
| Una decisión de arquitectura costosa de revertir | `brain/ADR-NNN.md` |
| Una pregunta tangencial, no urgente, para otra audiencia | `TOASK.md` en la raíz del proyecto |

Si algo no encaja claramente en una fila, es señal de que puede necesitar su propio archivo dentro de `spec/` — pero antes de crear uno nuevo, confirmar con el usuario. No expandir la estructura de archivos sin esa confirmación.

## Árbitro de destino — qué NUNCA va en SPEC.md

`SPEC.md` es un panel de control, no una bitácora. Un proyecto real pasó de 5 KB a 134 KB en cuatro meses porque cada checkpoint agregaba un bloque nuevo sin borrar el anterior. Al actualizarlo, cada tipo de contenido tiene un solo destino:

| Qué | Dónde | Qué queda en `SPEC.md` |
|---|---|---|
| Narrativa de la sesión, hallazgos, el "por qué" | `brain/sesiones.md` | Nada — ni en el header, ni en el footer, ni en una fila (salvo las N filas de `sesiones_anteriores_en_spec`) |
| Ítem cerrado | `spec/cerrados.md` (ID + fecha + evidencia) | Nada — sale de la §3 |
| Detalle técnico de un componente | `spec/features.md` | 1 fila por componente en la §7, sin detalle |
| Schema de API o hallazgo de integración | `spec/api.md` | Solo el puntero |
| Decisión de arquitectura, proceso o riesgo | `brain/ADR\|INT\|NOC-*.md` + `brain/index.md` | Solo el puntero, en la §5 |
| Planes de sesiones pasadas | `spec/cerrados.md` o `brain/sesiones.md` | Nada |

## Reemplazar, no acumular

- **"Última actualización"** (header) = solo la fecha.
- **"Última sesión"** (§2) = 1 fila de ≤ ~400 caracteres que **sobrescribe** la anterior.
- **Filas "Sesión anterior"** (§2): por defecto ninguna (`sesiones_anteriores_en_spec: 0`). Si el proyecto declara N, se conservan **exactamente N**, cada una ≤ 2 líneas y ≤ 600 caracteres; al entrar una nueva, la más antigua sale y queda solo en `brain/sesiones.md`. Prohibidos los bloques "Antes (fecha) — …".
- **Footer** = **una línea** ≤ ~300 caracteres: versión + fecha + métricas clave del dominio (p. ej. conteo de tests **si** el proyecto tiene tests). No es una bitácora. La versión del footer coincide con la de la cabecera.

## Lista única de pendientes

**La §3 es el único lugar donde existen ítems abiertos.** Está prohibido tener en `SPEC.md`:

- secciones "Próxima sesión", "Prioridad N", "Pendientes de X" o equivalentes fuera de la §3
- checkboxes `- [ ]` fuera de la §3

La §3 puede ordenarse por prioridad (Alta / Media / Baja / Externo), una línea de contexto por ítem. Los planes de sesiones pasadas van a `brain/sesiones.md`, no a `SPEC.md`.

**IDs estables:** todo ítem de la §3 lleva un ID (la plantilla de `SPEC.md` ya los trae). Un ítem conserva su ID hasta cerrarse y **el ID no se reutiliza jamás**; los ítems nuevos siguen la numeración. Es lo que permite que un ADR o una sesión cite "ítem 62" y el dato siga siendo verificable.

## Regla de cierre de un ítem

Cerrar un ítem son tres movimientos, siempre juntos:

1. **Borrar su fila de la §3** (no marcarla `[x]` y dejarla ahí — un cerrado en §3 es un ítem "fantasma").
2. **Pegarla en `spec/cerrados.md`**, con el **mismo ID que traía en la lista de pendientes** (nunca uno nuevo) y este formato:
   `**ID — ✅ CERRADO (fecha)[, motivo].** Título. 1–2 frases de qué se hizo (o por qué se descartó) + evidencia medible.`
   **Se inserta en su posición por ID ascendente, no al final:** el archivo se ordena por ID, no por orden de llegada, para encontrar un ID sin ir adelante y atrás.
3. **Agregar el ID a la lista de cerrados** que la §3 mantiene como puntero (una línea: "Cerrados: 3, 5, 12…").

**Evidencia obligatoria y verificable.** Cerrar por "ya estaba hecho" exige un dato comprobable: una consulta con su resultado, un test que pasa, un commit. "Se implementó" no basta — un ítem figuró "CERRADO" mientras la columna que debía poblar seguía en `false` en las 262.860 filas de la base, y nadie lo notó porque la verificación quedó enterrada en narrativa.

`spec/completado.md` (proyectos de 0.11 o anteriores) queda **deprecado**: se marca con un aviso apuntando a `spec/cerrados.md` y no se borra su contenido. Ver `references/migracion-0.12.md`.

## Tope de tamaño — se controla al leer

`SPEC.md` no debe pasar de `spec_tope_lineas` líneas (por defecto **1000**) ni tener ninguna línea de más de 600 caracteres. No hay script: el control ocurre en dos momentos.

1. **Al abrir la sesión:** la lectura informa cuántas líneas tiene el archivo (ver "Regla de apertura de sesión").
2. **En `ward` y `listeilor`, antes del commit:** Code revisa esta lista sobre el `SPEC.md` ya actualizado (puede apoyarse en `wc -l` o `awk` puntuales):
   - líneas ≤ `spec_tope_lineas`; ninguna línea > 600 caracteres
   - filas "Sesión anterior" = exactamente `sesiones_anteriores_en_spec`
   - footer de una sola línea (≤ ~300 caracteres) y con la misma versión que la cabecera
   - ningún `- [ ]` ni sección de pendientes fuera de la §3; ningún `[x]` dentro de la §3
   - IDs de la §3 sin duplicados

Si algo excede, condensar y mover el contenido a su destino según la tabla de arriba **antes** del commit. No commitear un `SPEC.md` excedido.

## Detección de inconsistencias entre SPEC.md y el código real

`SPEC.md` puede desincronizarse del estado real del proyecto — por ejemplo, una sección de pendientes con checkboxes sin marcar que en realidad ya se completaron hace varias sesiones, o ítems cerrados que nunca salieron de la §3.

Cuando se detecta una inconsistencia de este tipo:
1. No asumir silenciosamente cuál versión es la correcta — confirmar con el usuario.
2. Una vez confirmado, corregir `SPEC.md` en el registro (de inmediato si `registro: inmediato`; en el próximo `ward` o `listeilor` si es `diferido`), verificando el ítem contra código o datos reales antes de dejarlo abierto o cerrado.
3. Si la sección quedó inconsistente por haber evolucionado en varios pasos (ADR tras ADR, por ejemplo), documentar en `brain/sesiones.md` o en el ADR correspondiente que hubo una corrección de documentación, con fecha — para que quede trazable que el código iba bien y era la documentación la que estaba atrás, no al revés.

Para un `SPEC.md` ya degradado (cientos de KB, decenas de filas de sesión, pendientes dispersos), seguir `references/normalizacion-spec.md`.

## Proyectos heredados sin brain/

`project-init` crea `brain/` siempre. Si aparece un proyecto heredado que solo tiene `spec/` (sin `brain/`), proponer al usuario explícitamente migrarlo — no migrar la estructura sin confirmación. Señales: decisiones de arquitectura que valdría la pena referenciar por ID, un segundo sistema externo integrado, o un segundo colaborador (humano o agente). Ver skill `brain-kms` para el proceso de migración.

## Relación con el "modo de trabajo secuencial"

Spec-driven development asume que las tareas se ejecutan una a la vez, confirmando con el usuario antes de avanzar al siguiente paso — coherente con el modo de trabajo secuencial ya definido en `CLAUDE.md`. No usar esta skill como excusa para lanzar trabajo en paralelo sobre múltiples secciones de `SPEC.md` a la vez.
