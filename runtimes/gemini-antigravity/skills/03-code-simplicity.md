## SKILL: Code Simplicity (KISS, DRY & Anti-Overengineering)

### Propósito y Disparadores
Gobierna todo desarrollo de código (Python, SQL, JS, etc.) para mantener las soluciones lo más simples y directas posible.
Aplica cuando:
- Se diseñe un nuevo componente o función.
- Se evalúe si extraer o abstraer código repetido.
- Se elija entre una función directa versus un patrón de diseño (ej. Strategy, Factory).

---

### 1. Los Tres Principios de Diseño

1. **KISS (Keep It Simple, Stupid):**
   - La solución más simple que resuelve el problema de hoy es siempre la mejor.
   - Tres líneas directas son mejores que una abstracción prematura.
   - Si una función cumple su cometido en 5 líneas legibles, no la conviertas en una clase.
   - Preferir composición sobre herencia.

2. **DRY (Don't Repeat Yourself) — Regla de las 3 Repeticiones:**
   - Una duplicación (2 veces) es aceptable.
   - Recién a la **tercera repetición real (3+ veces)** se evalúa crear un módulo o función compartida.
   - Una abstracción con un solo caso de uso no es DRY, es sobreingeniería.

3. **Evitar Sobreingeniería (YAGNI):**
   - No implementar código, capas de indirección o configuraciones genéricas para escenarios futuros o hipotéticos.
   - *Preguntas de control antes de abstraer:*
     - ¿Existen HOY 2+ casos reales que lo necesiten?
     - ¿El costo de NO abstraer hoy es mayor que refactorizar cuando aparezca el siguiente caso real?
     - ¿La complejidad agregada se explica en una sola frase?
   - Si la respuesta es NO, usa la solución directa (`if/else` explícito en lugar de patrones complejos).