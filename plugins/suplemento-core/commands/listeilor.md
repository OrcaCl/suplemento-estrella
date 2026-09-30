---
description: Cierra la sesión — verifica que nada quede sin respaldar en brain/ y SPEC.md, revisa que no falten pendientes en la lista, y hace el commit y push final.
---

## Instrucciones

Al recibir la palabra "listeilor" del humano (o cuando la sesión esté terminando: despedida, "cerremos", "hasta mañana"), ejecutar en orden. El cierre de sesión es **obligatorio**: no depende de que el humano lo pida con esta palabra exacta.

0. **Aviso de colisión** — el mismo del paso 0 de `ward` (comandos o skills locales con nombre `ward`, `listeilor` o `checkpoint`). Avisar antes de escribir nada.
1. **Verificación de respaldo — qué quedó sin registrar.** Sin modificar todavía:
   - `git status` y `git log` desde el último ward o cierre (busca la última entrada de `brain/sesiones.md`): ¿hay commits de código sin entrada en `brain/sesiones.md`? ¿cambios sin commitear?
   - ¿Hubo decisiones en la conversación sin registro (ADR/INT/NOC/DEP/REF/REFX)? ¿`brain/index.md` incluye todos los registros que existen en `brain/`?
   - ¿`SPEC.md` refleja el estado real (versión, "Última sesión", ítems ya cerrados fuera de §3)?
2. **Revisión de pendientes.** ¿Quedaron cosas por hacer que no están en la lista de §3? Fuentes: colas de la narrativa de la sesión, `TODO`/"pendiente" dicho en la conversación, `- [ ]` fuera de §3 y ítems que la sesión dejó a medias. Proponer al humano los ítems nuevos (con ID nuevo) y los ítems a cerrar (con evidencia verificable, no solo "se implementó").
3. Mostrar al humano un **resumen de lo faltante** (pasos 1 y 2) antes de escribir nada, y esperar su visto bueno — igual que `ward`.
4. **Ejecutar el procedimiento de `ward`** (`commands/ward.md`, pasos 1 a 9) sobre lo pendiente, incluido el chequeo de topes de `SPEC.md` (paso 9). No duplicar aquí sus reglas.
5. `git commit` final del período cubierto (si `ward` ya dejó el commit y no hay nada más, no crear uno vacío).
6. `git push` — el registro no existe hasta que está pusheado.
7. **Confirmar el cierre:** si el push no se pudo completar (sin conexión, remoto no configurado, rechazo), dejarlo señalado explícitamente como pendiente para la próxima sesión y **no** reportar la sesión como "cerrada correctamente".

## Guardrail

Igual que `ward`: si el registro involucra un `REFX-NNN.md`, Code no navega al proyecto de origen; cualquier dato extra se pide al humano.

## Uso

Se invoca diciendo "listeilor" (o `/suplemento-core:listeilor`). Sin argumentos. Diferencia con `ward`: `ward` guarda a mitad de sesión y **no** hace push; `listeilor` verifica que no falte nada, revisa los pendientes y **sí** hace commit y push finales.
