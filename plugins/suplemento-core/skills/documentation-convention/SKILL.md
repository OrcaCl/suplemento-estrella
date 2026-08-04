---
name: documentation-convention
description: Convención de registro de cambios en la documentación del proyecto — commits de código frecuentes según avanza el trabajo, pero registro de brain/ y SPEC.md diferido hasta un checkpoint explícito (invocado por el humano) o hasta el cierre de sesión (obligatorio). Úsala siempre que estés por hacer un commit, cuando el humano diga "checkpoint" o pida cerrar la sesión, o cuando cambie la versión de cualquier plugin de Claude Code instalado en el proyecto.
---

# Documentation Convention

Regla de cuándo se actualiza la documentación del proyecto — complementa a `spec-driven-development` y `brain-adr` (que dicen *dónde* va cada cosa) definiendo *cuándo* debe pasar. Esta versión reemplaza la regla anterior de "registro inmediato post-breakthrough" tras observar que, en la práctica, generaba commits demasiado frecuentes y granulares — el registro de documentación ahora se difiere a momentos explícitos, no a cada avance.

## La regla — tres momentos, no más

**1. Commits de código:** siguen ocurriendo con normalidad según avanza el trabajo — esto no cambió. Un commit de código no implica automáticamente tocar `brain/` ni `SPEC.md`.

**2. Registro de documentación (`brain/`, `SPEC.md`) — diferido hasta uno de estos dos disparadores, nunca automático:**

- **Checkpoint explícito**, invocado por el humano diciendo "checkpoint" o el comando correspondiente (ver más abajo). Code nunca decide por su cuenta que "esto amerita un checkpoint" — siempre lo pide o lo ejecuta el humano.
- **Cierre de sesión — obligatorio, sin excepción.** A diferencia del checkpoint (que es a discreción del humano durante la sesión), el cierre de sesión **siempre** dispara el registro completo: actualizar `SPEC.md`, `brain/sesiones.md`, `brain/ADR-*.md` si corresponde, commit, y push. No es opcional y no depende de que el humano lo pida — si la sesión está terminando, esto pasa sí o sí.

**Regla explícita, para que quede sin ambigüedad:** Code **no** escribe en `brain/` ni actualiza `SPEC.md` en medio de la codificación activa, ni "porque completó algo que parece importante". Eso es exactamente el comportamiento que se quiere evitar — la decisión de cuándo registrar es del humano (vía checkpoint) o está atada al cierre de sesión, nunca al juicio de Code sobre qué tan importante fue un cambio.

## El comando `checkpoint`

`suplemento-core` incluye un comando (`commands/checkpoint.md` dentro del plugin) que Code ejecuta cuando el humano dice "checkpoint" — no es un slash-command nativo reconocido estructuralmente por Claude Code todavía, es una convención de invocación: el humano lo pide en lenguaje natural, y Code sigue las instrucciones de ese archivo al pie de la letra.

El checkpoint hace, en orden:
1. Revisa qué se hizo desde el último checkpoint o cierre de sesión
2. Actualiza `brain/sesiones.md`
3. Actualiza `SPEC.md` (ítems completados, catastro, footer)
4. Actualiza `brain/index.md` si corresponde
5. Crea un ADR nuevo si hubo una decisión de arquitectura o proceso desde el último checkpoint
6. **Muestra un resumen al humano antes de escribir** — nunca asume silenciosamente qué contó como hito
7. `git commit` con mensaje descriptivo del período cubierto
8. `git push`

Ver el archivo del comando para el detalle completo — esta skill no lo duplica, solo establece cuándo se invoca.

## Cierre de sesión — el disparador que nunca se salta

Cuando el humano indique que la sesión está terminando (o cuando sea evidente por el contexto que se está por cerrar), ejecutar el mismo procedimiento del checkpoint, sin que haga falta que el humano lo pida explícitamente con esa palabra — el cierre de sesión **implica** el checkpoint. La diferencia con un checkpoint intermedio es que este es obligatorio, no a discreción.

Si por algún motivo no se puede completar el push (sin conexión, remoto no configurado, etc.), dejarlo señalado explícitamente como pendiente para la próxima sesión — no reportar la sesión como "cerrada correctamente" si el push no se completó, porque el registro no existe hasta que está pusheado.

## PLUGINS.md — mantenerlo sincronizado con la realidad instalada

Si el proyecto usa plugins de Claude Code, `PLUGINS.md` en la raíz del proyecto es la fuente de verdad de qué está instalado, qué versión, y cómo se mantiene.

**Regla:** actualizar `PLUGINS.md` siempre que cambie la versión de cualquier plugin. Esta actualización específica no espera a un checkpoint — es un dato de infraestructura, no de bitácora de trabajo, y se corrige apenas se detecta el cambio.

## Relación con .gitignore / .claudeignore

`PLUGINS.md` se versiona siempre (no va en `.gitignore`). Las credenciales nunca van ahí, solo el nombre de la variable de entorno que las contiene.