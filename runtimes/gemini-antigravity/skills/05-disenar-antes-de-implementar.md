# SKILL: Diseñar Antes de Implementar (Collaborative Design Gate)

## Propósito y Disparadores
Garantiza que la intención técnica se acuerde con el humano antes de escribir código o invocar skills de implementación.
Aplica siempre que se vaya a:
- Crear una feature, componente o endpoint.
- Modificar comportamiento existente o refactorizar.
- Explorar la factibilidad de una idea (spike).
- *Especialmente cuando una tarea acotada revele complejidad oculta.*

---

## 🚨 Compuerta Dura Inviolable
> **PROHIBIDO escribir código, andamiar (scaffold) o invocar skills de ejecución sin presentar la propuesta y recibir un "SÍ" explícito del humano.**
> *El artefacto de diseño puede ser de 2 frases en el chat, pero la aprobación NUNCA es opcional.*

---

## 🚦 Los Tres Caminos de Diseño

Al recibir un requerimiento, Gemini debe clasificar la tarea y **declarar la clasificación en voz alta en el chat** antes de preguntar.

### 1. Sondeo (Spike)
- **Definición:** Investigación de factibilidad (*"¿se puede hacer X?"*).
- **Entregable:** Una respuesta/conclusión. Todo código generado es **desechable**.
- **Flujo:** Explicar qué se probará en 2 frases → Recibir "ok" → Probar barato → Reportar hallazgo.
- **Regla:** Si el humano decide conservar el código del sondeo, se reclasifica como una tarea nueva.

### 2. Acotado (Bounded)
- **Definición:** Cambio delimitado a código que **YA EXISTE** en el repositorio. *(Mide la existencia previa en el repo, no la familiaridad del agente).*
- **Flujo:**
  1. Explorar el contexto de los archivos involucrados.
  2. Presentar propuesta corta en el chat: Enfoque, archivos afectados y estrategia de test.
  3. **DETENERSE y esperar aprobación explícita.** *(Prohibido proponer e implementar en el mismo mensaje).*
  4. Implementar vía `tdd-workflow`.

### 3. Arquitectónico
- **Definición:** Proyectos/subsistemas nuevos, refactorizaciones estructurales o cambios de interfaces públicas.
- **Flujo:**
  1. Hacer preguntas de aclaración (una por mensaje).
  2. Proponer 2-3 enfoques con sus trade-offs (aplicando YAGNI estricto).
  3. Presentar el diseño por secciones escaladas (arquitectura, flujo de datos, errores, tests) y validar sección por sección.
  4. Documentar en el archivo oficial según la estructura del proyecto (`spec/` o un `ADR` en Brain KMS + `sesiones.md`).
  5. Auto-revisar por placeholders ("TODO", "TBD") o ambigüedades.
  6. **Invocar obligatoriamente `planificacion-por-fases`** antes de escribir código.

---

## 📈 Trinquete Unidireccional (Escalamiento de Complejidad)
- Ante la duda entre dos caminos, elegir el más pesado.
- Si una tarea acotada revela complejidad oculta a mitad de camino: **PARAR de inmediato, comunicar el hallazgo al humano y subir a camino Arquitectónico.**
- Ninguna tarea baja de camino a mitad de ejecución.

---

## 🛑 Banderas de Alerta (STOP)
Detenerse y reiniciar el diálogo si surgen pensamientos como:
- *"Es muy simple para requerir diseño."* $\rightarrow$ (Respuesta: Diseños simples son de 2 frases en chat, pero requieren "sí").
- *"Empiezo a picar código mientras el usuario lee la propuesta."* $\rightarrow$ (Violación directa de la compuerta dura).
- *"Ya casi termino, no vale la pena avisar que se complicó."* $\rightarrow$ (Violación del trinquete).