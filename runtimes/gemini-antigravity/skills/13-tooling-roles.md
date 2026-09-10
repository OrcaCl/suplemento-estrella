# SKILL: Tooling Roles & Stack Presets (Functional Role Mapping)

## Propósito y Disparadores
Mapea roles funcionales de desarrollo (gestión de paquetes, ORM, testing, config) desde el stack preset de Python hacia equivalentes en JavaScript/TypeScript, PHP u otros lenguajes.
Aplica cuando:
- Se inicialice un proyecto en un lenguaje distinto a Python (`project-init`).
- Se deba seleccionar una librería para cumplir un rol funcional no cubierto previamente.
- Se requiera registrar la tabla de stack tecnológico en `SPEC.md` o `GEMINI.md`.

---

##  Tabla de Referencia de Roles Funcionales

| Rol Funcional | Preset Python (Suplemento Estrella) | Equivalente JS/TS | Equivalente PHP |
|---|---|---|---|
| Gestor de paquetes | `uv` | `pnpm` / `npm` | `composer` |
| ORM + Migraciones | `SQLAlchemy` + `Alembic` | `Prisma` / `TypeORM` | `Eloquent` / `Doctrine` |
| Config tipada desde `.env` | `pydantic-settings` + `python-dotenv` | `zod` + `dotenv` | `vlucas/phpdotenv` |
| Cliente HTTP | `httpx` | `fetch` nativo / `axios` | `Guzzle` |
| CLI + Consola | `click` + `rich` | `commander` / `yargs` + `chalk` | Evaluar según necesidad |
| Framework web + Servidor | `Flask` + `Gunicorn` | `Express` / `Fastify` + `pm2` | `Laravel` / `Slim` + `php-fpm` |
| Testing + Cobertura | `pytest` + `pytest-cov` + `pytest-xdist` | `vitest` / `jest` | `Pest` / `PHPUnit` |
| Auditoría de dependencias | `pip-audit` | `npm audit` | `composer audit` |
| Detección de secretos | `gitleaks` (Agnóstico) | `gitleaks` | `gitleaks` |
| Proceso / Infraestructura | `nginx` + `pm2` (Agnóstico) | `nginx` + `pm2` | `nginx` + `pm2` |
| Explorador BD (Dev) | `datasette` + `datasette-mask-columns` | `Adminer` o endpoint de solo lectura | Igual que JS/TS |

---

##  Reglas de Aplicación

1. **Selección por Rol:** En proyectos no-Python, identificar los roles funcionales requeridos y tomar los equivalentes de la columna respectiva.
2. **Registro en `SPEC.md`:** Documentar la elección en la sección *Stack tecnológico* indicando el rol funcional (ej. *"ORM + migraciones: Prisma"*).
3. **Herramientas Sin Equivalente Directo:** Para herramientas específicas como `datasette`, consultar al humano si desea implementar una alternativa de enmascaramiento o consultar la BD mediante SQL directo.
4. **Prevalencia de Preferencia Humana:** Si el humano indica una herramienta de su preferencia para un rol, dicha elección reemplaza automáticamente al preset.