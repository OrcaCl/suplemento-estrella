---
name: spec-driven-development
description: Disciplina de trabajo diario con SPEC.md y la carpeta spec/ como fuente de verdad del proyecto. Úsala siempre que el usuario pida una tarea de desarrollo nueva, al iniciar cualquier sesión de trabajo (leer SPEC.md primero), al registrar avances en SPEC.md y spec/ (según el modo de registro del proyecto), al cerrar un ítem de pendientes, o cuando haya que decidir en qué archivo va cada pieza de información. También aplica cuando spec/historial.md empieza a crecer demasiado y hay que evaluar si el proyecto necesita escalar a brain/ ADR.
---

# Spec-Driven Development

Cómo trabajar día a día una vez que el proyecto ya tiene `SPEC.md` + `spec/` (creados por la skill `project-init`). Esta skill no crea estructura — gobierna el flujo de lectura/escritura sobre la estructura que ya existe.

## Configuración del proyecto

Los proyectos ajustan esta skill con líneas `clave: valor` en su `CLAUDE.md` (sección "Configuración de SPEC"). Sin la línea, rige el valor por defecto. `scripts/check_spec.sh` lee las mismas claves.

| Clave | Por defecto | Qué controla |
|---|---|---|
| `registro` | `diferido` | Cuándo se registra en `SPEC.md`/`spec/`/`brain/`: `diferido` (en `ward` o `listeilor`) o `inmediato` (tras cada breakthrough) |
| `spec_tope_lineas` | `1000` | Tope de líneas de `SPEC.md`. Error al superarlo, advertencia al 80 % |
| `sesiones_anteriores_en_spec` | `0` | Cuántas filas "Sesión anterior" (≤ 2 líneas, ≤ 600 caracteres cada una) se conservan en la §2 |
| `archivo_cerrados` | `spec/cerrados.md` | El **único** archivo donde viven los ítems cerrados |
| `ids_en_pendientes` | `false` | `true` = cada ítem de §3 lleva un ID estable y único; el chequeo pasa a ser obligatorio |

Un tope irreal se ignora: si el tope no calza con el proyecto, se **ajusta** la clave — no se apaga el chequeo ni se deja crecer el archivo sin límite.

## Regla de apertura de sesión

Antes de cualquier acción, leer `SPEC.md` completo y confirmar contexto con el mensaje exacto definido en `CLAUDE.md`:

```
✅ Contexto cargado — SPEC.md v[VERSION]
| Próximo paso: [PRIMER_ITEM_PENDIENTE]
```

Si el proyecto tiene tests, se agrega el segmento `[N] tests |` antes de `Próximo paso`; si no los tiene, se omite.

No empezar a trabajar sin esta confirmación — es la forma de detectar temprano si `SPEC.md` está desactualizado respecto al estado real del código (ver "Detección de inconsistencias" más abajo).

## Cuándo se registra — depende de `registro`

Qué se actualiza en cada registro (igual en ambos modos):

1. `SPEC.md` — reemplazar (no acumular) según "Reemplazar, no acumular": sacar de la §3 los ítems cerrados (ver "Regla de cierre de un ítem"), sobrescribir la fila "Última sesión" de la §2 y el footer
2. El archivo de cerrados — agregar la entrada del ítem cerrado
3. `spec/historial.md` — solo en estructura simple (sin `brain/`); con `brain/`, la narrativa va a `brain/sesiones.md`
4. Si el proyecto usa `brain/`: evaluar si esto amerita un ADR/INT/NOC/DEP nuevo (ver skill `brain-kms`)

Cuándo ocurre:

- **`registro: diferido` (por defecto, y siempre que el proyecto use `ward`/`listeilor`):** se registra solo al ejecutar `ward` o al cerrar sesión con `listeilor` — nunca por iniciativa de Code a mitad del trabajo. Ver skill `documentation-convention`.
- **`registro: inmediato`:** tras cada breakthrough (feature completada, bug crítico resuelto, migración ejecutada), antes de seguir con la siguiente tarea. Aun así, el cierre de sesión (`listeilor`) sigue siendo obligatorio.

Si el proyecto usa `ward`/`listeilor` y no declara `registro`, es `diferido`. **No mezclar modos:** una regla de "no esperar al cierre" solo aplica si el proyecto declaró `registro: inmediato`.

## Dónde va cada cosa — tabla de decisión

| Si estás documentando... | Va en... |
|---|---|
| Estado actual resumido, pendientes activos, reglas no negociables | `SPEC.md` |
| Cómo hablar con una API/sistema externo | `spec/api.md` |
| Que una tarea se cerró (ID, fecha, evidencia) | El archivo de cerrados (`spec/cerrados.md` por defecto) |
| Por qué se completó de esa forma, qué se descubrió en el camino | `spec/historial.md` (estructura simple) o `brain/sesiones.md` |
| Una convención, diccionario, o dato de referencia (nunca secretos) | `spec/datos.md` |
| Un ítem de backlog, venga del usuario o sugerido por el agente | `spec/{{objetivos}}.md` |
| Una decisión de arquitectura costosa de revertir | `brain/ADR-NNN.md` (solo si el proyecto usa estructura completa) |
| Una pregunta tangencial, no urgente, para otra audiencia | `TOASK.md` en la raíz del proyecto (solo estructura completa) |

Si algo no encaja claramente en una fila, es señal de que puede necesitar su propio archivo dentro de `spec/` — pero antes de crear uno nuevo, confirmar con el usuario. No expandir la estructura de archivos sin esa confirmación.

## Árbitro de destino — qué NUNCA va en SPEC.md

`SPEC.md` es un panel de control, no una bitácora. Un proyecto real pasó de 5 KB a 134 KB en cuatro meses porque cada checkpoint agregaba un bloque nuevo sin borrar el anterior. Al actualizarlo, cada tipo de contenido tiene un solo destino:

| Qué | Dónde | Qué queda en `SPEC.md` |
|---|---|---|
| Narrativa de la sesión, hallazgos, el "por qué" | `brain/sesiones.md` (o `spec/historial.md` en estructura simple) | Nada — ni en el header, ni en el footer, ni en una fila (salvo las N filas de `sesiones_anteriores_en_spec`) |
| Ítem cerrado | El archivo de cerrados (ID + fecha + evidencia) | Nada — sale de la §3 |
| Detalle técnico de un componente | `spec/features.md` | 1 fila por componente en la §7, sin detalle |
| Schema de API o hallazgo de integración | `spec/api.md` | Solo el puntero |
| Decisión de arquitectura, proceso o riesgo | `brain/ADR\|INT\|NOC-*.md` + `brain/index.md` | Solo el puntero, en la §5 |
| Planes de sesiones pasadas | El archivo de cerrados o `spec/historial.md` | Nada |

## Reemplazar, no acumular

- **"Última actualización"** (header) = solo la fecha.
- **"Última sesión"** (§2) = 1 fila de ≤ ~400 caracteres que **sobrescribe** la anterior.
- **Filas "Sesión anterior"** (§2): por defecto ninguna (`sesiones_anteriores_en_spec: 0`). Si el proyecto declara N, se conservan **exactamente N**, cada una ≤ 2 líneas y ≤ 600 caracteres; al entrar una nueva, la más antigua sale y queda solo en `brain/sesiones.md`. Prohibidos los bloques "Antes (fecha) — …".
- **Footer** = **una línea** ≤ ~300 caracteres: versión + fecha + métricas clave del dominio (p. ej. conteo de tests **si** el proyecto tiene tests). No es una bitácora. La versión del footer coincide con la de la cabecera.

## Lista única de pendientes

**La §3 es el único lugar donde existen ítems abiertos.** Está prohibido tener en `SPEC.md`:

- secciones "Próxima sesión", "Prioridad N", "Pendientes de X" o equivalentes fuera de la §3
- checkboxes `- [ ]` fuera de la §3

La §3 puede ordenarse por prioridad (Alta / Media / Baja / Externo), una línea de contexto por ítem. Los planes de sesiones pasadas van al archivo histórico, no a `SPEC.md`.

**IDs estables:** un ítem conserva su ID hasta cerrarse y **el ID no se reutiliza jamás**; los ítems nuevos siguen la numeración. Es lo que permite que un ADR o una sesión cite "ítem 62" y el dato siga siendo verificable. Con `ids_en_pendientes: true`, el script rechaza ítems sin ID o con ID duplicado.

## Regla de cierre de un ítem

Cerrar un ítem son tres movimientos, siempre juntos:

1. **Borrar su fila de la §3** (no marcarla `[x]` y dejarla ahí — un cerrado en §3 es un ítem "fantasma").
2. **Pegarla en el archivo de cerrados** con este formato:
   `**ID — ✅ CERRADO (fecha)[, motivo].** Título. 1–2 frases de qué se hizo (o por qué se descartó) + evidencia medible.`
3. **Agregar el ID a la lista de cerrados** que la §3 mantiene como puntero (una línea: "Cerrados: 3, 5, 12…").

**Evidencia obligatoria y verificable.** Cerrar por "ya estaba hecho" exige un dato comprobable: una consulta con su resultado, un test que pasa, un commit. "Se implementó" no basta — un ítem figuró "CERRADO" mientras la columna que debía poblar seguía en `false` en las 262.860 filas de la base, y nadie lo notó porque la verificación quedó enterrada en narrativa.

`spec/completado.md` (proyectos de 0.11 o anteriores) queda **deprecado**: se marca con un aviso apuntando al archivo de cerrados y no se borra su contenido. Ver `references/migracion-0.12.md`.

## Tope de tamaño — chequeo mecánico, no recordatorio

`SPEC.md` no debe pasar de `spec_tope_lineas` líneas (por defecto **1000**) ni tener ninguna línea de más de 600 caracteres. El chequeo es un script, no una promesa: `scripts/check_spec.sh` (dentro del plugin) sale con código ≠ 0 si el `SPEC.md` excede algún tope, y `--report` audita sin bloquear. Lo corren `ward` y `listeilor` antes de cada commit; un hook `pre-commit` opcional lo hace cumplir también fuera de esos comandos (ver `references/migracion-0.12.md`).

Si el script falla, condensar y mover el contenido a su destino según la tabla de arriba **antes** del commit. No commitear un `SPEC.md` excedido.

## Detección de inconsistencias entre SPEC.md y el código real

`SPEC.md` puede desincronizarse del estado real del proyecto — por ejemplo, una sección de pendientes con checkboxes sin marcar que en realidad ya se completaron hace varias sesiones, o ítems cerrados que nunca salieron de la §3.

Cuando se detecta una inconsistencia de este tipo:
1. No asumir silenciosamente cuál versión es la correcta — confirmar con el usuario.
2. Una vez confirmado, corregir `SPEC.md` en el registro (de inmediato si `registro: inmediato`; en el próximo `ward` o `listeilor` si es `diferido`), verificando el ítem contra código o datos reales antes de dejarlo abierto o cerrado.
3. Si la sección quedó inconsistente por haber evolucionado en varios pasos (ADR tras ADR, por ejemplo), documentar en `spec/historial.md` o en el ADR correspondiente que hubo una corrección de documentación, con fecha — para que quede trazable que el código iba bien y era la documentación la que estaba atrás, no al revés.

Para un `SPEC.md` ya degradado (cientos de KB, decenas de filas de sesión, pendientes dispersos), seguir `references/normalizacion-spec.md`.

## Señal de que el proyecto necesita escalar a brain/

El archivo de cerrados + `spec/historial.md` cumplen la función de un sistema de decisiones mientras el proyecto es chico. Señales de que conviene escalar a `brain/` (si el proyecto no lo tenía desde el inicio):

- `spec/historial.md` supera un tamaño que empieza a consumir contexto de forma notoria en cada sesión
- Han aparecido 3+ decisiones de arquitectura que valdría la pena poder referenciar individualmente por ID en vez de tener que buscarlas dentro de una narrativa larga
- El proyecto empezó a integrar con un segundo sistema externo o ganó un segundo colaborador (humano o agente) trabajando en paralelo

Si se detecta esta señal, proponerlo al usuario explícitamente — no migrar la estructura sin confirmación. Ver skill `brain-kms` para el proceso de migración.

## Relación con el "modo de trabajo secuencial"

Spec-driven development asume que las tareas se ejecutan una a la vez, confirmando con el usuario antes de avanzar al siguiente paso — coherente con el modo de trabajo secuencial ya definido en `CLAUDE.md`. No usar esta skill como excusa para lanzar trabajo en paralelo sobre múltiples secciones de `SPEC.md` a la vez.
