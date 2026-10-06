---
name: documentation-convention
description: Convención de registro de cambios en la documentación del proyecto — commits de código frecuentes según avanza el trabajo, pero registro de brain/ y SPEC.md diferido hasta un ward explícito (invocado por el humano, sin push) o hasta el cierre de sesión con keepit (obligatorio, con push). Úsala siempre que estés por hacer un commit, cuando el humano diga "ward", "keepit", "checkpoint" o pida cerrar la sesión, o cuando cambie la versión de cualquier plugin de Claude Code instalado en el proyecto.
---

# Documentation Convention

Regla de cuándo se actualiza la documentación del proyecto — complementa a `spec-driven-development` y `brain-kms` (que dicen *dónde* va cada cosa) definiendo *cuándo* debe pasar. Esta versión reemplaza la regla anterior de "registro inmediato post-breakthrough" tras observar que, en la práctica, generaba commits demasiado frecuentes y granulares — el registro de documentación ahora se difiere a momentos explícitos, no a cada avance.

**Modo de registro.** Lo descrito aquí es el modo `registro: diferido`, que es el **por defecto** de `suplemento-core`. Un proyecto puede declarar `registro: inmediato` en su `CLAUDE.md` (ver `spec-driven-development`, "Configuración del proyecto"); en ese caso el registro ocurre tras cada breakthrough, pero el cierre de sesión con `keepit` sigue siendo obligatorio.

## Los dos comandos

| Comando | Cuándo | Qué hace | Push |
|---|---|---|---|
| **`ward`** | A discreción del humano, a mitad de sesión | Guarda en `brain/` y `SPEC.md` todo lo pendiente y hace commit local | No |
| **`keepit`** | Cierre de sesión (obligatorio) | Verifica que no falte nada por respaldar, revisa la lista de pendientes, ejecuta el procedimiento de `ward`, commit y push finales | Sí |

`checkpoint` (0.11 y anteriores) y `listeilor` (0.12 y 0.13, nombre anterior de `keepit`) fueron **retirados** en 0.15.0 y ya no existen como comandos. Si el humano usa una de esas palabras, Code avisa del cambio y ejecuta el comando vigente: `checkpoint` → `ward` (y ofrece `keepit`); `listeilor` → `keepit`.

## La regla — tres momentos, no más

**1. Commits de código:** siguen ocurriendo con normalidad según avanza el trabajo. Un commit de código no implica automáticamente tocar `brain/` ni `SPEC.md`.

**2. Registro de documentación (`brain/`, `SPEC.md`) — diferido hasta uno de estos dos disparadores, nunca automático:**

- **`ward` explícito**, invocado por el humano. Code nunca decide por su cuenta que "esto amerita un ward" — siempre lo pide o lo ejecuta el humano.
- **Cierre de sesión (`keepit`) — obligatorio, sin excepción.** A diferencia de `ward` (a discreción del humano), el cierre de sesión **siempre** dispara el registro completo: `SPEC.md`, `brain/sesiones.md`, `brain/ADR-*.md` si corresponde, commit y push. No depende de que el humano lo pida con esa palabra — si la sesión está terminando (despedida, "cerremos", "hasta mañana"), esto pasa sí o sí.

**Regla explícita, para que quede sin ambigüedad:** Code **no** escribe en `brain/` ni actualiza `SPEC.md` en medio de la codificación activa, ni "porque completó algo que parece importante". La decisión de cuándo registrar es del humano (`ward`) o está atada al cierre de sesión (`keepit`), nunca al juicio de Code sobre qué tan importante fue un cambio.

## Aviso de colisión con comandos locales

Antes de ejecutar `ward` o `keepit` (o al recibir las palabras retiradas "checkpoint" o "listeilor"), buscar en el proyecto `.claude/commands/{ward,keepit,listeilor,checkpoint}.md` y `.claude/skills/{ward,keepit,listeilor,checkpoint}/`. Un comando local con el mismo nombre **tapa** al del plugin, y uno heredado de versiones anteriores suele seguir el modelo viejo que acumula en `SPEC.md`. Si existe:

1. Avisar al humano qué archivo es y **mostrar la diferencia de pasos** frente al comando del plugin.
2. No sobrescribirlo ni borrarlo sin confirmación.
3. Apuntar a `spec-driven-development/references/migracion-0.12.md` para migrarlo.

Este aviso vive aquí (y no solo en el comando) porque si un comando local tapa al del plugin, el del plugin nunca llega a ejecutarse para avisar.

## Qué hace `ward`

En orden (detalle completo en `commands/ward.md` — esta skill no lo duplica):
1. Revisa qué se hizo desde el último ward o cierre de sesión
2. Actualiza `brain/sesiones.md`
3. Actualiza `SPEC.md` **reemplazando, no acumulando** — cierre de ítems a `spec/cerrados.md` (ID original + fecha + evidencia, ordenado por ID), "Última sesión" y footer se sobrescriben — reglas completas en `spec-driven-development`
4. Reconcilia pendientes: `- [ ]` y listas fuera de §3 se consolidan en §3 o se marcan obsoletos
5. Actualiza `brain/index.md` si corresponde y crea el registro (ADR/INT/NOC/DEP/REF/REFX) que corresponda
6. **Muestra un resumen al humano antes de escribir** — nunca asume silenciosamente qué contó como hito
7. **Chequeo de `SPEC.md`** contra la lista de topes (líneas, sesiones, footer, pendientes fuera de §3) antes del commit; si excede, no se commitea
8. `git commit` con mensaje descriptivo del período — **sin push**

## Cierre de sesión — el disparador que nunca se salta

`keepit` agrega dos cosas a `ward`: **verificar** que no quede nada sin respaldar (commits sin entrada en `sesiones.md`, decisiones sin registro, `SPEC.md` desactualizado) y **revisar los pendientes** (colas de la narrativa que no están en §3), y termina con commit + push.

Si por algún motivo no se puede completar el push (sin conexión, remoto no configurado, etc.), dejarlo señalado explícitamente como pendiente para la próxima sesión — no reportar la sesión como "cerrada correctamente" si el push no se completó, porque el registro no existe hasta que está pusheado. (Un `ward` sin `keepit` deja commits locales: ese registro tampoco está a salvo hasta el push.)

## PLUGINS.md — mantenerlo sincronizado con la realidad instalada

Si el proyecto usa plugins de Claude Code, `PLUGINS.md` en la raíz del proyecto es la fuente de verdad de qué está instalado, qué versión, y cómo se mantiene.

**Regla:** actualizar `PLUGINS.md` siempre que cambie la versión de cualquier plugin. Esta actualización específica no espera a un `ward` — es un dato de infraestructura, no de bitácora de trabajo, y se corrige apenas se detecta el cambio.

## Relación con .gitignore / .claudeignore

`PLUGINS.md` se versiona siempre (no va en `.gitignore`). Las credenciales nunca van ahí, solo el nombre de la variable de entorno que las contiene.
