# ADR-023 — Solo funciones de los tres motores, con datos de compatibilidad contrastados

**Estado:** Vigente (corrige el detalle de la tabla de madurez de la ADR-022; el resto de la ADR-022 sigue)
**Fecha:** 2026-11-18

## Contexto

La ADR-022 adaptó las guías de Modern Web Guidance e incluyó en la skill una tabla de madurez de 159 funciones, 75 de ellas de disponibilidad limitada, y varias recomendaciones que dependían de funciones de uno o dos motores (posicionamiento por anclaje, `focusgroup`, Sanitizer API, `Temporal`, `scheduler.yield()`…). El autor pidió no dejar en la skill funciones limitadas a uno o dos motores, dar prioridad a las "widely available" y contrastar con Can I use, y luego señaló que Can I use se alimenta de browser-compat-data.

## Decisión

1. **Regla de inclusión:** se recomienda por defecto lo Baseline "widely available"; lo "newly" (tres motores) con alternativa; **las funciones de uno o dos motores no se usan como base ni se recomiendan** en las listas. Chrome y Edge cuentan como un solo motor (Chromium).
2. **Se contrastó la tabla con tres bases abiertas** (web-features 3.46.0, MDN BCD 8.1.9 y Can I use 2026-11-11). Resultado: las 146 funciones con nombre propio coinciden al 100 % con su estado actual; 74 funciones tienen uno o dos motores (46 uno, 28 dos); `accent-color` es la única "limitada" con tres motores (Safari 26.2).
3. **La tabla se regeneró** con solo las funciones de tres motores (68 "widely", 42 "newly"), con las versiones mínimas por navegador y el uso global de Can I use cuando existe. Muchas funciones recientes no figuran en el archivo de datos de Can I use (usa BCD para ellas), así que esa celda queda en "—".
4. **Se retiraron de las referencias** las recomendaciones que dependían de funciones de uno o dos motores: posicionamiento por anclaje, `focusgroup`, invocadores de interés, `scroll-target-group`, `<dialog closedby>`, `moveBefore()`, `scroll-initial-target`, `hidden="until-found"`, `:autofill`, el atributo `switch`, los selects personalizables, `text-wrap: pretty`, `scheduler.yield()`, `Temporal`, el carga diferida de video y audio, la Sanitizer API, `Connection-Allowlist`, `Permissions-Policy`, los metadatos `Sec-Fetch-*`, `Clear-Site-Data` y las cookies particionadas. Cada una tiene su alternativa de tres motores o se omite.
5. **Se verificó lo que se había recomendado de memoria:** `structuredClone`, los métodos de arreglos por copia, `Object.groupBy`, `Promise.withResolvers`, `AbortSignal.any/timeout` y `Error cause` son "widely"; `@scope`, `scroll-driven animations`, `ariaNotify()` y `contrast-color()` son "newly" (tres motores), no limitadas como se había escrito.
6. **Lo que no se pudo verificar** en ninguna de las tres bases (COOP, CORP, `X-Content-Type-Options`, prefijos `__Host-`/`__Secure-`) queda señalado como tal y se recomienda como defensa en profundidad.

## Alternativas descartadas

- **Dejar las funciones limitadas "con aviso":** el autor pidió explícitamente sacarlas de la skill.
- **Usar solo Can I use:** no tiene muchas funciones recientes; se complementa con web-features y BCD.
- **Medir por cuota de mercado en vez de por motores:** Chrome y Safari juntos pasan del 85 % de uso global, así que una función de dos motores puede parecer segura; la regla por motores es más estable.

## Consecuencias

- La tabla sigue siendo una instantánea; regenerarla es un procedimiento manual (descargar las tres bases y cruzar por nombre). Queda en el ítem 26.
- Se sumó la atribución de tres bases más (CC BY 4.0, CC0 y Apache-2.0) en `NOTICE.md` y el README.
- Se descartan también algunas guías útiles de la fuente cuando dependen de funciones de uno o dos motores; si el proyecto las necesita, deben rediseñarse con alternativas.

## Commit

Ver entrada "Sesión — 2026-11-18 — solo funciones de tres motores" en `brain/sesiones.md`.
