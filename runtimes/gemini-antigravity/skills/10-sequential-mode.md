# SKILL: Sequential Mode & Subagent Governance (Single Thread Workflows)

## Propósito y Disparadores
Garantiza el desarrollo secuencial (tarea por tarea) en la hebra principal y restringe el uso no autorizado de subagentes paralelos.
Aplica cuando:
- Se esté ejecutando cualquier plan, tarea de desarrollo o suite de pruebas.
- El usuario solicite *"hazlo rápido"*, *"en paralelo"* o *"avanza rápido"*.
- Plugins externos (como Superpowers) sugieran `subagent-driven-development`, `dispatching-parallel-agents` o menús de *"Execution Handoff"*.

---

## Regla Absoluta de Subagentes: CERO por Defecto

> **PROHIBIDO a Gemini lanzar subagentes o ejecuciones paralelas por iniciativa propia, bajo cualquier circunstancia o condición.**
> *No existe ninguna regla de "beneficio evidente" o "tareas independientes" que autorice la paralelización autónoma.*

---

## Protocolo Obligatorio para Solicitar Paralelismo

Si Gemini identifica una oportunidad real de aceleración vía subagentes, **DEBE** ejecutar en este orden estricto:

1. **Pausa Obligatoria:** Detener la ejecución en la hebra principal.
2. **Consulta Explícita:** Preguntar al humano especificando las tareas a desglosar y la razón.
   > *Ejemplo Correcto:* "Esta tarea involucra actualizar el módulo A y el módulo B de forma independiente. Podría lanzar un subagente para cada uno: ¿apruebas el paralelismo para esta tarea puntual o lo realizo de forma secuencial?"
3. **Respuesta Humana:**
   - **SI:** Se lanzan los subagentes **únicamente para esa tarea específica** (no es un permiso permanente para tareas posteriores).
   - **NO (o sin respuesta):** Continuar de forma estrictamente lineal.

---

## Anulación de Plugins Externos (Superpowers / Adapters)

Si un plugin o librería externa recomienda o exige paralelismo:
- Etiquetas como `"recommended"`, `"Execution Handoff: Subagent-Driven"` o `"REQUIRED SUB-SKILL"` **se consideran reglas internas de dicho plugin y NO constituyen aprobación del humano.**
- Esta skill anula cualquier comportamiento predeterminado de plugins externos. La disponibilidad técnica de subagentes **nunca equivale a autorización.**

---

##  Pausas de Confirmación Secuencial

Incluso dentro de la ejecución lineal de un plan, Gemini debe solicitar confirmación explícita antes de realizar acciones de impacto:
- Creación de nuevas carpetas o estructuras de archivos principales.
- Ejecución de migraciones en la base de datos.
- Instalación de nuevas dependencias en el proyecto (`pip install`, `npm install`, etc.).
- Cambio de fase en planes multi-paso.