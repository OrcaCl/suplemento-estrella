# Modelado de amenazas (STRIDE) y NIST SSDF

## STRIDE — qué revisar de una feature

| Letra | Amenaza | Pregunta |
|---|---|---|
| S | Spoofing (suplantación) | ¿Cómo sé quién es? ¿Se puede hacer pasar por otro? |
| T | Tampering (manipulación) | ¿Se pueden alterar datos en tránsito o en reposo? |
| R | Repudiation (repudio) | ¿Queda registro de quién hizo qué? |
| I | Information disclosure (filtración) | ¿Qué datos podrían verse sin permiso? |
| D | Denial of service (denegación de servicio) | ¿Se puede agotar un recurso con peticiones o datos enormes? |
| E | Elevation of privilege (elevación de privilegios) | ¿Puede alguien hacer lo que no le corresponde? |

## Procedimiento corto

1. Dibujar mentalmente el flujo: quién envía qué, a qué, y dónde se guarda.
2. En cada cruce de confianza (cliente al servidor, servidor a base de datos, servidor a un servicio externo), recorrer las seis letras.
3. Anotar solo lo relevante: la amenaza, el control elegido o el riesgo aceptado.
4. Los controles elegidos van al diseño; lo aceptado o aplazado, a un ítem de la §3 de `SPEC.md` o a un NOC si es un riesgo a vigilar.

Debe caber en un mensaje corto: si el modelado crece, es señal de que la feature es grande y conviene dividirla.

## NIST SSDF (SP 800-218)

Marco de prácticas de desarrollo seguro, en cuatro grupos:

| Grupo | Idea | Cómo aparece en este harness |
|---|---|---|
| Preparar a la organización (PO) | Roles, requisitos y entorno seguros | `CLAUDE.md`, `SPEC.md`, nivel `asvs_nivel` |
| Proteger el software (PS) | Integridad del código y los artefactos | Git, `.gitignore`, secretos fuera del repo |
| Producir software bien asegurado (PW) | Diseñar, revisar y probar con seguridad | Esta skill, `disenar-antes-de-implementar`, `tdd-workflow` |
| Responder a las vulnerabilidades (RV) | Encontrar, corregir y aprender | `NOC` y `ADR` en `brain/`, `ketchup` (ítem 18) |

Estado de la versión: **SSDF 1.1** es la vigente. La **1.2** es un borrador (diciembre de 2025) enfocado en código generado por IA; no se confirmó que ya sea final, así que revisar el sitio del CSRC de NIST antes de citarla. El perfil SP 800-218A cubre IA generativa, pensado para quienes producen o adquieren modelos y sistemas de IA.
