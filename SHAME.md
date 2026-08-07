# SHAME.md

Este archivo existe exclusivamente para emergencias.

Si la sesión está llegando al límite de contexto o de tokens (Entre 93% y 97%) o ya se murió la sesión por tokens:

1. Detener la implementación.
2. NO intentar "terminar rápido".
3. Guardar el estado actual del trabajo.
4. Actualizar este archivo con la información necesaria para que la siguiente sesión pueda continuar exactamente donde quedó.

## Esto estaba haciendo cuando la sesión se cortó: ##

Copia y pega lo último que le pediste a Code antes del corte de tokens. 
Si alcanzó a preparar algún plan con superpowers, copia la ruta o el nombre del archivo temporal que generó para que sigas después.

### Has un commit pero no un push ###

git status
git add .
git commit -m "wip: ..." o más honesto "SHAME.md: Me quedé sin tokens, commit de emergencia"

No hagas un push para no ensuciar el historial del Repo (ni para tener problemas con tus compañeros de trabajo).

### Apenas vuelvan los tokens ###

Dile a Code que revise este archivo: SHAME.md
Dile a Code que revise si quedaron planes inconclusos en Superpowers
Dile a Code que revise los últimos mensajes dentro de Claude-mem para tener el contexto
Dile finalmente a Code que revise dónde quedó el SPEC.md en relación a estas últimas consultas y podrás recuperar el contexto
y seguir trabajando sin problemas.


No hay problema en equivocarse y tener algo de SHAME.md
Lo que no tiene perdón es no pensar en un respaldo!
