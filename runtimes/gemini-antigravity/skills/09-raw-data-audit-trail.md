# SKILL: Raw Data Audit Trail (External Data Persistence & Masking)

## Propósito y Disparadores
Establece la convención de auditoría para modelos de base de datos que persisten información desde fuentes externas.
Aplica siempre que se esté:
- Diseñando o modificando un modelo ORM/SQLAlchemy que reciba imports de Excel, CSV, KML o respuestas de APIs externas.
- Creando un serializador, Pydantic schema o endpoint de API que exponga una tabla con datos importados.
- Configurando exploradores de base de datos de desarrollo (Datasette, Adminer, etc.).

---

## Regla 1 — Captura Obligatoria (`raw_data`)

Toda tabla que ingrese datos del exterior DEBE incluir como última columna el campo `raw_data`:

```python
# Ejemplo SQLAlchemy 2.0
raw_data: Mapped[dict | None] = mapped_column(JSON, nullable=True)
```

## Tabla de Decisión de Scope

|Origen de la Fila|¿Lleva raw_data?|
|-|-|
|Import de Excel, archivo CSV/KML, respuesta de API externa|SÍ|
|Datos calculados, agregados o lógica de negocio interna|NO (Exento)|
|Configuración o metadatos de la aplicación|NO (Exento)|


## Regla 2 — Exposición Controlada (Ocultación por Defecto)

raw_data existe para auditoría interna y debugging, pero nunca se expone al cliente o consumidor casual.

1. En APIs y Serializadores

Los schemas de salida (Pydantic, Marshmallow, dicts) NO deben incluir la clave raw_data.

Test Obligatorio de Verificación:

def test_endpoint_no_expone_raw_data_en_respuesta(client):
    response = client.get("/api/v1/mi-recurso/1")
    assert response.status_code == 200
    assert "raw_data" not in response.json()

2. En Exploradores de BD de Desarrollo (Datasette, etc.)

Enmascarar la columna para mostrar REDACTED por defecto en vistas de tabla, manteniendo el dato real accesible únicamente mediante consultas SQL directas.


## Registros Históricos (Deuda Técnica Aceptable)

Al agregar raw_data a una tabla preexistente con datos cargados, se permite que los registros antiguos permanezcan en NULL. Documentar esta condición en la bitácora (brain/sesiones.md o el ADR correspondiente).