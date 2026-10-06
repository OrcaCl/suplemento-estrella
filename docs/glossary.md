# Glosario

Los conceptos propios de Suplemento Estrella, en orden alfabético.

---

**ADR** — *Architecture Decision Record.* Registro de una decisión que afecta lo que el sistema hace o cómo se comporta. Una vez publicado no se edita: si la decisión cambia, se crea otro. Ver [decisions.md](decisions.md).

**Brain ADR** — Nombre anterior de Brain KMS y de su skill (`brain-adr`). Se rebautizó en v0.10.0 (ver ADR-001) y la skill de Claude Code pasó a llamarse `brain-kms` en v0.11.0.

**Brain KMS** — *Brain Knowledge Management System.* El sistema `brain/`: la memoria persistente compartida entre el desarrollador y su agente, que vive dentro del repositorio. Ver [brain.md](brain.md).

**`ward`** — Comando (del lore de internet: guardar algo para volver a revisarlo sin perder lo que se va agregando). Registra lo pendiente en `brain/` y `SPEC.md` y hace commit **local, sin push**. Solo lo dispara el humano; el agente nunca decide por su cuenta que "amerita" uno. Ver [workflow.md](workflow.md).

**`keepit`** — Comando de cierre de sesión: verifica que no falte nada por respaldar en `brain/` y `SPEC.md`, revisa que no queden pendientes fuera de la lista, ejecuta `ward`, y hace el commit y push finales. Es obligatorio antes de dar la sesión por terminada.

**Checkpoint** — Nombre anterior (≤ 0.11) de `ward`; deprecado en 0.12.0. Hacía lo mismo que `ward` pero con push.

**`CLAUDE.md` / `GEMINI.md`** — Reglas que el agente carga al iniciar una sesión (Claude Code y Gemini respectivamente): confirmación de contexto, stack, reglas críticas, modo de trabajo.

**Core** — La capa de referencia del harness: metodología, skills y convenciones. Versiona por su cuenta (`SPEC.md`).

**DEP** — *Deprecated.* Registro del retiro de una herramienta, archivo, patrón o plugin. Documenta un cierre y su porqué; no cambia de estado.

**Harness** — Lo que es Suplemento Estrella: un marco de trabajo para desarrollo asistido por agentes de código, instalable como plugin de Claude Code y, en paralelo, como adaptación para otros agentes.

**Instancia con nombre humano** — Convención opcional de comunicación: darle un nombre al agente de un proyecto (por ejemplo, "Tomás") para dirigirse a él con menos fricción. Es una decisión de proceso (INT-000), no una regla técnica.

**INT** — *Interno.* Registro de una decisión que afecta solo cómo el humano y el agente trabajan juntos, nunca lo que el sistema construido hace.

**Modo adopción** — Comportamiento de `project-init` cuando el proyecto ya fue inicializado por otro agente: adopta `SPEC.md` y `brain/` existentes sin recrearlos y genera solo lo que falta. Ver ADR-005.

**Modo secuencial** — Regla de trabajo por defecto: una tarea a la vez y cero subagentes, salvo aprobación humana puntual.

**NOC** — *Nota de Cuidado.* Riesgo o cuidado mixto a monitorear, todavía no una decisión. Puede actualizarse en el lugar con seguimientos fechados.

**`PLUGINS.md`** — Archivo del proyecto que registra qué plugins están instalados y en qué versión. Es el único registro que se actualiza de inmediato, sin esperar un `ward`.

**`project-init`** — Skill que inicializa un proyecto: crea `SPEC.md`, `spec/`, `brain/` y el archivo de reglas del agente.

**REF** — *Referencia.* Contexto de dominio propio del proyecto, sin estructura de decisión. Es un documento vivo.

**REFX** — *Referencia cruzada.* Material traído manualmente desde otro proyecto, con su procedencia explícita. El agente nunca navega el proyecto de origen por su cuenta.

**Runtime** — Adaptación del harness a un agente concreto. Claude Code es el runtime de referencia (`plugins/suplemento-core/`); los demás viven en `runtimes/` (hoy, Gemini/Antigravity). Cada uno versiona de forma independiente.

**SDD** — *Spec-Driven Development.* Trabajar con `SPEC.md` y `spec/` como fuente de verdad del proyecto.

**`sesiones.md`** — Registro de las sesiones de trabajo en `brain/`: qué se hizo, qué se descubrió, qué decisiones aparecieron y qué quedó pendiente. Las entradas más recientes van arriba.

**`SHAME.md`** — Archivo de emergencia, en la raíz. Si la sesión está por quedarse sin tokens (o ya se cortó), se guarda ahí el estado exacto del trabajo para que la siguiente sesión continúe donde quedó.

**Skill** — Unidad de la metodología: un archivo con las reglas de una disciplina concreta (por ejemplo `tdd-workflow`). Se activa cuando el contexto lo pide.

**`SPEC.md`** — Panel de control del proyecto: estado, pendientes, reglas críticas y decisiones permanentes. Corto por diseño (≤ 1000 líneas) y se reemplaza, no se acumula. Ver [spec.md](spec.md).

**`spec/`** — Carpeta con el detalle que `SPEC.md` no debe cargar: `api.md`, `datos.md`, `cerrados.md`, el backlog, etc.

**Test quirúrgico** — Regla de `tdd-workflow`: después de un cambio se corre únicamente el test directamente relacionado; ampliar el alcance requiere preguntar al humano.

**TOASK** — `TOASK.md` (raíz del proyecto): preguntas pendientes, no un backlog. Se clasifican por quién debe responderlas: **A** (humano o decisión de producto), **D** (proveedor o servicio externo) y **S** (investigable por el agente, cuando el humano le diga que hay tiempo).

**Trackers** — `brain/trackers/`: bugs que un sistema externo tiene (`bugs.md`) y features que se le pedirían (`features.md`), con sus plantillas.
