---
name: documentation-convention
description: Convención de registro de cambios en la documentación del proyecto — cuándo actualizar, con qué frecuencia, y cómo mantener PLUGINS.md sincronizado con las versiones reales instaladas. Úsala siempre que se complete una tarea o breakthrough, al cerrar una sesión de trabajo, o cuando cambie la versión de cualquier plugin de Claude Code instalado en el proyecto.
---

# Documentation Convention

Regla de cuándo y con qué disciplina se actualiza la documentación del proyecto — complementa a `spec-driven-development` y `brain-adr` (que dicen *dónde* va cada cosa) definiendo *cuándo* debe pasar.

## Regla de registro inmediato — NO NEGOCIABLE

Después de cualquier breakthrough importante — feature completada, bug crítico resuelto, migración ejecutada, decisión de arquitectura tomada — hay que registrar en la documentación correspondiente **de inmediato**, antes de continuar con la siguiente tarea. No acumular actualizaciones para el cierre de sesión.

Razón: si se acumulan varios breakthroughs sin documentar y la sesión termina abruptamente (se acaba el tiempo, cambia el contexto, hay que atender algo urgente), el registro se pierde o se reconstruye de memoria con menos precisión de la que tenía en el momento.

Checklist mínimo post-breakthrough:
1. Actualizar el archivo correspondiente según la tabla de decisión de `spec-driven-development` (o `brain-adr` si el proyecto usa esa estructura)
2. `SPEC.md` — marcar ítems completados, actualizar footer con conteo de tests
3. Si aplica: `git commit && git push` — **el registro no existe hasta que está pusheado**. Un commit local que no se sube es documentación que puede perderse.

## No esperar instrucción explícita

Al cerrar una sesión (o al detectar que el usuario está por cerrarla), proponer proactivamente qué registrar — no esperar a que el usuario lo pida. Esto incluye:
- Resumen de la sesión para `spec/historial.md` o `brain/sesiones.md`
- Ítems que pasan de pendientes a completados
- Si corresponde, un ADR nuevo

## PLUGINS.md — mantenerlo sincronizado con la realidad instalada

Si el proyecto usa plugins de Claude Code (Superpowers, sistemas de memoria, u otros), `PLUGINS.md` en la raíz del proyecto es la fuente de verdad de qué está instalado, qué versión, y cómo se mantiene.

**Regla:** actualizar `PLUGINS.md` siempre que cambie la versión de cualquier plugin — ya sea por un auto-update, una reinstalación manual, o un cambio deliberado de versión. No dejar que el archivo quede desactualizado respecto a lo que realmente corre en la máquina.

Contenido mínimo por plugin en `PLUGINS.md`:
- Versión activa
- Qué hace / qué skills expone (tabla skill → cuándo se activa)
- Dónde vive su almacenamiento local (si aplica) y cómo explorarlo
- Configuración relevante (variables de entorno, flags activos)
- Notas de mantenimiento — problemas conocidos y sus fixes, aunque ya no apliquen a la versión actual (sirve de historial para diagnosticar regresiones)

Ver el proyecto de referencia para un ejemplo completo de este formato.

## Relación con .gitignore / .claudeignore

`PLUGINS.md` se versiona siempre (no va en `.gitignore`) — es documentación de convención del equipo, no configuración sensible ni caché local. Si en algún momento contiene algo que parezca una credencial (API key, token), eso es una señal de que se está documentando mal — las credenciales nunca van en `PLUGINS.md`, solo el nombre de la variable de entorno que las contiene.