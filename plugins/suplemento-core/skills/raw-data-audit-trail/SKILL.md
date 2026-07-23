---
name: raw-data-audit-trail
description: Convención de auditoría para toda tabla que persiste datos provenientes de una fuente externa (Excel, API, CSV, KML, u otro import). Úsala siempre que se esté diseñando o modificando un modelo de base de datos que reciba datos importados, al crear un serializador o endpoint de API que exponga una tabla con datos importados, o al configurar un explorador de base de datos de desarrollo (Datasette u otro). Define cuándo agregar la columna raw_data y cómo ocultarla correctamente en los puntos de acceso externos sin perder su valor de auditoría.
---

# Raw Data Audit Trail

Dos reglas relacionadas, confirmadas de forma independiente en dos proyectos distintos bajo esta metodología — no es una preferencia de un solo caso, es una convención ya validada dos veces.

## Regla 1 — Captura

Toda tabla que persiste filas provenientes de una fuente **externa** (Excel, API de terceros, CSV, KML, cualquier import) debe incluir una columna `raw_data` (JSON, nullable) como última columna del modelo.

```python
raw_data: Mapped[dict | None] = mapped_column(JSON, nullable=True)
```

### Por qué

- Si el parser falla o produce un valor incorrecto, el raw permite auditar exactamente qué llegó, sin depender de que el archivo fuente original siga disponible.
- Si el formato de la fuente cambia con el tiempo, se puede re-parsear desde el raw guardado sin re-importar nada.
- En producción, los archivos fuente originales suelen desaparecer (se sobrescriben, se pierden, cambian de ubicación) — el raw es el único respaldo de fidelidad que persiste junto con el dato procesado.

### Scope — a qué tablas aplica

| Tipo de tabla | ¿Lleva raw_data? |
|---|---|
| Recibe datos de una fuente externa (import de Excel, respuesta de API, parseo de archivo) | Sí |
| Datos derivados internamente (calculados, agregados, resultado de lógica propia del sistema) | No — exento |
| Metadatos internos de la aplicación (tracking de uploads, configuración) | No — exento |

Si hay duda sobre si una tabla entra en scope, la pregunta de corte es: "¿esta fila existe porque algo de afuera del sistema la trajo, o porque el sistema mismo la generó?"

## Regla 2 — Exposición controlada

`raw_data` existe en la base de datos para auditoría, pero **nunca se expone** en los puntos de acceso pensados para consumo externo o exploración casual:

### En serializadores / API

La función que convierte el modelo a diccionario/JSON para una respuesta de API no debe incluir `raw_data`. Escribir un test explícito que lo verifique — no basta con omitirlo "a mano", el test evita que una futura edición lo reintroduzca por accidente.

```python
def test_endpoint_no_expone_raw_data_en_respuesta():
    ...
    assert "raw_data" not in response.json()
```

### En exploradores de base de datos de desarrollo

Si el proyecto usa un explorador tipo Datasette (o equivalente), enmascarar `raw_data` en vez de ocultarlo por completo — la columna sigue siendo visible como campo existente (evita que un desarrollador nuevo no sepa que existe), pero su contenido se muestra como valor redactado (ej. `REDACTED`), sin exponer el JSON completo en cada fila de una vista casual.

El dato real sigue accesible vía consulta SQL directa contra la columna, para debugging puntual — la exposición controlada no es una restricción de acceso, es una restricción de **visibilidad por defecto**.

## Las dos capas juntas — por qué ninguna sola es suficiente

- Solo Regla 1 (captura sin exposición controlada): cualquier consumidor de la API o cualquiera que abra el explorador de BD ve el JSON crudo de la fuente externa en cada fila — ruido visual, y potencial filtración de estructura/formato interno de una fuente que no debería ser pública.
- Solo Regla 2 (exposición controlada sin captura): no hay nada que ocultar, porque nunca se guardó el dato crudo — se pierde la capacidad de auditoría cuando el parser falla o el formato de la fuente cambia.

## Deuda técnica aceptable

Si un modelo existente no tiene `raw_data` y se decide agregarlo, es aceptable que los registros históricos queden con `raw_data = NULL` — no hace falta backfill retroactivo si el dato original ya no está disponible. Documentar esto como deuda conocida en `spec/historial.md` o el ADR correspondiente, no como bloqueante.