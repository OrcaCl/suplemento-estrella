# SKILL: Documentation & Checkpoint Convention (When to Document)

## Propósito y Disparadores
Gobierna **CUÁNDO** se sincroniza la documentación del proyecto (`SPEC.md` y `brain/`).
Aplica cuando:
- Se realicen commits de código de trabajo continuo.
- El humano solicite explícitamente un *"checkpoint"*.
- Se finalice o cierre la sesión de trabajo.
- Se modifiquen dependencias de plugins o runtime del agente.

---

## 🚦 Los Tres Momentos de Documentación

### 1. Commits de Código (Fluidez Continua)
- Los commits de código en `src/`, `app/` o `tests/` se realizan normalmente según avanza el trabajo.
- **Regla Estricta:** Un commit de código **NO** debe modificar `brain/` ni `SPEC.md` en medio del desarrollo activo, sin importar qué tan "importante" parezca el avance.

### 2. Checkpoint Explícito (A Discreción del Humano)
Se ejecuta **ÚNICAMENTE** cuando el humano dice *"checkpoint"* o solicita registrar el avance. Gemini **nunca** decide por su cuenta ejecutar un checkpoint.

**Algoritmo de Checkpoint:**
1. Revisar los avances desde el último checkpoint.
2. Preparar borrador de actualización para `brain/sesiones.md` (resumen cronológico).
3. Preparar actualización de `SPEC.md` (ítems completados, contador de tests, footer).
4. Preparar actualización de `brain/index.md` si se crearon nuevos `ADR`, `INT`, `NOC`, etc.
5. **Presentar el resumen al humano antes de escribir en disco.**
6. Ejecutar `git commit` descriptivo del período y realizar `git push`.

### 3. Cierre de Sesión (Obligatorio e Innegociable)
Al finalizar la sesión de trabajo (indicado por el humano o por contexto de despedida), Gemini **DEBE** ejecutar el procedimiento completo de Checkpoint sin necesidad de que se lo pidan explícitamente.

> **Guardrail de Cierre:** Si el `git push` falla por falta de red o remoto no configurado, notificar al humano. La sesión **NO** se considera cerrada exitosamente hasta que los cambios estén pusheados.

---

## ⚙️ Excepción de Sincronización Inmediata (`PLUGINS.md` / Runtime Config)
Cualquier cambio de versión o estado en la configuración de plugins, herramientas o runtime de Gemini se actualiza de inmediato en `PLUGINS.md` o en las configuraciones del proyecto sin esperar al checkpoint, por tratarse de un metadato de infraestructura.