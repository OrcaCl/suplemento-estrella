# ADR-015 — Modern Web Guidance: plugin del ecosistema, no vendorizado

**Estado:** Vigente (decisión de enfoque; la integración está en el ítem 20 de `SPEC.md`)
**Fecha:** 2026-11-17

## Contexto

Modern Web Guidance (GoogleChrome/modern-web-guidance, Apache-2.0, mantenido por los equipos de Chrome, Edge, Firefox y MDN con la comunidad) son skills y una CLI que le entregan al agente guías de plataforma web moderna y datos de compatibilidad de navegadores, para alejarlo de patrones heredados. Se instala con `npx modern-web-guidance@latest install` o como plugin de Claude Code (marketplace `googlechrome`). Se leyó el README y el manifiesto; el README no dice qué archivos escribe el asistente de `npx` ni dónde.

## Decisión

1. **Se recomienda como plugin de Claude Code** (`/plugin marketplace add GoogleChrome/modern-web-guidance` y `/plugin install modern-web-guidance@googlechrome`), no con el asistente de `npx`.
2. **No se vendoriza** dentro de `suplemento-core`: las guías se actualizan a través de la CLI justamente para no quedar obsoletas, y copiarlas las congelaría.
3. Se trata como parte del **ecosistema recomendado**, junto a los demás plugins, y se registra en `PLUGINS.md` de cada proyecto.
4. **Privacidad:** el proyecto recopila de forma anónima conteos de instalación, nombre del agente, IDs de guías y búsquedas generadas por el agente (no los prompts). Se recomienda desactivarlo con `DISABLE_TELEMETRY=1`.
5. **No usar** la copia de `claude-plugins-official`: según el README quedó sin actualizar desde el 12 de octubre.

## Alternativas descartadas

- **`npx install`:** no se pudo confirmar dónde escribe ni cómo se versiona; queda fuera de `claude plugin list` y de un futuro `ketchup`.
- **Vendorizar las guías en el plugin:** se desactualizan y duplican mantenimiento.

## Consecuencias

- El suplemento queda con una dependencia opcional de un plugin de terceros: la skill `frontend-conventions` solo lo consulta si está instalado.
- Un plugin con AutoUpdate cambia solo (riesgo de cadena de suministro, ver `seguridad-por-diseno`); se decide en el ítem 20.

## Commit

Ver entrada "Sesión — 2026-11-17 — Modern Web Guidance como plugin" en `brain/sesiones.md`.
