# INT-001 — Checkpoint y SPEC.md: reemplazar, no acumular (pedido de corrección al plugin suplemento-core)

> **Nota de numeración:** nació como INT-004 en el proyecto `gestion-incidencias`; en este repo se registra como INT-001 (aquí solo existía INT-000). Las referencias a "INT-001" dentro del texto apuntan a la migración manual de ese otro proyecto.
>
> **Nota de alcance:** como los INT anteriores, este documento trata de cómo el humano y Code trabajan juntos (proceso y herramientas), no de la arquitectura del sistema de incidencias.
>
> **Destinatario:** la instancia de Claude Code que mantiene el plugin `suplemento-core` (marketplace `suplemento-estrella`). Este documento es autocontenido: no requiere acceso al repo `gestion-incidencias`.

**Estado:** propuesto (30 Sep 2026) · **Plugin observado:** `suplemento-core` 0.11.0 (el problema se originó bajo 0.10.x)

## 1. Qué pasó (evidencia medida en un proyecto real)

En `gestion-incidencias` (≈620 commits, proyecto con estructura completa `brain/` + `spec/`), el `SPEC.md` se degradó hasta dejar de cumplir su función de "índice ágil para arrancar una sesión". Medido el 30 Sep 2026, antes de normalizarlo:

| Síntoma | Medición |
|---|---|
| Tamaño de `SPEC.md` | ≈134 KB (~100.000 tokens); el `Read` de una pasada lo cortaba en el límite de 25.000 tokens |
| Filas "Sesión anterior" en §2 | 55 filas, varias de 15+ líneas, de mayo a septiembre |
| Footer | Seguía en "v7.56 · sesión 14 Ago" con 13 párrafos de sesiones; la versión real era 7.87 |
| Catastro de pendientes (§3) | 118 ítems numerados con cerrados y abiertos mezclados; varios cerrados sin marcar (ítems "fantasma") |
| Pendientes fuera del catastro | ≥18 checkboxes `- [ ]` repartidos en 8 secciones distintas (Prioridad 0–3, "Próxima sesión", FR-MAPA-001, INC-016, Normalización BD, Integridad Referencial, Coordinación con Pilot), varios duplicando o contradiciendo al catastro |
| `spec/completado.md` | Dejó de llenarse el **28 May 2026**; sin número de ítem, sin fecha de cierre, solo algunas fechas sueltas |
| Ítems abiertos sin registrar | ≥7 pendientes reales que solo existían en narrativa de sesiones (colas de ítems ya cerrados) |

Un ejemplo de por qué importa: el ítem 12 figuraba "✅ CERRADO" en el SPEC, pero la columna que debía poblar estaba en `false` en las 262.860 filas de la BD; nadie lo notó porque la verificación quedó enterrada en narrativa.

## 2. Causas raíz (todas en el diseño de proceso, no en el criterio del usuario)

1. **Comando local que tapa al del plugin.** El proyecto tiene `.claude/commands/checkpoint.md`, creado antes de 0.11 (migración manual de INT-001); **es el ancestro del comando del plugin (mismo linaje, no son dos diseños distintos)** y el plugin lo heredó ya mejorado, así que es la versión más pobre de las dos. Comparte nombre con `suplemento-core:checkpoint`. El del proyecto decía solo "marcar `[x]` y actualizar el footer con el conteo de tests" — el modelo antiguo que acumula. Bajo 0.11 el plugin ya tiene reglas mucho mejores (reemplazar, tope de tamaño, prohibidas las filas "Sesión anterior"), pero **la instancia seguía ejecutando el comando local viejo**. El plugin no detecta ni advierte esta colisión.
2. **`CLAUDE.md` del proyecto contradecía al plugin.** Su checklist pedía "2-4 líneas por sesión en la tabla de Estado actual" (lo que 0.11 prohíbe) y "marcar ítems como `[x]`" en lugar de sacarlos de §3.
3. **Contradicción interna del plugin.** La skill `spec-driven-development` dice "registro inmediato, no acumulado: actualizar de inmediato tras cada breakthrough, no esperar al cierre"; la skill `documentation-convention` y el comando `checkpoint` dicen registro **diferido** hasta `/checkpoint`. Un proyecto no puede cumplir ambas; el proyecto eligió diferido (INT-001) y la skill `spec-driven-development` quedó sin reconciliar.
4. **El chequeo de tamaño es prosa, no mecanismo.** 0.11 pide correr `wc -c SPEC.md` y `awk 'length>600'` "antes del commit", pero es un paso que el modelo puede omitir bajo presión o ejecutar tarde. No hay script, hook ni pre-commit que lo haga cumplir.
5. **El destino de los cerrados fue mal diseñado.** El plugin manda los ítems cerrados a `spec/completado.md` como "1 línea con fecha". En la práctica: sin ID no se puede cruzar con los `ADR`/sesiones que citan "ítem 62"; sin evidencia no sirve para verificar "¿esto ya se hizo?"; y al ser el paso más aburrido, es el que se dejó de hacer primero (28 May).
6. **Sin definición de "lista única".** Nada obliga a que los pendientes vivan solo en §3. Aparecieron secciones paralelas ("Próxima sesión", "Pendientes FR-…", listas dentro de otras secciones) que se desincronizaron.
7. **El tope de 15 KB es irreal para un proyecto maduro** y no admite configuración: o se ignora o obliga a borrar contexto útil. El proyecto necesitaba conservar las últimas sesiones para arrancar, cosa que 0.11 prohíbe de plano.

## 3. Cambios solicitados al plugin

**3.1 Comando `checkpoint`**
- Detectar al ejecutarse si existe `.claude/commands/checkpoint.md` en el proyecto (o cualquier comando/skill local con el mismo nombre) y **avisar al usuario** que tapa al del plugin, mostrando la diferencia de pasos. No sobrescribir sin confirmación.
- Paso de `SPEC.md`: reemplazar el destino de cerrados por el **archivo único de cerrados** (ver 3.3) y hacer explícita la regla de cierre: *borrar la fila de §3 → pegarla en el archivo de cerrados con ID + fecha + 1–2 frases de evidencia → agregar el ID a la lista de cerrados de §3*.
- Agregar un paso de **reconciliación de pendientes**: buscar `- [ ]` y listas de pendientes fuera de §3 y consolidarlas o marcarlas como obsoletas (ver 3.4).
- Al cerrar un ítem por "ya estaba hecho", exigir **evidencia verificable** (consulta, test o commit), no solo "se implementó". Caso del ítem 12.
- Hacer que el paso "Chequeo de tamaño" **falle de forma dura** (ver 3.5), no que sea un recordatorio.

**3.2 Skill `spec-driven-development`**
- Reconciliar la contradicción "registro inmediato" vs. "diferido": declarar explícitamente cuál aplica según el proyecto (p. ej. una línea en `CLAUDE.md`: `registro: diferido | inmediato`), con `diferido` cuando el proyecto usa `/checkpoint`. Quitar el texto "No esperar al cierre" cuando el modo es diferido.
- **Sesiones anteriores configurables**, no prohibidas: valor por defecto `0` (como hoy), pero permitir que el proyecto declare `sesiones_anteriores_en_spec: N` (el proyecto usa 3, ≤2 líneas cada una, ≤600 caracteres por línea). Todo lo anterior a esas N vive solo en `brain/sesiones.md`.
- Tope de tamaño configurable con default 15 KB y un umbral de **advertencia** (p. ej. 2× el tope) además del de error; documentar que un tope irreal se ignora y por tanto debe ajustarse, no eliminarse.
- Definir formalmente **"lista única de pendientes"**: §3 es el único lugar donde existen ítems abiertos. Prohibidas secciones "Próxima sesión", "Prioridad N", "Pendientes de X" y checkboxes `- [ ]` fuera de §3. Los planes de sesión pasados van al archivo histórico.
- Los IDs de ítems son **estables y no se reutilizan**; los ítems nuevos siguen la numeración.

**3.3 Archivo único de cerrados (reemplaza `spec/completado.md`)**
- Nombre sugerido: `spec/cerrados.md` (el proyecto usa `spec/catastro-historico.md`; el plugin puede adoptar cualquiera, pero debe ser **uno solo**). Formato obligatorio por entrada: `**ID — ✅ CERRADO (fecha)[, motivo].** Título. 1–2 frases de qué se hizo/por qué se descartó + evidencia medible.`
- Plantilla de migración para proyectos que ya tienen `spec/completado.md`: marcarlo `DEPRECATED` con un aviso y apuntar al nuevo archivo, sin borrar su contenido.
- Actualizar `references/` y las plantillas de `project-init` para que nazcan con este archivo y con la regla de cierre.

**3.4 Auditoría de higiene del SPEC (nuevo, ideal como subcomando o skill `spec-audit`)**
Un chequeo repetible que reporte, sin modificar nada:
- tamaño total y líneas > 600 caracteres;
- número de filas "Sesión anterior" vs. el límite configurado;
- footer > 300 caracteres o con más de un párrafo;
- `- [ ]` fuera de §3;
- ítems de §3 sin ID, o IDs duplicados/reutilizados;
- ítems marcados cerrados que siguen en §3;
- diferencia entre la versión de la cabecera y la del footer.

**3.5 Cumplimiento mecánico**
- Entregar un script `scripts/check_spec.sh` (o equivalente) invocable por el comando y por un **hook pre-commit** opcional; sale con código ≠ 0 si el SPEC excede los topes. La regla "no commitear un SPEC excedido" debe poder hacerse cumplir sin depender de la memoria del modelo.

**3.6 Guía de normalización para proyectos ya degradados**
Documentar el procedimiento que se siguió a mano y que puede repetirse (o convertirse en comando `spec-normalize`):
1. Mover el catastro original y los planes de sesión pasados, **verbatim**, al archivo de cerrados/histórico.
2. Reescribir §3 como lista única por prioridad (Alta/Media/Baja/Externo), una línea de contexto por ítem, conservando IDs; ítems cuya cola quedó solo en narrativa reciben ID nuevo.
3. Verificar cada ítem "abierto" contra código o datos reales antes de dejarlo abierto (hubo ≥5 cerrados sin marcar y 1 marcado cerrado que no lo estaba).
4. Antes de borrar filas de sesión o párrafos de footer, **comprobar que cada una exista** en `brain/sesiones.md` (por fecha o por contenido).
5. Convertir cada `- [ ]` suelto en "→ ítem N" o en ✅ con fecha.
6. Reducir footer a una línea; header a versión + fecha.

**3.7 Versión**
Publicar como `suplemento-core` **0.12.0** (cambio de comportamiento del comando `checkpoint` y de dos skills). Incluir nota de migración para proyectos con `.claude/commands/checkpoint.md` propio.

## 4. Criterios de aceptación

- Ejecutar `checkpoint` en un proyecto con un comando local homónimo produce un aviso de colisión antes de escribir nada.
- Tras un `checkpoint`, `SPEC.md` cumple: fila "Última sesión" ≤ ~400 caracteres, exactamente N filas "Sesión anterior", footer de una línea, ningún `- [ ]` fuera de §3, ninguna línea nueva > 600 caracteres.
- Un ítem cerrado aparece en el archivo único de cerrados con ID, fecha y evidencia, y su fila desapareció de §3.
- `scripts/check_spec.sh` falla (código ≠ 0) sobre un SPEC de 134 KB con 55 filas de sesión y pasa sobre el SPEC normalizado del proyecto (≈56 KB, 3 sesiones, footer de una línea) al fijar `sesiones_anteriores_en_spec: 3` y un tope acorde.
- Las skills `spec-driven-development` y `documentation-convention` ya no se contradicen sobre registro inmediato vs. diferido.

## 5. Qué ya se hizo localmente en el proyecto (interino, hasta que salga el plugin)

- `SPEC.md` normalizado: catastro único (§3) con IDs 1–125, 3 sesiones anteriores, footer de una línea, versión 7.88; 133 KB → 56 KB.
- `spec/catastro-historico.md` creado como archivo único de cerrados; `spec/completado.md` marcado DEPRECATED.
- `CLAUDE.md` (checklist punto 2 y tabla de lectura) y `.claude/commands/checkpoint.md` del proyecto actualizados a la convención de arriba.
- Pendiente de aquí: eliminar el comando local de checkpoint cuando el plugin 0.12.0 cubra estos pasos.

## 6. Consecuencias / riesgos

- Los proyectos que hoy dependen de `spec/completado.md` verán un cambio de destino; el aviso de `DEPRECATED` y la plantilla de migración lo mitigan.
- Tope de tamaño configurable introduce riesgo de "tope inflado hasta que nada falle"; por eso se pide además el umbral de advertencia y la auditoría 3.4.
- Cerrar por "ya estaba hecho" con evidencia obligatoria añade un paso; es deliberado (caso del ítem 12).

## Commit

Ver sesión 30 Septiembre 2026 — registrado en `brain/sesiones.md` y `brain/index.md`. Estado: enviado a la instancia del plugin el 30 Sep 2026; se espera `suplemento-core` 0.12.0.
