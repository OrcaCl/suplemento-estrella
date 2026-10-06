# SKILL: Documentation Convention — ward / keepit (When to Document)

## Propósito y Disparadores
Gobierna **CUÁNDO** se sincroniza la documentación del proyecto (`SPEC.md` y `brain/`).
Aplica cuando:
- Se realicen commits de código de trabajo continuo.
- El humano diga *"ward"*, *"keepit"*, *"listeilor"* (retirado, nombre anterior de keepit) o *"checkpoint"* (retirado).
- Se finalice o cierre la sesión de trabajo.
- Se modifiquen dependencias de plugins o runtime del agente.

**Modo de registro.** Lo descrito aquí es `registro: diferido`, el **por defecto**. Un proyecto puede declarar `registro: inmediato` en su `GEMINI.md` (ver `11-spec-driven-development.md`, sección 0); en ese caso se registra tras cada breakthrough, pero el cierre de sesión (`keepit`) sigue siendo obligatorio.

---

## 🚦 Los dos comandos

| Comando | Cuándo | Qué hace | Push |
|---|---|---|---|
| **`ward`** | A discreción del humano, a mitad de sesión | Guarda en `brain/` y `SPEC.md` todo lo pendiente y hace commit local | No |
| **`keepit`** | Cierre de sesión (obligatorio) | Verifica que no falte nada por respaldar, revisa la lista de pendientes, ejecuta el algoritmo de `ward`, commit y push finales | Sí |

`checkpoint` (versiones anteriores) y `listeilor` (nombre anterior de `keepit`) fueron **retirados** en 0.15.0: ante esas palabras, avisar del cambio y ejecutar el comando vigente (`checkpoint` → `ward`, y ofrecer `keepit`; `listeilor` → `keepit`).

---

## 🚦 Los Tres Momentos de Documentación

### 1. Commits de Código (Fluidez Continua)
- Los commits de código en `src/`, `app/` o `tests/` se realizan normalmente según avanza el trabajo.
- **Regla Estricta:** Un commit de código **NO** debe modificar `brain/` ni `SPEC.md` en medio del desarrollo activo, sin importar qué tan "importante" parezca el avance.

### 2. `ward` Explícito (A Discreción del Humano)
Se ejecuta **ÚNICAMENTE** cuando el humano dice *"ward"* o solicita registrar el avance. Gemini **nunca** decide por su cuenta ejecutar un `ward`.

**Algoritmo de `ward`:**
0. **Aviso de colisión — antes de escribir nada.** Buscar en el proyecto reglas, workflows o comandos locales con los nombres `ward`, `keepit`, `listeilor` o `checkpoint`. Si existe alguno, avisar al humano cuál es, mostrar la diferencia de pasos frente a este algoritmo y **no sobrescribirlo ni borrarlo sin confirmación**. Un `checkpoint` local heredado suele seguir el modelo antiguo que acumula en `SPEC.md` (ver `references/spec-migracion-0.12.md`).
0a. **Oferta de la convención de comentarios — una sola vez.** Si el `GEMINI.md` del proyecto no menciona `14-code-comment-convention` ni tiene la sección `## Comentarios en el código`, avisar al humano que existe esa skill y **ofrecer** agregar la sección a `GEMINI.md` (texto en `14-code-comment-convention.md`, sección 9). Si rechaza, dejar en `GEMINI.md` la línea `Comentarios en el código: convención no adoptada (decisión del humano, AAAA-MM-DD)` para no volver a ofrecerla. No modificar `GEMINI.md` sin su respuesta.
1. Revisar los avances desde el último `ward` o cierre de sesión.
2. Preparar borrador de actualización para `brain/sesiones.md` (resumen cronológico).
3. Preparar actualización de `SPEC.md` **reemplazando, no acumulando**: cerrar ítems con la regla de cierre (borrar fila de §3 → insertarla en `spec/cerrados.md` con su mismo ID + fecha + evidencia, en su posición por ID → agregar el ID a "Cerrados"); "Última sesión" (§2), header y footer se sobrescriben; la narrativa va a `brain/sesiones.md`, nunca a `SPEC.md`. Reglas completas en `11-spec-driven-development.md` (secciones 3 y 3b).
4. **Reconciliar pendientes:** buscar `- [ ]` y listas de pendientes fuera de §3 ("Próxima sesión", "Prioridad N", "Pendientes de X") y consolidarlas en §3 o marcarlas obsoletas/cerradas con fecha. Proponer como ítems nuevos (ID nuevo, nunca reutilizado) las colas que quedaron solo en la narrativa.
5. Preparar actualización de `brain/index.md` si se crearon nuevos `ADR`, `INT`, `NOC`, etc.
6. **Presentar el resumen al humano antes de escribir en disco.**
7. **Chequeo de `SPEC.md` antes del commit:** revisar la lista de topes de `11-spec-driven-development.md` (sección 3b): líneas ≤ `spec_tope_lineas` (1000 por defecto) y ninguna > 600 caracteres, filas "Sesión anterior" = `sesiones_anteriores_en_spec`, footer de una línea con la misma versión que la cabecera, ningún `- [ ]` fuera de §3 ni `[x]` dentro de ella, IDs sin duplicar. Si algo excede, condensar y mover a su destino — no commitear un `SPEC.md` excedido. Si está al 80 % del tope, avisar al humano.
8. Ejecutar `git commit` descriptivo del período. **Sin `git push`** — el push lo hace `keepit`.

### 3. Cierre de Sesión con `keepit` (Obligatorio e Innegociable)
Al finalizar la sesión de trabajo (indicado por el humano o por contexto de despedida), Gemini **DEBE** ejecutar `keepit` sin necesidad de que se lo pidan explícitamente:

1. Aviso de colisión (paso 0 de `ward`) y oferta de la convención de comentarios (paso 0a de `ward`; no repetirla si ya se ofreció).
2. **Verificar respaldo:** ¿commits de código sin entrada en `brain/sesiones.md`? ¿cambios sin commitear? ¿decisiones sin registro? ¿`brain/index.md` completo? ¿`SPEC.md` refleja el estado real?
3. **Revisar pendientes:** colas de la narrativa, `TODO`/"pendiente" dicho en la conversación, `- [ ]` fuera de §3, ítems a medias. Proponer ítems nuevos (ID nuevo) e ítems a cerrar (con evidencia verificable).
4. Mostrar el resumen de lo faltante y esperar el visto bueno del humano.
5. Ejecutar el algoritmo de `ward` (pasos 1 a 7), sin duplicar sus reglas.
6. `git commit` final (sin commit vacío) y `git push`.

> **Guardrail de Cierre:** Si el `git push` falla por falta de red o remoto no configurado, notificar al humano y dejarlo señalado como pendiente. La sesión **NO** se considera cerrada exitosamente hasta que los cambios estén pusheados. (Un `ward` sin `keepit` deja commits locales: ese registro tampoco está a salvo hasta el push.)

---

## ⚙️ Excepción de Sincronización Inmediata (`PLUGINS.md` / Runtime Config)
Cualquier cambio de versión o estado en la configuración de plugins, herramientas o runtime de Gemini se actualiza de inmediato en `PLUGINS.md` o en las configuraciones del proyecto sin esperar al `ward`, por tratarse de un metadato de infraestructura.
