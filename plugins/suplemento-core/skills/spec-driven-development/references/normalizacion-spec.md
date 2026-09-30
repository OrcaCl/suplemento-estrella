# Normalizar un SPEC.md degradado

Procedimiento para un `SPEC.md` que dejó de ser un índice ágil: cientos de KB, decenas de filas "Sesión anterior", footer atrasado, ítems "fantasma" (cerrados sin marcar), checkboxes repartidos por varias secciones. Se siguió a mano en un proyecto real (133 KB → 56 KB) y puede repetirse tal cual. Ejecutarlo con el humano, no en silencio.

Punto de partida: `bash <plugin>/scripts/check_spec.sh --report SPEC.md` — el reporte es la lista de lo que hay que arreglar y, al final, la prueba de que quedó bien.

## Pasos

1. **Mover, verbatim, lo que sale.** El catastro original de pendientes y los planes de sesión pasados van tal cual al archivo de cerrados / histórico (`spec/cerrados.md`, o un histórico aparte si es muy grande). Nada se reescribe ni se resume mientras se mueve: primero se preserva.
2. **Reescribir §3 como lista única por prioridad** (Alta / Media / Baja / Externo), una línea de contexto por ítem, **conservando los IDs existentes**. Los ítems cuya cola quedó solo en narrativa reciben un ID nuevo (siguiendo la numeración; nunca reutilizar uno cerrado).
3. **Verificar cada ítem "abierto" contra código o datos reales** antes de dejarlo abierto. En el caso de referencia hubo ≥ 5 ítems cerrados sin marcar y 1 marcado cerrado que no lo estaba (la columna a poblar seguía en `false` en 262.860 filas). Los que se cierran aquí llevan evidencia verificable en el archivo de cerrados.
4. **Antes de borrar filas de sesión o párrafos de footer, comprobar que cada una exista en `brain/sesiones.md`** (por fecha o por contenido). Lo que falte se agrega ahí primero; el `SPEC.md` nunca es el único lugar donde vive una sesión.
5. **Convertir cada `- [ ]` suelto** en "→ ítem N" (consolidado en §3) o en ✅ con fecha (ya cerrado).
6. **Reducir el footer a una línea** y el header a versión + fecha; hacer que ambas versiones coincidan.
7. **Aplicar el límite de sesiones:** dejar exactamente las `sesiones_anteriores_en_spec` filas declaradas (0 por defecto), cada una ≤ 600 caracteres.
8. **Correr `check_spec.sh`** sin `--report`: debe salir con código 0. Ajustar `spec_tope_lineas` solo si el tope por defecto no calza con el proyecto — no para "hacer pasar" un archivo que sigue degradado.

## Regla de oro

Ningún dato se pierde: todo lo que sale de `SPEC.md` existe en el archivo de cerrados, en el histórico o en `brain/sesiones.md` antes de borrarse de `SPEC.md`.
