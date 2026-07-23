---
name: tooling-roles
description: Tabla de roles funcionales de herramientas (gestor de paquetes, ORM+migraciones, config tipada, cliente HTTP, CLI, testing, auditoría de dependencias) con el stack Python de referencia como preset por defecto, y equivalentes conocidos en JavaScript/TypeScript y PHP. Úsala al inicializar un proyecto nuevo que no sea Python, al elegir una librería para una responsabilidad ya cubierta en otro proyecto Suplemento Estrella, o cuando falte decidir qué herramienta usar para un rol funcional específico.
---

# Tooling Roles

La mayoría del stack de Suplemento Estrella no es "dependencias de Python" en sí — son roles funcionales que cualquier proyecto necesita, con una implementación Python elegida como preset. Esta skill separa el rol de la herramienta, para que un proyecto en otro lenguaje pueda mapear los mismos roles sin perder la metodología.

## Tabla de roles

| Rol funcional | Preset Python (Suplemento Estrella) | Equivalente JS/TS | Equivalente PHP |
|---|---|---|---|
| Gestor de paquetes | `uv` | `pnpm` / `npm` | `composer` |
| ORM + migraciones | `SQLAlchemy` + `Alembic` | `Prisma` / `TypeORM` | `Eloquent` / `Doctrine` |
| Config tipada desde `.env` | `pydantic-settings` + `python-dotenv` | `zod` + `dotenv` | `vlucas/phpdotenv` |
| Cliente HTTP | `httpx` | `fetch` nativo / `axios` | `Guzzle` |
| CLI + salida en terminal | `click` + `rich` | `commander`/`yargs` + `chalk`/`ora` | — (evaluar según necesidad) |
| Framework web + servidor | `Flask` + `Gunicorn` | `Express`/`Fastify` + `pm2`/Node nativo | `Laravel`/`Slim` + `php-fpm` |
| Testing + cobertura + paralelo | `pytest` + `pytest-cov` + `pytest-xdist` | `vitest`/`jest` | `Pest`/`PHPUnit` |
| Auditoría de vulnerabilidades en dependencias | `pip-audit` | `npm audit` | `composer audit` |
| Detección de secretos antes de commit | `gitleaks` | `gitleaks` (agnóstico) | `gitleaks` (agnóstico) |
| Proceso/infraestructura | `nginx` + `pm2` | `nginx` + `pm2` (agnóstico) | `nginx` + `pm2` (agnóstico) |
| Explorador de BD en desarrollo | `datasette` + `datasette-mask-columns` | Sin equivalente directo — evaluar `Adminer` con vistas filtradas, o endpoint interno de solo lectura | Igual que JS/TS |

## Herramientas ya agnósticas — no requieren mapeo

`nginx`, `pm2`, y `gitleaks` se usan igual sin importar el lenguaje del proyecto backend — no son parte de este mapeo porque ya son la misma elección en cualquier stack.

## Cómo usar esta tabla al inicializar un proyecto no-Python

1. Identificar qué roles funcionales necesita el proyecto (no todos son obligatorios — un proyecto sin CLI no necesita la fila de CLI).
2. Para cada rol, usar el equivalente de la columna correspondiente al lenguaje elegido, salvo que el usuario tenga una preferencia ya establecida.
3. Documentar la elección en la sección "Stack tecnológico" de `SPEC.md` (ver `project-init/references/spec-md-template.md`) — con el rol funcional como comentario si el nombre de la herramienta no lo deja obvio (ej. "ORM + migraciones: Prisma").
4. Si un rol no tiene equivalente claro en el nuevo lenguaje (como el explorador de BD), plantear la pregunta al usuario explícitamente en vez de asumir una solución — puede que ese rol simplemente no aplique para ese proyecto.

## El caso del explorador de BD — nota especial

`datasette` es la pieza más específicamente Python de todo el stack, sin un equivalente 1:1 directo en otros lenguajes. El **concepto** que cumple — explorador de solo lectura de la base de datos en desarrollo, con columnas sensibles enmascaradas — es portable aunque la herramienta no lo sea. Si el proyecto nuevo no es Python, decidir explícitamente con el usuario cómo cubrir ese rol (o si se omite, aceptando que el debugging de BD se hace por otra vía, como consultas SQL directas).

## Cuándo NO usar el preset por defecto

El preset Python es el punto de partida, no una obligación. Si el usuario ya tiene una preferencia establecida para un rol específico (por ejemplo, ya usa un ORM particular en otro proyecto propio), esa preferencia gana sobre el preset — esta skill existe para dar un punto de partida razonable cuando no hay preferencia previa, no para forzar una elección.