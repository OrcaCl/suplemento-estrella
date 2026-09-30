# ADR-008 — `ward` y `listeilor` reemplazan a `checkpoint`; SPEC.md con tope por líneas y cerrados ordenados por ID

**Estado:** Vigente
**Fecha:** 2026-09-30

## Contexto

INT-001 (pedido de corrección recibido desde el proyecto "paciente cero", donde nació como INT-004) documentó que `SPEC.md` se degradó hasta 134 KB (55 filas de sesión, footer atrasado meses, 18+ `- [ ]` fuera de §3, `spec/completado.md` abandonado desde mayo) pese al fix de 0.10.1 / ADR-006. Causas: un `checkpoint` local tapaba al del plugin, el plugin se contradecía ("registro inmediato" vs "diferido"), el tope de 15 KB era irreal y su chequeo era prosa, y `completado.md` no guardaba ID ni evidencia.

Al implementarlo, el autor corrigió varias propuestas de INT-001: el plugin **no debe traer código** (es metodología), su regla original de tamaño era por **líneas** (~1000), no por KB, y propuso un nombre nuevo para el comando.

**Opciones evaluadas:**
1. Implementar INT-001 tal cual: script `check_spec.sh` con hook pre-commit, tope en KB configurable, `checkpoint` con aviso de colisión.
2. Implementar el objetivo de INT-001 sin código: control por lectura, tope por líneas, comandos renombrados.
3. No cambiar nada y dejar que cada proyecto resuelva su propia normalización.

## Decisión

Se adopta la opción 2 (publicada como `suplemento-core` 0.12.0 y runtime Gemini 0.1.3):

1. **`checkpoint` se divide y se renombra.** `ward` = todo lo que hacía `checkpoint`, sin push. `listeilor` = cierre de sesión: verifica respaldo, revisa pendientes faltantes, commit + push. El nombre nuevo además elimina la colisión con el `checkpoint.md` local que tapaba al del plugin; `checkpoint` queda como alias deprecado. El aviso de colisión vive también en `documentation-convention`, porque un comando local que tapa al del plugin impide que este se ejecute para avisar.
2. **El plugin no incluye scripts.** Se eliminó `check_spec.sh` (y su hook). El tope de **1000 líneas** (`spec_tope_lineas`, aviso al 80 %) se controla al leer `SPEC.md` al abrir sesión y con una lista de verificación en `ward`/`listeilor` antes del commit. Se mantiene el límite de 600 caracteres por línea. Este tope reemplaza al de ~15 KB de ADR-006.
3. **`spec/cerrados.md`, nombre fijo**, reemplaza a `spec/completado.md` (que se depreca con aviso, sin borrarse). Cada cerrado conserva **el ID que traía en la lista de pendientes**, con fecha y evidencia verificable, y se inserta **ordenado por ID**, no por orden de llegada.
4. **Lista única de pendientes:** §3 es el único lugar de ítems abiertos, con ID estable no reutilizable.
5. **`registro: diferido | inmediato`** (defecto `diferido`) reconcilia la contradicción entre `spec-driven-development` y `documentation-convention`. Configuración por proyecto reducida a tres claves: `registro`, `spec_tope_lineas`, `sesiones_anteriores_en_spec`.
6. **`spec/historial.md` sale de las plantillas** de `project-init` (ya estaba deprecado).

## Razones

1. La opción 1 metía código ejecutable en un plugin que es solo metodología; el autor lo rechazó explícitamente.
2. La regla por líneas es la original del autor y es más fácil de controlar al leer el archivo que un conteo de bytes.
3. Un nombre propio (`ward`) evita la colisión de raíz en vez de detectarla; separar `ward` de `listeilor` hace explícito cuándo hay push.
4. Ordenar `cerrados.md` por ID evita buscar adelante y atrás; conservar el ID original mantiene cruzables los ADR y sesiones que citan "ítem N".
5. La opción 3 dejaba el problema a cada proyecto consumidor, que es justo lo que falló.

## Consecuencias

- **Riesgo aceptado:** sin script, el control de tamaño depende de que Code revise la lista; INT-001 §2.4 advertía que la prosa puede omitirse bajo presión. Si `SPEC.md` vuelve a degradarse en uso real, reabrir esta decisión (un script opcional **fuera** del plugin sería la vía).
- **Cambio de comportamiento:** `ward` ya no hace push; solo `listeilor` lo hace.
- Desvíos respecto de INT-001 §3: sin `check_spec.sh` ni hook, sin skill/subcomando `spec-audit`, sin clave `archivo_cerrados` (nombre fijo; el proyecto de origen renombra `catastro-historico.md` a mano), sin clave `ids_en_pendientes` (los IDs vienen en la plantilla), tope en líneas y no en KB.
- Los proyectos existentes requieren migración manual: `skills/spec-driven-development/references/migracion-0.12.md` (y `normalizacion-spec.md` para un SPEC degradado).
- ADR-006 sigue vigente en su regla de fondo (SPEC.md se reemplaza, no se acumula); solo su tope de tamaño queda reemplazado por el de este ADR.
- Este repo migra su propio `SPEC.md` (versión 0.12.0, §3 con IDs) y crea `spec/cerrados.md`.

## Commit

Ver entrada "Sesión — 2026-09-30 — ward/listeilor, SPEC por líneas y cerrados por ID (0.12.0)" en `brain/sesiones.md`. Cambios de código en los commits `b8e8d6e` (release inicial), `f82fcb1` (sin script, cerrados por ID) y el commit de registro de esta sesión.
