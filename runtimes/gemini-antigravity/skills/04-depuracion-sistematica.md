## SKILL: Depuración Sistemática (Systematic Debugging)

### Propósito y Disparadores
Disciplina estricta para encontrar la causa raíz de cualquier bug, test fallido o error de integración ANTES de escribir código de solución.
Aplica cuando:
- Falle una prueba unitaria, script o proceso de build.
- Ocurra un comportamiento inesperado, error de ejecución o cuello de botella de rendimiento.
- *Especialmente bajo presión de tiempo o tras intentar fixes fallidos.*

---

### 🚨 La Ley de Hierro
> **`NINGÚN FIX SIN INVESTIGAR LA CAUSA RAÍZ PRIMERO`**
> Prohibido proponer o escribir parches/fixes sin haber completado la Fase 1.

---

### 🔄 El Ciclo Obligatorio de 4 Fases

#### Fase 1: Investigación de Causa Raíz
1. **Lectura Completa del Error:** Leer stack traces enteros, números de línea y rutas.
2. **Reproducción Consistente:** Confirmar los pasos exactos. Si no es reproducible, instrumentar logs; no adivinar.
3. **Revisión de Cambios Recientes:** Inspeccionar `git diff`, nuevas dependencias o variables de entorno.
4. **Instrumentación de Diagnóstico (Límites):** En sistemas multicapa (API → BD, CI → Build), agregar logs en los puntos de entrada/salida para aislar DÓNDE se rompe antes de asumir qué se rompió.
5. **Trazado hacia Atrás:** Seguir la variable o estado corrupto hasta su origen. **Arreglar en el origen, no en el síntoma.**

#### Fase 2: Análisis de Patrón
1. **Buscar lo que Funciona:** Identificar código o módulos similares dentro del repo que funcionen correctamente.
2. **Comparar Diferencias:** Listar cada pequeña diferencia entre la implementación funcional y la defectuosa.

#### Fase 3: Hipótesis y Prueba Científica
1. **Formular UNA sola Hipótesis:** *"Creo que X es la causa raíz porque Y"*.
2. **Prueba Mínima:** Cambiar una sola variable a la vez para validar o descartar la hipótesis.
3. **Descarte Limpio:** Si la hipótesis falla, deshacer el cambio. **PROHIBIDO acumular fixes sobre fixes.**

#### Fase 4: Implementación (TDD)
1. **Crear Test que Falle (RED):** Escribir una prueba unitaria o script mínimo de reproducción que confirme el bug.
2. **Implementar Fix Mínimo (GREEN):** Corregir la causa raíz identificada.
3. **Verificación:** Asegurar que el test pase sin romper ningún otro componente.
4. **Límite de 3 Fixes / Cuestionar Arquitectura:** Si 3 intentos de fix fallan, **DETENERSE**. No es una hipótesis fallida, es una arquitectura defectuosa. Dialogar inmediatamente con el humano.

---

### 🛑 Detención Inmediata (STOP & Restart)
Volver automáticamente a Fase 1 si surgen pensamientos como:
- *"Probemos cambiar X a ver si funciona."*
- *"Fix rápido por ahora, luego investigo."*
- Proponer soluciones antes de trazar el flujo de datos.
- Reacciones humanas como *"¿Eso no está pasando?"* o *"Deja de adivinar"*.