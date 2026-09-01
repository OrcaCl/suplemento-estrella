---
name: depuracion-sistematica
description: Disciplina de encontrar la causa raíz de un bug ANTES de intentar cualquier arreglo. Cuatro fases obligatorias — investigación, análisis de patrón, hipótesis, implementación — sin saltarse ninguna. Úsala siempre que aparezca un bug, un test que falla, comportamiento inesperado, un problema de rendimiento, o una falla de build/integración — antes de proponer o escribir un fix. Especialmente bajo presión de tiempo, cuando "un arreglo rápido" parece obvio, o cuando ya se intentaron varios fixes sin éxito.
---

# Depuración sistemática

**Principio central:** encontrar la causa raíz antes de intentar arreglos. Un fix al síntoma es una falla de depuración.

**Violar la letra de este proceso es violar su espíritu.**

## La ley de hierro

```
NINGÚN FIX SIN INVESTIGAR LA CAUSA RAÍZ PRIMERO
```

Si no se completó la Fase 1, no se pueden proponer fixes. No aplica solo a bugs "difíciles" — los bugs simples también tienen causa raíz, y el proceso es rápido para ellos.

## Fase 1 — Investigación de la causa raíz

**Antes de intentar CUALQUIER fix:**

1. **Leer los mensajes de error con cuidado.** No pasar por encima de errores ni warnings. Suelen contener la solución exacta. Leer el stack trace completo. Anotar números de línea, rutas de archivo, códigos de error.

2. **Reproducir de forma consistente.** ¿Se puede disparar de forma confiable? ¿Cuáles son los pasos exactos? ¿Pasa siempre? Si no es reproducible → juntar más datos, no adivinar.

3. **Revisar cambios recientes.** ¿Qué cambió que pudiera causar esto? `git diff`, commits recientes, dependencias nuevas, cambios de config, diferencias de entorno.

4. **Juntar evidencia en sistemas de varios componentes.** Cuando el sistema tiene varias capas (CI → build → firma; API → servicio → base de datos), **antes de proponer fixes, agregar instrumentación de diagnóstico**: en cada límite entre componentes, loguear qué dato entra y qué dato sale, verificar que la config/entorno se propaga, revisar el estado en cada capa. Correr una vez para juntar evidencia de **dónde** se rompe. Después analizar la evidencia para identificar el componente que falla. Recién después investigar ese componente específico.

5. **Trazar el flujo de datos hacia atrás.** Cuando el error está profundo en el call stack: ¿de dónde sale el valor malo? ¿qué llamó a esto con el valor malo? Seguir trazando hacia arriba hasta encontrar el origen. **Arreglar en el origen, no en el síntoma.**

## Fase 2 — Análisis de patrón

**Encontrar el patrón antes de arreglar:**

1. **Buscar ejemplos que funcionan.** Localizar código similar que sí funciona en el mismo codebase. ¿Qué funciona que se parece a lo que está roto?
2. **Comparar contra la referencia.** Si se está implementando un patrón, leer la implementación de referencia **completa** — cada línea, no en diagonal.
3. **Identificar diferencias.** ¿Qué es distinto entre lo que funciona y lo que está roto? Listar cada diferencia, por chica que parezca. No asumir "eso no puede importar".
4. **Entender dependencias.** ¿Qué otros componentes necesita esto? ¿Qué config, settings, entorno? ¿Qué asume?

## Fase 3 — Hipótesis y prueba

**Método científico:**

1. **Formular UNA sola hipótesis.** Enunciarla claro: "creo que X es la causa raíz porque Y". Escribirla. Ser específico, no vago.
2. **Probar mínimamente.** El cambio más chico posible para probar la hipótesis. Una variable a la vez. No arreglar varias cosas de una.
3. **Verificar antes de continuar.** ¿Funcionó? Sí → Fase 4. ¿No funcionó? Formular una hipótesis NUEVA. NO apilar más fixes encima.
4. **Cuando no se sabe:** decir "no entiendo X". No fingir que se sabe. Preguntarle al humano o investigar más.

## Fase 4 — Implementación

**Arreglar la causa raíz, no el síntoma:**

1. **Crear un caso de prueba que falla.** La reproducción más simple posible. Test automatizado si se puede; script de una vez si no hay framework. Tenerlo **antes** de arreglar. Ver `tdd-workflow`.
2. **Implementar UN solo fix.** Atacar la causa raíz identificada. Un cambio a la vez. Nada de "ya que estoy" ni refactors de paquete.
3. **Verificar el fix.** ¿Pasa el test ahora? ¿No se rompió ningún otro? ¿El problema está realmente resuelto? Ver `tdd-workflow` ("verificación antes de declarar trabajo completo").
4. **Si el fix no funciona:** PARAR. Contar cuántos fixes se intentaron. Si son menos de 3: volver a Fase 1 con la información nueva. **Si son 3 o más: parar y cuestionar la arquitectura.**

5. **Si 3+ fixes fallaron — cuestionar la arquitectura.** Patrón que indica un problema arquitectónico: cada fix revela un nuevo acoplamiento/estado compartido en otro lado; cada fix requiere "refactor masivo"; cada fix crea síntomas nuevos en otra parte. **Parar y hablarlo con el humano antes de intentar más fixes.** Esto no es una hipótesis fallida — es una arquitectura equivocada.

## Señales de alerta — STOP y volver a Fase 1

Si Code se sorprende pensando:

- "Fix rápido por ahora, investigo después"
- "Probemos cambiar X a ver si funciona"
- "Es probablemente X, lo arreglo"
- "No entiendo del todo pero esto podría funcionar"
- "Acá están los problemas principales: [lista de fixes sin investigar]"
- Proponer soluciones antes de trazar el flujo de datos
- "Un intento más de fix" (con 2+ ya intentados)
- Cada fix revela un problema nuevo en otro lado

**Todas significan: PARAR. Volver a Fase 1.** Con 3+ fixes fallidos: cuestionar la arquitectura.

## Señales del humano de que Code lo está haciendo mal

- "¿Eso no está pasando?" — Code asumió sin verificar.
- "¿Nos va a mostrar...?" — Code debió agregar instrumentación de evidencia.
- "Deja de adivinar" — Code está proponiendo fixes sin entender.
- "Piénsalo en serio / ultra-think" — cuestionar fundamentos, no síntomas.

**Cuando aparezcan: PARAR. Volver a Fase 1.**

## Rationalizaciones comunes

| Excusa | Realidad |
|---|---|
| "El problema es simple, no necesito proceso" | Los problemas simples también tienen causa raíz. El proceso es rápido para bugs simples. |
| "Es una emergencia, no hay tiempo para proceso" | La depuración sistemática es MÁS RÁPIDA que adivinar y probar en loop. |
| "Pruebo esto primero, después investigo" | El primer fix marca el patrón. Hacerlo bien desde el principio. |
| "Escribo el test después de confirmar que el fix funciona" | Los fixes sin test no se sostienen. El test primero prueba que el fix sirve. |
| "Varios fixes de una vez ahorra tiempo" | No se puede aislar qué funcionó. Causa bugs nuevos. |
| "Veo el problema, lo arreglo" | Ver el síntoma ≠ entender la causa raíz. |

## Cuando el proceso revela "no hay causa raíz"

Si la investigación sistemática revela que el problema es genuinamente ambiental, dependiente de timing, o externo: (1) se completó el proceso, (2) documentar qué se investigó (en `brain/trackers/bugs.md` o el registro `NOC` si aplica), (3) implementar el manejo apropiado (retry, timeout, mensaje de error), (4) agregar logging para investigación futura. Pero: el 95% de los casos de "no hay causa raíz" son investigación incompleta.

## Relación con otras skills

- **`tdd-workflow`** — la Fase 4 escribe primero el test que falla (rojo) y recién después el fix. El alcance de ejecución sigue siendo quirúrgico: solo el test de la reproducción, no la suite entera (a menos que el humano lo pida).
- **`sequential-mode`** — depurar es una tarea a la vez. Nada de lanzar subagentes en paralelo para "probar varias hipótesis" sin aprobación explícita del humano.
- **`brain-adr`** — un bug que no se va a arreglar ahora se anota en `brain/trackers/bugs.md`; un hallazgo de riesgo mixto que surge durante la depuración va a un `NOC`.

## Nota sobre plugins de flujo de trabajo

Si el proyecto tiene instalada una skill de "systematic-debugging" de un plugin genérico (por ejemplo Superpowers), esta skill la reemplaza con el mismo método de 4 fases, en español, e integrada con `tdd-workflow` (alcance quirúrgico) y el sistema `brain/trackers/` para capturar bugs y hallazgos sin desviarse de la tarea actual.
