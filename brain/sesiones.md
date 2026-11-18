# Registro de sesiones

Hitos relevantes por sesión de trabajo. Las entradas más recientes van arriba.


## Sesión — 2026-11-18 — reorganización de los ítems abiertos y versión objetivo

**Contexto:** el autor ordenó los ítems restantes de la 0.16.0: el 23 (migrar proyectos) lo hará caso a caso, y el 24 (publicar) va al final.

- **Ítem 26 fusionado en el 18:** `ketchup` se correrá de cuando en cuando y trabajará con las **versiones que funcionan bien por proyecto** (`PLUGINS.md` como registro de versiones buenas); revisar la antigüedad de las referencias de Modern Web Guidance es parte de `ketchup`.
- **Ítems 14 y 21:** quedan como **sugeridos**; el autor verá cómo aplicarlos o los dejará solo recomendados.
- **Ítem 19 reformulado:** la skill de seguridad se **consulta cuando se construya login, CRUD, acceso a datos sensibles o algo expuesto a internet**; ya no se busca un proyecto para probarla.
- **Versión objetivo:** los cambios restrictivos (14, 18, 19, 21) se reservan para la **0.17.0**. El proyecto sigue en 0.x, así que un cambio de comportamiento es una versión menor (0.17.0) y no un parche (0.16.1); el autor escribió "1.17.0", que sería una versión mayor 1.x.
- **Observación del autor sobre `brain/files/secure/`:** la regla `deny` cubre `Read(...)` y por eso un `ls` posterior fue rechazado, mientras que escribir el respaldo con `tar` había funcionado, porque la lectura y la escritura son reglas distintas (`Read` y `Edit`). Según la documentación oficial las reglas se evalúan en orden `deny` → `ask` → `allow`; un `ask` pide autorización al usuario y es el interruptor posible. Se anotó en el ítem 21; no se cambió ninguna regla.

---

## Sesión — 2026-11-18 — solo funciones de tres motores y datos contrastados

**Contexto:** el autor pidió no dejar en la skill funciones limitadas a uno o dos motores, priorizar las "widely available", y contrastar con Can I use (`Fyrd/caniuse`, `data-2.0.json`); después indicó que esa base se alimenta de `mdn/browser-compat-data`.

**Qué se hizo:** se bajaron Can I use (554 funciones, instantánea del 2026-11-11, CC BY 4.0), MDN BCD 8.1.9 (CC0) y web-features 3.46.0 (Apache-2.0). Se cruzaron las 159 funciones de las guías con web-features: coinciden las 146 con nombre propio; se contó los motores de cada una (Chromium, Gecko, WebKit).
- **Hallazgos:** 74 funciones tienen uno o dos motores; solo `accent-color` es "limitada" con tres. Can I use no incluye muchas funciones recientes (`popover`, `inert`, `light-dark()`…): ahí BCD y web-features suplen.
- **Correcciones a mi trabajo previo:** había descrito como limitadas `scroll-driven animations`, `ariaNotify()` y `contrast-color()`, que son "newly" con tres motores; y había recomendado sin verificar `Permissions-Policy`, `Sec-Fetch-*`, `Clear-Site-Data`, cookies particionadas, Sanitizer API, `Temporal`, `scheduler.yield()` y varias funciones de CSS, todas de uno o dos motores. Se retiraron o se reemplazaron por su alternativa.
- **Verificadas "widely":** `structuredClone`, arreglos por copia, `Object.groupBy`, `Promise.withResolvers`, `AbortSignal.any/timeout`, `Error cause`, `Nesting`, `:focus-visible`, propiedades lógicas, carga diferida de imágenes, AVIF/WebP, CSP, SRI, HSTS, Referrer-Policy y WebAuthn.
- **No verificables en las tres bases:** COOP, CORP, `X-Content-Type-Options` y los prefijos de cookies; quedan señalados.
- **Tabla de madurez regenerada** (68 widely, 42 newly) y regla de inclusión escrita (ADR-023). Atribución de las tres bases en `NOTICE.md` y el README.

---

## Sesión — 2026-11-18 — guías propias de frontend ampliadas a todas las categorías

**Contexto:** el autor pidió revisar todas las demás categorías de Modern Web Guidance ("tenemos tokens, espacio de disco…"). La conexión con la API se cortó en medio del trabajo; el autor hizo un commit de emergencia (`bdb4342`) que conservó tres archivos ya escritos, y la sesión se retomó sin pérdidas.

**Lectura (unos 1,5 MB, 184 guías más las 45 de la ronda anterior):** por capas: las guías maestras de cada categoría leídas completas en sus reglas (`css`, `security`, `performance`, `html`, `js`, `privacy`, `color`, `typography`, `motion`, `forms`), y las específicas por descripción y reglas destacadas. No línea por línea. Categorías no adaptadas: IA integrada, WebMCP, WebAssembly, PWA y efectos de nicho.

**Resultado (ADR-022):**
- `frontend-conventions/references/`: `css-y-diseno.md`, `rendimiento.md`, `html-y-js.md`, `comportamientos.md`, `madurez-funciones.md` (159 funciones: 36 widely, 48 newly, 75 limitadas, generadas de las declaraciones de las guías), y `formularios.md` ampliado.
- `seguridad-por-diseno/references/seguridad-web-navegador.md`: cabeceras HTTP (HSTS, `nosniff`, `Referrer-Policy`, `Permissions-Policy`, `frame-ancestors`, COOP/CORP, `Sec-Fetch-*`, CORS, `Clear-Site-Data`), cookies (`__Host-`), XSS en el DOM (Sanitizer API, Trusted Types, CSP en modo solo informe), `postMessage`, SRI, passkeys y privacidad. Cubre un vacío real de la skill de seguridad.
- **Hallazgos que corrigen mi trabajo anterior:** el posicionamiento por anclaje de CSS es de disponibilidad limitada (lo había recomendado sin reservas); `<dialog>` y `<details>` son "widely" (la tabla de componentes decía "sin limitaciones declaradas").
- **Lección de proceso:** commitear por tandas durante un trabajo largo; así el corte de conexión no perdió nada.
- **Ítems:** 25 cerrado; 26 nuevo (mantener al día lo adaptado).

---

## Sesión — 2026-11-18 — guías propias de frontend y atribución

**Contexto:** el autor pidió revisar las guías de accesibilidad, formularios y componentes de interfaz de Modern Web Guidance para actualizar `frontend-conventions` y no depender de un plugin que ejecuta `npx` constantemente y pide telemetría; y dejar por escrito en el proyecto que se referencian terceros para copyright y licencias.

**Lectura:** las 4 guías de accesibilidad (la general en detalle), la general de formularios en detalle y las descripciones de las demás, y las 22 guías de componentes de interfaz (descripción, reglas clave y madurez declarada de cada una). Son 45 archivos, 600 KB; no se leyó todo línea por línea. **No** se leyeron las otras categorías (visual-design, performance, ui-behaviors, ui-atoms, css, html, js, security, etc.).

**Hallazgos y decisiones (ADR-021):**
- **Tres referencias propias** en `frontend-conventions/references/`: `accesibilidad.md`, `formularios.md` y `componentes.md` (con una tabla de madurez fechada: `popover` "newly available", `focusgroup` solo Chrome/Edge, etc.).
- **El plugin ya no se recomienda** (reemplaza la ADR-015 en ese punto): ejecuta `npx -y …@latest` en cada consulta, recopila telemetría, se declara obligatorio y exige una sección en las respuestas. Ítem 20 cerrado como descartado.
- **`seguridad-por-diseno` tenía un hueco:** no mencionaba CSRF, `POST` para cambiar estado ni JavaScript en línea con CSP. Agregado desde la guía de formularios.
- **Honestidad sobre lo adaptado:** donde agregué criterios WCAG que la fuente no cita (2.5.3, 2.5.8, contraste 4.5:1) quedó señalado; `ariaNotify()` figura sin soporte verificado; dos celdas de la tabla de madurez que decían "Estable" sin que las guías lo declararan se corrigieron.
- **Copyright y licencias:** Apache-2.0 exige copia de la licencia, atribución e indicar los cambios. Hecho: encabezado en cada archivo, `references/LICENSE-Apache-2.0.txt`, `NOTICE.md` (tabla archivo, guías originales y cambios), sección "Créditos y licencias de terceros" en el README y la convención "Material de terceros" en `docs/conventions.md`.
- **Ítem 25:** adaptar otras categorías y definir cómo revisar la madurez de lo ya adaptado.

---

## Sesión — 2026-11-18 — `frontend-conventions` frente a Modern Web Guidance

**Contexto:** el autor preguntó si `frontend-conventions` estaba desactualizada frente a Modern Web Guidance y si convenía actualizarla con lo que ofrece.

**Lectura (repo GoogleChrome/modern-web-guidance, 210 guías en 17 categorías, Apache-2.0):** su `SKILL.md`, la guía maestra de CSS, la de rendimiento, `security/sanitize-untrusted-html`, `security/trusted-types`, `css/reduce-style-repetition`, `css/design-token-reactivity` y `html/styling-web-components`. No se leyeron las 210.

**Hallazgos:**
- **No estaba "desactualizada" en general, sino en dos reglas:** la Regla 2 (`styles.css` de `@import`) contradice su guía de rendimiento, y la Regla 3 (BEM) choca con su recomendación de no usar BEM para especificidad. Además la skill no decía qué primitivas web usar.
- **Decisiones del autor (ADR-020):** parcial de template con `<link>` y `@layer`; BEM se conserva solo para nombres.
- **Correcciones propias durante el trabajo:** mi primer ejemplo de CSS anidado (`&__header`) era sintaxis de Sass y no funciona en CSS nativo; también faltaba advertir que las reglas fuera de capas ganan a las que están en capas.
- **Hallazgo sobre ADR-015:** la skill externa ejecuta `npx -y modern-web-guidance@latest` en cada consulta (código de terceros sin versión fija, contra el criterio de la ADR-016), se declara "obligatoria" para toda tarea web y exige una sección propia en las respuestas. Mi recomendación anterior de instalarlo como plugin con AutoUpdate desactivado no cubre eso: el CLI se descarga al ejecutarse. Queda en el ítem 20.
- **Su categoría `security/` (17 guías)** incluye Sanitizer API, Trusted Types, restringir conexiones salientes y recursos externos seguros; se enlazaron dos desde `frontend-conventions`.
- **Atribución:** `NOTICE.md` declara la lectura de esa fuente; no se copió texto.

---

## Sesión — 2026-11-18 — boletines en `brain/reports/`

**Contexto:** en proyectos grandes `brain/` se alarga con decenas de boletines. El autor pidió guardarlos en una subcarpeta llamada `reports/` y dejar solo `sesiones.md` e `index.md` en la raíz de `brain/`.

- **ADR-019:** los boletines viven en `brain/reports/` con el mismo nombre de archivo. Los proyectos anteriores a la 0.16.0 no se migran solos (diseño plano válido; no mezclar); `housekeeping` propone la migración.
- **Este repo:** los 23 boletines se movieron con `git mv` (historial conservado) y los enlaces de `brain/index.md` llevan el prefijo `reports/`. Los textos históricos que citan rutas antiguas no se editaron.
- **Actualizados:** `project-init` (árbol y creación de `reports/`), `brain-kms` (nueva sección "Dónde viven los registros"), `ward`, `keepit`, `housekeeping`, `documentation-convention`, `spec-driven-development`, las plantillas, `docs/brain.md`, README, CHANGELOG, `CLAUDE.md` y la guía `migracion-0.16.md` (con los comandos de migración).

---

## Sesión — 2026-11-18 — cierre de la 0.16.0

**Contexto:** el autor decidió que la 0.16.0 será una actualización grande y pidió dejar el repo limpio: retirar el runtime Gemini conservando un respaldo, avisar en cada actualización de proyecto el hallazgo sobre `.claudeignore`, y dejar al día los `.md` de la raíz.

- **Runtime Gemini retirado (DEP-002):** `runtimes/` e `install-gemini.sh` borrados. Respaldo en `brain/files/secure/runtime-gemini-antigravity-0.1.6.tar.gz` (31 archivos, comparado byte a byte con la etiqueta; no se versiona) y etiqueta local `runtime-gemini-0.1.6`. Durante la sesión el autor sospechó que `install-gemini.sh` había quedado fuera del tarball; se comprobó que sí está (4198 bytes, idéntico al de la etiqueta). Reemplaza el congelamiento de ADR-017.
- **Nota sobre `.claudeignore`:** guía `project-init/references/migracion-0.16.md`, aviso destacado en el README ("si vienes de una versión anterior a la 0.16.0") y entrada de seguridad en el CHANGELOG. El texto aclara que no es una puerta trasera: el fallo es que el agente sí podía leer archivos que se creían protegidos; incluye comprobar la regla, buscar secretos versionados y rotar credenciales al alcance del agente.
- **`.md` de la raíz al día:** README (instalación solo de Claude Code, tabla de migraciones por versión, novedades 0.16.0, estado v0.16.0, licencias), CHANGELOG (las dos secciones "Sin publicar" fusionadas en "2026-11-18 — Core v0.16.0" con Security, Added, Changed, Removed), SPEC (versión 0.16.0, sin Gemini), CLAUDE.md (plugins vigentes), NOTICE.md (ya vigente), TOASK.md y SHAME.md sin cambios necesarios. `docs/`, `plugin.json` y `marketplace.json` sin referencias al runtime Gemini; `plugin.json` en 0.16.0.
- **Ítem 24:** publicar (keepit, empujar la etiqueta, actualizar el plugin local) y luego migrar los proyectos uno a uno (ítem 23).
- **No se publicó nada:** sin push ni etiqueta de versión.

---

## Sesión — 2026-11-18 — revisión de seguridad de las skills propias

**Contexto:** ítem 22. Tras leer los documentos de OWASP, el autor pidió revisar las propias skills en busca de huecos y corregirlos.

**Alcance real de la revisión:** `project-init` (completa), los tres comandos, las plantillas de ignore, `CLAUDE.md`, bug report y `api.md` se leyeron enteros. Las demás skills se revisaron con búsquedas dirigidas y lectura de las partes con superficie de seguridad; **no se leyeron línea por línea** (`planificacion-por-fases`, `disenar-antes-de-implementar`, `sequential-mode`, `tdd-workflow`, `code-simplicity` y la mayor parte de `code-comment-convention` y `spec-driven-development` solo por búsqueda). El plugin no contiene credenciales.

**Hallazgo principal (ADR-018):** `.claudeignore` **no tiene efecto** en Claude Code; la documentación oficial de permisos lo dice textualmente y manda trasladar sus entradas a reglas `Read` deny. `project-init` lo generaba desde agosto de 2026 como "doble protección" de `brain/files/secure/`. Yo mismo lo había repetido en la skill de seguridad esa misma semana; corregido. `Read` deny cubre las herramientas de archivos y comandos de Bash reconocidos (`cat`…), no scripts que abren archivos; para eso, el sandbox.

**Otros huecos corregidos:**
- `project-init` Paso 5: `git add .` y `git push` sin revisar qué se agregaba (podía publicar un `.env` de un directorio con contenido previo). Ahora revisa estado, busca secretos, agrega por ruta y confirma el destino.
- `ward`, `keepit` y `housekeeping` no decían qué agregar al commit; ahora agregan por ruta. `keepit` nunca empuja con `--force`.
- `project-init` podía sobrescribir un `CLAUDE.md`, `.gitignore` o `settings.json` existentes y no tenía en cuenta que el `CLAUDE.md` de un repo ajeno es configuración no confiable.
- `.gitignore` ampliado; `frontend-conventions` (XSS en `data-*`), `raw-data-audit-trail` (datos personales en `raw_data`), `depuracion-sistematica` (instrumentación sin secretos), bug report y `api.md` (sin datos reales), `CLAUDE.md` (sección Seguridad con `asvs_nivel`) y `tooling-roles` (fila de análisis estático).
- Referencia rota a `project-init-changelog-patch.md` eliminada.
- Este repo: se eliminó su `.claudeignore` y se agregó `.claude/settings.json`. No había nada expuesto (`secure/` vacía, sin secretos versionados).

**Pendiente urgente (ítem 23):** los proyectos del autor ya inicializados tienen la protección sin efecto.

---

## Sesión — 2026-11-18 — runtime Gemini congelado

**Contexto:** el autor pidió ignorar el runtime Gemini por ahora y dijo que incluso dejaría de mantenerlo, porque prefiere trabajar con Claude Code.

- **ADR-017:** el runtime queda congelado (0.1.6, `core_version` 0.15.0), sin mantenimiento ni paridad. Se mantiene en el repo y el README avisa que puede estar desactualizado.
- **Ítems 7 y 16 cancelados** (a `spec/cerrados.md` como descartados) y el punto de Gemini del ítem 20 retirado. `CHANGELOG` y `SPEC.md` actualizados.
- **Queda por confirmar:** el retiro formal (borrar el runtime y registrar un `DEP`); el autor habló en condicional, así que se eligió la medida reversible.

---

## Sesión — 2026-11-17 — correcciones tras leer los documentos OWASP

**Contexto:** el autor aprobó las cuatro propuestas de la lectura de OWASP y preguntó si las referencias `amenazas-y-ssdf` y `asvs-5` estaban incluidas en el análisis, y si convenía converger las referencias.

- **Aclaración:** el análisis comparó los cuatro PDFs contra `SKILL.md`. `owasp-top10-2025.md` y `asvs-5.md` se habían verificado antes contra fuentes oficiales; `amenazas-y-ssdf.md` (STRIDE y SSDF) no aparece en los PDFs, que derivan el modelado de amenazas a otro documento no leído.
- **Convergencia parcial:** solo lo del mismo proyecto. `agentes-asi-2026.md` pasó a `agentes-y-datos-owasp.md` (ASI, Securing Agentic y seguridad de datos, misma autoría y licencia). Top 10, ASVS y STRIDE/SSDF siguen separados por ser marcos y ediciones distintos. El punto de unión es la tabla por tipo de cambio de `SKILL.md`.
- **`SKILL.md` ampliado** con los hallazgos 1, 2, 6, 7 y 8: configuración de repos ajenos no confiable, no combinar las tres patas, análisis estático y auditoría del código generado, higiene de credenciales, git destructivo y minimización de datos.
- **ADR-016:** plugins de terceros sin actualización automática por defecto; `ketchup` revisa y pide aprobación (ajusta el ítem 20).
- **Ítem 21:** receta opcional de hooks (hallazgo 3). **Ítem 22:** revisión de seguridad de las skills propias.
- **`NOTICE.md`** en la raíz declara el material CC BY-SA 4.0 dentro de un repo MIT.

---

## Sesión — 2026-11-17 — lectura de documentos OWASP

**Contexto:** el autor descargó cuatro documentos del OWASP GenAI Security Project a `~/promaticmedia/owasp` (fuera del repo) y pidió compararlos con `seguridad-por-diseno` para saber si el harness estaba desprotegido y si la skill necesitaba más consideraciones. Pidió además transparentar fuente y licencia.

**Documentos leídos** (texto extraído con `pdftotext`; se leyeron índices, ASI completo en sus medidas de prevención, y de Securing Agentic Applications V2 las secciones 2.7.3, 3.1.3, 3.3.7, 5.2, 5.5.1, 6.1 y 6.4; de Data Security solo fundamentos y la estructura de la serie): Top 10 for Agentic Applications 2026; Securing Agentic Applications V2 (106 págs.); GenAI Data Security Best Practices v2 Parte 1 y Parte 2. **Todos CC BY-SA 4.0**, igual que ASVS y Top 10:2025.

**Licencia:** CC BY-SA 4.0 exige atribución con nombre del proyecto y del documento, indicar cambios y compartir lo adaptado bajo la misma licencia. Se creó `references/fuentes-y-licencias.md`, cada referencia derivada lleva su encabezado de fuente y licencia, y se declaró que esos archivos son CC BY-SA 4.0 mientras el resto del plugin sigue en MIT. Queda abierto si se agrega un `NOTICE` en la raíz.

**Hallazgos (propuestas pendientes de decisión, no implementadas):**
1. **Lethal Trifecta / Regla de Dos** (SAA §2.7.3, §5.5.1): un agente de código reúne por definición datos sensibles, contenido no confiable y comunicación externa. La skill no lo nombra.
2. **Archivos de configuración del repo como vector** (SAA §5.5.1): `CLAUDE.md`, `.claude/`, `mcp.json` de un repo clonado son no confiables; solo la configuración del usuario es confiable. Afecta al modo adopción de `project-init`.
3. **Documentación vs. control** (SAA §3.3.7): "una barrera que no puede observar una llamada antes de ejecutarse es documentación, no defensa". La skill es solo guía; los hooks de Claude Code permitirían bloqueo determinista de lo destructivo. Tensión con ADR-008 (el plugin no incluye scripts): sería receta documentada, no código del plugin.
4. **Integridad de herramientas y plugins** (SAA §6.4.3): fijar versión o hash y volver a aprobar ante cambios; "aprobar una vez y confiar siempre" es la vulnerabilidad. Contradice el AutoUpdate de la ADR-015 y alimenta `ketchup`.
5. **Memoria y contexto envenenados** (ASI06; Data Security): no reingerir salidas propias como memoria de confianza, marcar el origen, retención con vencimiento y borrado de derivados. Aplica a `brain/`, a NOC-001 y al diseño del ítem 9.
6. **Análisis estático y de dependencias del código generado** (SAA §5.2, §6.1): Semgrep o Bandit, `npm audit` o `pip-audit`, typosquats, licencias y procedencia. La skill solo dice "revisar paquete".
7. **Higiene de credenciales y rutas** (SAA §5.5.1): `.claudeignore`, "combinaciones tóxicas" (leer archivo sensible y llamar a algo externo en la misma sesión), operaciones git destructivas.
8. **Minimización y mínimo registro** (Data Security §2.4): enviar al modelo solo lo necesario; no volcar secretos ni datos personales al contexto.
- **Bien alineado:** datos no instrucciones, no instalar en silencio, confirmar lo destructivo, mínimo alcance, no ocultar riesgos en resúmenes, y el modo secuencial sin subagentes (reduce ASI07, ASI08 y ASI10).
- **Corregido:** `agentes-asi-2026.md` (luego fusionado en `agentes-y-datos-owasp.md`) verificado contra el original; nombres exactos de ASI02 y ASI03; ítem 19 reducido.

---

## Sesión — 2026-11-17 — verificación de fuentes de `seguridad-por-diseno`

**Contexto:** ítem 19, verificar las fuentes que la skill tomó de resúmenes de terceros.

- **ASVS 5.0.0 — verificado contra el repositorio oficial** (CSV de `5.0/docs_en`): **345 requisitos** (no "unos 350") en 17 capítulos con los mismos nombres de la referencia; nivel 1 = 70, nivel 2 = 183 nuevos (253 acumulados), nivel 3 = 92 nuevos (345). La referencia `asvs-5.md` se corrigió.
- **ASI 2026 — verificación indirecta:** el PDF original responde "No Access" a la descarga (exige permiso) y no se intentó eludir. Los diez IDs y nombres coinciden en tres fuentes secundarias independientes (Cycode, Indusface, Kratikal). La referencia lo dice así.
- **NIST SSDF 1.2:** la página oficial del proyecto (actualizada el 6-oct-2026) lista la 1.1 y SP 800-218A como finales y no menciona la 1.2; sin evidencia de que sea final.
- **Hallazgo:** existe un proyecto OWASP separado, "Agentic Skills Top 10" (`OWASP/www-project-agentic-skills-top-10`), no leído; podría ser relevante para las skills de este repo.
- **Ítem 19 reducido** a lo que sigue abierto: probar la skill en un proyecto real, leer el PDF de ASI y revisar ese proyecto.

---

## Sesión — 2026-11-17 — Modern Web Guidance como plugin

**Contexto:** el autor propuso sumar Modern Web Guidance al suplemento, por el trabajo con interfaces web, y preguntó si conviene usarlo vía `npx` o como plugin de Claude Code.

- **Decisión (ADR-015):** recomendarlo como plugin desde el marketplace `googlechrome` y no vendorizarlo; el autor estuvo de acuerdo.
- **Hallazgos del README:** la CLI hace búsqueda offline; hay telemetría anónima (IDs de guías y búsquedas del agente) desactivable con `DISABLE_TELEMETRY=1`; no usar la copia de `claude-plugins-official`, que quedó sin actualizar el 12-oct. No se supo qué escribe el asistente de `npx`.
- **Ítem 20 registrado** (Media) con la integración. No se instaló nada: instalar un plugin de terceros lo decide el autor.

---

## Sesión — 2026-11-17 — skill `seguridad-por-diseno`

**Contexto:** tras una semana de ataques informáticos, el autor quería que el código creado con el harness saliera con medidas de seguridad acordes a producción actual, y no conocía una skill externa con ese contenido. Antes de diseñar se revisaron las fuentes vigentes.

**Hitos:**
- **Fuentes verificadas:** OWASP Top 10:2025 (lista de diez categorías confirmada en la página oficial), ASVS 5.0.0 (17 capítulos confirmados en el repositorio oficial). **No verificado contra el original:** la lista ASI 2026 (PDF no accesible; se usó un resumen de Cycode) y NIST SSDF 1.2 (borrador de diciembre de 2025, sin confirmar si es final).
- **Decisiones del autor:** incluir los cuatro marcos (Top 10, ASVS, ASI y STRIDE/SSDF); activación como guía por tipo de cambio, sin bloquear; una sola skill con referencias.
- **ADR-014 y skill `seguridad-por-diseno`:** `SKILL.md` con tabla de controles por tipo de cambio, cinco preguntas de amenaza, reglas para Code como agente y nivel `asvs_nivel`; cuatro referencias (Top 10, ASVS, ASI, STRIDE y SSDF). Ítem 10 cerrado (commit `79bf52b`).
- **Ítem 19 creado:** verificar fuentes y probar la skill en un proyecto real.

### Archivos modificados
- plugins/suplemento-core/skills/seguridad-por-diseno/ (nueva, con `references/`)
- docs/principles.md, CHANGELOG.md
- brain/{ADR-014,index,sesiones}, spec/cerrados.md, SPEC.md

### Próximo
- Ítem 19, y decidir si se sube a 0.16.0 y se publica (ítems 10 a 13 sin publicar).
- Ítems 14 y 18; Gemini en el 16.

---

## Sesión — 2026-11-17 — comando `ketchup` (nombre acordado)

**Contexto:** el autor pidió un comando para revisar las versiones de las skills externas, los plugins y las dependencias, y buscaba nombre. Entre `checkup`, `upkeep`, `stocktake` y `vitals`, prefirió `ketchup`: juego de palabras con *catch up* (ponerse al día), una palabra que no aparece sola al programar, y la imagen de que, si no se hace seguido, las dependencias se "desangran" y manchan el funcionamiento.

- **Ítem 18 registrado** (Media): diseñar `ketchup`, solo lectura con informe y aprobación como `housekeeping`. Quedan abiertas dos decisiones: si consulta internet o solo lo local, y su relación con la skill de seguridad (ítem 10).
- Sin cambios al plugin.

---

## Sesión — 2026-11-17 — "registro" y "boletín" son sinónimos

**Contexto:** al revisar el ítem 17, el autor notó que el proyecto ya usa "registro" y aclaró que "registro" y "boletín" se refieren a lo mismo: una entrada nueva de cualquiera de las plantillas de Brain KMS.

- **Ítem 17 cerrado sin renombrar nada.** El glosario recoge "Registro (o boletín)" como sinónimos. No hay término oficial nuevo ni cambios en skills, runtimes o plantillas.
- **Ítem 16** (Gemini) ajustado: ya no depende del 17.
- Archivos: docs/glossary.md, spec/cerrados.md, SPEC.md, brain/sesiones.md.

---

## Sesión — 2026-11-17 — comando `housekeeping`

**Contexto:** el autor pidió un lugar para hacer limpieza y lint con calma después de una sesión intensa, ya que el tamaño de `SPEC.md` pasó a aviso (ADR-011) y el registro a umbral (ADR-012). Eligió "informe y apruebas" y tres áreas de revisión; dejó fuera las herramientas externas.

**Hitos:**
- **ADR-013 y `commands/housekeeping.md`:** revisión en solo lectura de `SPEC.md` y `spec/`, `brain/` y `sesiones.md`, y plugin/docs/runtimes; informe con hallazgos numerados (mecánico o requiere criterio); aplica solo lo aprobado; commit local sin push; no usa subagentes.
- **Ítem 13 cerrado** (commit `3488526`). Los ítems 15 y 16 de `SPEC.md` quedan pensados para resolverse dentro de un `housekeeping`.
- **Hallazgo:** `docs/decisions.md`, `docs/conventions.md` y `docs/principles.md` seguían diciendo que el registro era solo por `ward` o `keepit` tras el ADR-012; se corrigieron en el mismo commit. Es el tipo de desfase que `housekeeping` debe detectar.
- **Pendiente real:** el comando todavía no se ha probado. La copia instalada del plugin es 0.15.0 y no lo trae; hay que actualizar y reiniciar Claude Code.

### Archivos modificados
- plugins/suplemento-core/{commands/housekeeping.md (nuevo), skills/documentation-convention/SKILL.md}
- README.md, docs/{glossary,workflow,decisions,conventions,principles}.md, CHANGELOG.md
- brain/{ADR-013,index,sesiones}, spec/cerrados.md, SPEC.md

### Próximo
- Decidir si se sube a 0.16.0 y se publica (ítems 11, 12 y 13 sin publicar), y probar `housekeeping` real tras actualizar.
- Ítems 14, 17 y el 10 (seguridad OWASP).

---

## Sesión — 2026-11-17 — registro por umbral

**Contexto:** el autor pidió que Code pueda registrar en `SPEC.md` y `brain/` al terminar una tarea grande, con criterio según el conocimiento nuevo, sin esperar un `ward` explícito. `ward` sigue disponible a mano. Eligió el enfoque autónomo por umbral entre tres opciones (autónomo, proponer y aprobar, mixto por tipo).

**Hitos:**
- **ADR-012 (nuevo):** modo `registro: umbral`, por defecto. Umbral: cierra un ítem de la §3, toma una decisión registrable, o aprende algo no recuperable del código. Commit local sin push, aviso posterior con el hash y la reversión (`git reset --soft HEAD~1`); pregunta antes si hay duda de categoría o contenido sensible; respeta lo que el humano pide no registrar. `keepit` sigue obligatorio y es el único que hace push.
- **Ítem 12 cerrado** (commit `35d73cf`). Sin cambio de versión; figura como "Sin publicar" en el `CHANGELOG`. Gemini queda en el ítem 16.
- **Primera aplicación:** este registro se hizo por umbral, sin esperar un `ward`.

### Archivos modificados
- plugins/suplemento-core/{commands/ward.md, skills/{documentation-convention,spec-driven-development,project-init}/...}
- docs/{glossary,workflow}.md, CLAUDE.md, CHANGELOG.md
- brain/{ADR-012,index,sesiones}, spec/cerrados.md, SPEC.md

### Próximo
- Ítems 13 (`housekeeping`), 14 (revisión de docs y skills), 17 ("boletín") y, de fondo, el 10 (seguridad OWASP).
- Decidir si se sube el plugin a 0.16.0 y se publica con los ítems 11 y 12.

---

## Sesión — 2026-11-17 — criterio orgánico de tamaño de `SPEC.md`

**Contexto:** el autor pidió que el control de tamaño de `SPEC.md` fuera menos rígido (revisar siempre las 600 columnas por línea era demasiado) y que quedara como aviso, no como error duro: los avances, pendientes y cerrados ya tienen sus propios archivos. Hoy hubo además una sesión anterior que ya había retirado los avisos de comandos retirados y la consulta de tamaños de proyecto (commit `7ecc7e7`).

**Hitos:**
- **Ítems 11 a 17 registrados** a partir de lo pedido en la sesión anterior del día: criterio de `SPEC.md` (11), libertad de commits (12), comando `housekeeping` (13), revisión de docs y skills con las herramientas nuevas (14), revisión de skills externas (15), runtime Gemini en un `housekeeping` (16) y "boletín" como nombre genérico de los registros de `brain/` (17).
- **Ítem 11 cerrado.** ADR-011 (reemplaza el tope duro de ADR-006/ADR-008): se elimina la regla de 600 caracteres; las 1000 líneas son una referencia que solo avisa; `ward`/`keepit` conservan solo la lista de consistencia (commit `105144c`). Sin cambio de versión: figura como "Sin publicar" en el `CHANGELOG`.
- **Criterio de diseño:** la pregunta del árbitro de destino ("¿esto lo necesita el agente al abrir la sesión?") pasa a ser el criterio real de tamaño.

### Archivos modificados
- plugins/suplemento-core/{commands/{ward,keepit}.md, skills/spec-driven-development/{SKILL.md,references/normalizacion-spec.md}, skills/project-init/references/{claude-md-template,spec-md-template}.md}
- docs/{spec,conventions,principles,glossary}.md, CLAUDE.md, CHANGELOG.md
- brain/{ADR-011,index,sesiones}, spec/cerrados.md, SPEC.md

### Próximo
- Ítem 12 (libertad de commits; cambia `documentation-convention`), luego 13, 14 y 17. El runtime Gemini y las skills externas quedan para un `housekeeping` (16 y 15).

---


## Sesión — 2026-11-17 — claude-mem: telemetría apagada y dos pendientes nuevos

**Contexto:** el autor actualizó claude-mem (15.19.0) y se molestó por la insistencia hacia el plan Pro (ya había elegido dos veces memoria local) y por la UI que muestra todos sus proyectos juntos. Sesión sin cambios en el repo; todo el trabajo fue diagnóstico y decisiones.

**Decisiones:**
- **Apagar la telemetría y mantener el plugin.** `~/.claude-mem/telemetry.json` pasó a `enabled: false` (respaldo `telemetry.json.bak`). Se sugirió además `DO_NOT_TRACK=1` en `~/.zshrc`; queda a criterio del autor.
- **Graphify no reemplaza a claude-mem.** Es un grafo de conocimiento por proyecto para navegar código, no una memoria de sesiones; aporta poco a este repo (solo Markdown/JSON). Tiene un plan de pago ("Graphify Cloud"). Información tomada de fuentes secundarias; no se leyó el repo oficial.
- **Inventar una memoria propia** (ítem 9 de `SPEC.md`, prioridad Baja mientras claude-mem no sea un impedimento): por proyecto, local, con respaldo en un NVMe de 500 GB que el autor podrá montar más adelante y/o un respaldo externo.
- **Skill de seguridad** (ítem 10, prioridad Media-alta: no se conoce una skill externa con este contenido): OWASP y una metodología moderna, para que el código creado con el harness salga con medidas acordes a producción actual. Motivación: ola de ataques informáticos de esta semana.
- **NOC-001** abierto para vigilar a claude-mem (presión comercial, captura global, telemetría por defecto).

**Verificado:** `setup-state.json` marca el setup como completo y sin plan Pro; el hook insiste igual. Sin sincronización a la nube (`CLOUD_SYNC_*` vacío); worker solo en `127.0.0.1:37700`. El plugin `suplemento-core` está instalado en 0.15.0 (`claude plugin list`), por lo que la nota de la §7 de `SPEC.md` ("instalado en 0.13.0") estaba desactualizada.

### Archivos modificados
- brain/{NOC-001,index,sesiones}, SPEC.md, spec/roadmap-skills.md
- Fuera del repo: `~/.claude-mem/telemetry.json` (+ `.bak`)

### Próximo
- Ítem 10 (skill de seguridad, Media-alta) e ítem 9 (memoria propia, Baja): ambos requieren diseño antes de implementar (`disenar-antes-de-implementar`); el 10 conviene partir revisando las fuentes vigentes de OWASP.
- Ítems 3, 5, 6 y 7 de `SPEC.md`.

---


## Sesión — 2026-10-06 — retiro de `checkpoint` y `listeilor` (0.15.0)

**Contexto:** el autor decidió retirar ambos aliases de inmediato en vez de esperar 4 a 6 semanas: no hay forma de saber si alguien más usa el repo, y los proyectos afectados son los suyos.

- **Archivos borrados:** `commands/checkpoint.md` y `commands/listeilor.md`.
- **Degradación suave:** `documentation-convention` (y `06` en Gemini) indican el comando vigente si el humano dice una palabra retirada. El aviso de colisión se conserva.
- **Versiones:** `suplemento-core` 0.15.0 (cambio incompatible); runtime Gemini 0.1.6. `README`, `CHANGELOG` y glosario actualizados.
- **DEP-001 (nuevo)** e ADR-010 anotado con el retiro del alias.

### Archivos modificados
- plugins/suplemento-core/{.claude-plugin/plugin.json, commands/{checkpoint,listeilor}.md (borrados), skills/{documentation-convention,spec-driven-development}/...}
- runtimes/gemini-antigravity/{runtime.json, skills/06-documentation-convention.md, skills/references/spec-migracion-0.12.md}
- README.md, CHANGELOG.md, docs/glossary.md, spec/datos.md, brain/{DEP-001,ADR-010,index,sesiones}, SPEC.md

### Próximo
- Actualizar el plugin a 0.15.0, reiniciar Claude Code y pasar los proyectos del autor a `ward`/`keepit`.
- Ítems 3, 5, 6 y 7 de `SPEC.md`.

---

## Sesión — 2026-10-06 — `keepit` reemplaza a `listeilor` (0.14.0)

**Contexto:** tras una semana de uso, el autor encontró incómodo "listeilor" para pedir el cierre de sesión (largo, difícil de recordar, chilenismo). Escribió `commands/keepit.md` y pidió reemplazar el nombre en todo el repo.

- **Estado previo:** se cerró el ítem 2 (migración de "paciente cero" probada por el autor con `ward` y `listeilor`; evidencia: su confirmación, proyecto privado). El ítem 8 ya estaba cerrado.
- **Reemplazo en 25 archivos:** comandos, skills, plantilla de `CLAUDE.md`, runtime Gemini, `README`, `docs/`, `spec/datos.md` y el `CLAUDE.md` del repo. Historial (`brain/`, `spec/cerrados.md`, `CHANGELOG` anterior) intacto.
- **`listeilor.md` → alias deprecado** que avisa y ejecuta `keepit`; el aviso de colisión también busca `listeilor`. `keepit.md` se normalizó (el encabezado venía como `**## Instrucciones**` y el frontmatter con líneas en blanco).
- **Versiones:** `suplemento-core` 0.14.0; runtime Gemini 0.1.5 (`core_version` 0.14.0). `README` y `CHANGELOG` actualizados; el `README` decía v0.12.0 en "Estado del proyecto".
- **Error propio corregido:** el `sed` masivo falló la primera vez (zsh no separa palabras en `$files`) y los dos `cat >` fallaron por `noclobber`; se rehicieron con `xargs` y `>|`. La fecha del `CHANGELOG` se puso primero como 2026-10-07 y se corrigió a 2026-10-06.
- **ADR-010 (nuevo):** `keepit` reemplaza a `listeilor`, con alias deprecado.
- **Pendiente heredado:** el ítem 7 (desfase "pasos 1 a 7" en Gemini) sigue abierto; `keepit.md` además dice "pasos 1 a 9" de `ward`, que llega al 10.

### Archivos modificados
- plugins/suplemento-core/{.claude-plugin/plugin.json, commands/{keepit,listeilor,ward,checkpoint}.md, skills/{documentation-convention,spec-driven-development,brain-kms,tdd-workflow,project-init,code-comment-convention}/...}
- runtimes/gemini-antigravity/{GEMINI-RUNTIME.md, runtime.json, skills/{01,06,11,14}, skills/references/{gemini-template,spec-migracion-0.12}.md}
- README.md, CHANGELOG.md, CLAUDE.md, docs/*, spec/{datos,cerrados}.md, brain/{ADR-010,index,sesiones}, SPEC.md

### Próximo
- Reiniciar Claude Code tras actualizar el plugin a 0.14.0; actualizar `listeilor` → `keepit` en los `CLAUDE.md` de los proyectos del autor.
- Ítem 6 (probar la oferta 0a en un proyecto real) e ítems 5 y 7.
- Decidir cuándo retirar el alias `listeilor.md`.

---

## Sesión — 2026-10-06 — `code-comment-convention`: el código como tercera capa (0.13.0)

**Contexto:** el autor había borrado todos los comentarios de un proyecto ExtJS + Supabase y el código quedó difícil de leer en ajustes rápidos: recuperar un "por qué" exigía ir a Brain KMS o pedirle a Code que leyera el SPEC. Escribió la skill `code-comment-convention` y pidió sumarla al plugin, a `project-init` y ofrecerla a proyectos ya instalados.

- **Ítem 4 cerrado ("ya estaba hecho"):** `installed_plugins.json` ya registraba `suplemento-core` 0.12.0 (SHA `f72c699`, 2026-09-30) y `ward`/`listeilor` estaban disponibles; evidencia en `spec/cerrados.md`.
- **Skill incorporada (`cefb21c`):** `suplemento-core` 0.13.0. Se normalizó su frontmatter (tenía líneas en blanco que las otras skills no tienen). El ejemplo ExtJS/Supabase se conserva: es el origen del problema.
- **`project-init`:** `CLAUDE.md` de los proyectos nuevos incluye `## Comentarios en el código` (plantilla y Paso 3, ítem 9).
- **Proyectos ya instalados:** actualizar el plugin no toca su `CLAUDE.md`, así que `ward` y `listeilor` (paso 0a) ofrecen la convención **una sola vez**; si se rechaza queda constancia en `CLAUDE.md`. Guía en `skills/code-comment-convention/references/migracion-0.13.md`. Este repo la aceptó en su propio `CLAUDE.md`.
- **Runtime Gemini 0.1.4** en paridad: `14-code-comment-convention.md` (condensada, con sección de adopción), `06`, `02`, `gemini-template`, `install-gemini.sh` (14 skills), `GEMINI-RUNTIME.md` (árbol y tabla de enrutamiento).
- **Error propio corregido:** la sección nueva de la plantilla de `CLAUDE.md` se insertó primero en medio de "Convención de documentación"; se movió al final del bloque.
- **ADR-009 (nuevo):** el código fuente como tercera capa — Brain KMS (desarrollador), `SPEC.md` (agente), código (ambos).
- **Hallazgo:** en Gemini, `listeilor` manda ejecutar "los pasos 1 a 7" de `ward`, que tiene los pasos 0 a 8; queda como ítem 7 de `SPEC.md`.

### Archivos modificados
- plugins/suplemento-core/{.claude-plugin/plugin.json, commands/{ward,listeilor}.md, skills/code-comment-convention/{SKILL.md,references/migracion-0.13.md}, skills/project-init/{SKILL.md,references/claude-md-template.md}}
- runtimes/gemini-antigravity/{GEMINI-RUNTIME.md, runtime.json, skills/{02,06,14}, skills/references/gemini-template.md}, install-gemini.sh
- .claude-plugin/marketplace.json, README.md, CHANGELOG.md, CLAUDE.md
- brain/{ADR-009,index,sesiones}, spec/cerrados.md, SPEC.md

### Próximo
- Ítem 2 de `SPEC.md` (migrar "paciente cero"); ahí mismo, ítem 6: probar la oferta 0a en un proyecto real.
- Actualizar el plugin instalado a 0.13.0 y reiniciar Claude Code (el instalado es 0.12.0).
- Sin pendientes de alta prioridad.

---

## Sesión — 2026-09-30 — ward/listeilor, SPEC por líneas y cerrados por ID (0.12.0)

**Contexto:** otra instancia de Code (la del proyecto "paciente cero") envió INT-004 (renumerado aquí como INT-001): su `SPEC.md` llegó a 134 KB pese al fix de 0.10.1. Pidió actualizar `suplemento-core` a 0.12.0. Antes de implementar se revisaron las propuestas y el autor corrigió varias (ver ADR-008).

- **Release 0.12.0 (`b8e8d6e`):** `ward`/`listeilor`, `check_spec.sh` con hook opcional, `cerrados.md`, configuración por proyecto, guías de migración y normalización, runtime Gemini 0.1.3 en paridad. Publicado y pusheado.
- **Corrección del autor (`f82fcb1`):** el plugin no debe traer código → se eliminó el script y el hook; el tope pasa a **1000 líneas**, controlado al leer el SPEC y en `ward`/`listeilor` con una lista. Se eliminaron las claves `archivo_cerrados` e `ids_en_pendientes`.
- **`cerrados.md` con nombre fijo**, ID original del pendiente y **orden por ID** (no por llegada). El autor renombra a mano `catastro-historico.md` en el proyecto de origen.
- **`ward` = checkpoint sin push; `listeilor` = cierre de sesión con push.** El nombre `ward` (del lore de internet: guardar algo para volver a revisarlo) además elimina la colisión con el `checkpoint.md` local. `checkpoint` queda deprecado como alias.
- **Hallazgos:** la plantilla de `CLAUDE.md` de `project-init` traía una "Regla de registro inmediato — NO NEGOCIABLE" (otra cara de la contradicción); `project-init/SKILL.md` no tenía el `---` de apertura del frontmatter (la skill no se registraba), corregido; `docs/spec.md` había pasado de la regla original (~1000 líneas) a 15 KB en v0.10.1, ahora se revierte a líneas.
- **README** incorpora cómo actualizar el plugin (Claude Code) y el runtime (Gemini) en proyectos ya en funcionamiento; se retiró `spec/historial.md` de las plantillas de `project-init` y Gemini.
- **ADR-008 (nuevo)** e **INT-001** (renumerado desde INT-004, `Implementado`). Este repo migra su `SPEC.md` (v0.12.0, §3 con IDs), crea `spec/cerrados.md` y depreca `spec/completado.md`.
- **Ítem 1 cerrado** (validación de las 3 skills propias): el autor las probó en uso real en el proyecto "paciente cero" y otros; primer ítem en `spec/cerrados.md`, y `roadmap-skills.md` lo pasa a "Hecho".
- **Observación:** este repo sigue usando el plugin instalado 0.11.0 hasta que el autor lo actualice; `ward`/`listeilor` aún no están disponibles en su Claude Code local.

### Archivos modificados
- plugins/suplemento-core/{.claude-plugin/plugin.json, commands/{ward,listeilor,checkpoint}.md, skills/{spec-driven-development,documentation-convention,project-init,brain-kms,tdd-workflow,raw-data-audit-trail}/}
- runtimes/gemini-antigravity/{GEMINI-RUNTIME.md, runtime.json, skills/{01,06,11}, skills/references/{gemini-template,spec-folder-template,spec-migracion-0.12}.md}, install-gemini.sh
- README.md, CHANGELOG.md, CLAUDE.md, docs/{spec,conventions,workflow,principles,glossary,decisions,brain,getting-started}.md
- brain/{ADR-008,INT-001,index,sesiones}, spec/{cerrados,completado,datos}.md, SPEC.md

### Próximo
- Actualizar el plugin instalado (`claude plugin marketplace update suplemento-estrella` + `claude plugin update suplemento-core@suplemento-estrella`) y reiniciar, para usar `ward`/`listeilor` en este repo.
- Migrar el proyecto "paciente cero" a 0.12.0 y comprobar los criterios de INT-001 §4 con los comandos reales.
- Sin pendientes de alta prioridad; el siguiente ítem abierto es el 2 de `SPEC.md` §3.

---

## Sesión — 2026-09-29 (continuación) — Brain KMS en Claude Code, docs completos y TOASK.md en la raíz

**Contexto:** con el fix de `SPEC.md` ya pusheado, el usuario pidió cerrar los pendientes heredados: renombrar Brain ADR a Brain KMS "y las otras cosas". Aclaró, con el esquema que se había definido originalmente, que los 4 docs vacíos debían completarse (no retirarse) y que `TOASK.md` debía vivir en la raíz.

- **Brain KMS propagado a Claude Code:** la skill `brain-adr` pasó a `brain-kms` (`git mv`), con las referencias actualizadas en Claude Code y Gemini. `brain-adr-template.md` conserva su nombre — es la plantilla de los registros ADR. Cierra el pendiente explícito de ADR-001. Plugin `0.11.0`, runtime Gemini `0.1.2` (`core_version` `0.11.0`).
- **`[N] tests` fuera del mensaje de confirmación de contexto** (5 archivos): el segmento pasa a ser opcional, solo si el proyecto tiene tests. Cierra el pendiente que quedó anotado en la sesión anterior.
- **4 docs completados:** `principles.md`, `decisions.md`, `glossary.md`, `conventions.md`, redactados desde las skills, los ADR y lo que el repo ya aplicaba. `decisions.md` deja explícita la distinción `brain.md ≠ decisions.md`. El usuario definió el propósito de cada uno.
- **Hallazgo:** `docs/spec.md` decía que `SPEC.md` no debería pasar de ~1000 líneas, contradiciendo el tope de ~15 KB de ADR-006 — corregido. El README ahora lista los 4 docs nuevos.
- **ADR-007 (nuevo):** `TOASK.md` se mueve de `brain/` a la raíz del proyecto y `project-init` (ambos runtimes) lo crea ahí. Se detectó que `docs/getting-started.md` ya lo listaba en la raíz, en contradicción con lo que generaba el harness. Los proyectos existentes con `brain/TOASK.md` siguen siendo válidos.
- **Superpowers, decisión marcada como ejecutada:** los 2 ítems S de `TOASK.md` pasan a "Resueltas"; `spec/roadmap-skills.md` los pasa a "Hecho"/"Descartado"; `code-simplicity` deja de depender de Superpowers en su sección de YAGNI. Se dejó abierta en "En curso" solo la validación bajo presión de las 3 skills propias, que el texto original decía que faltaba.
- **Observación:** ese ítem de validación pide un baseline con subagentes, lo que exige aprobación puntual del humano por `sequential-mode`.
- Un cambio cosmético de `docs/plugins.md` ("Claude Mem" en negrita) que no hizo Code entró en el commit — probablemente edición manual del usuario desde el IDE.

### Archivos modificados
- plugins/suplemento-core/skills/brain-kms/ (renombrada desde brain-adr), skills/{code-simplicity,project-init,spec-driven-development}/, project-init/references/{brain-adr-template,claude-md-template}.md, commands/checkpoint.md, plugin.json (0.11.0)
- runtimes/gemini-antigravity/{GEMINI-RUNTIME.md,runtime.json}, skills/{01,02,11}, skills/references/gemini-template.md
- docs/{principles,decisions,glossary,conventions}.md (nuevos), docs/{brain,spec,plugins}.md, README.md
- TOASK.md (movido desde brain/), spec/{completado,roadmap-skills}.md, CHANGELOG.md
- brain/ADR-007-toask-en-la-raiz-del-proyecto.md, brain/ADR-001 (nota de actualización), brain/index.md, brain/sesiones.md, SPEC.md

### Próximo
- Validar bajo presión las 3 skills propias (`spec/roadmap-skills.md`) — requiere aprobación humana puntual si usa subagentes.
- Decisión abierta: si el proyecto consumidor debe actualizar a `0.11.0` para adoptar `brain-kms` y el `TOASK.md` en la raíz.

---

## Sesión — 2026-09-29 — SPEC.md se reemplaza, no se acumula (v0.10.1)

**Contexto:** otra instancia de Code (Tomás 2), trabajando en `promatic-dashboard-pilot`, detectó que `SPEC.md` había crecido de 5 KB a 126 KB (jul→sep 2026) y trajo a este repo un prompt con la causa raíz, verificada en el historial de git del proyecto consumidor.

- **Hallazgo:** las instrucciones de `suplemento-core` decían qué actualizar en `SPEC.md` pero no que había que reemplazar en vez de acumular, ni ponían tope de tamaño, ni decían adónde iban los ítems cerrados. Además, el footer pedía "conteo de tests" incluso en proyectos sin tests y se usó como bitácora.
- **ADR-006 (nuevo):** árbitro de destino + reemplazar-no-acumular + tope de ~15 KB con chequeo `wc -c`/`awk` obligatorio antes del commit. Regla completa en `spec-driven-development`; el resto de los archivos lleva versión corta con puntero.
- **Alcance:** los 12 puntos que indicaba el prompt, en Claude Code y con paridad en Gemini. Verificado con grep (el del prompt y variantes): no queda ninguna instrucción vieja.
- **Versiones:** plugin `suplemento-core` 0.10.0 → 0.10.1; runtime Gemini 0.1.0 → 0.1.1 (`core_version` 0.10.1). Entrada en `CHANGELOG.md`.
- **Push rechazado la primera vez:** `origin/main` tenía 7 commits del usuario (ediciones web sobre `plugins/suplemento-core/skills/project-init/references/dep-template.md`: ASCII art de despedida, notas de uso y crédito del arte). No solapaban con los cambios de esta sesión; se resolvió con `git pull --rebase`, sin forzar.
- **Se aplicó la regla al propio `SPEC.md`:** "Última sesión" y footer sobrescritos, sin bloques "Antes (…)".
- **Descubrimiento:** el `[N] tests` del mensaje de confirmación de contexto sigue en 5 archivos (Claude Code y Gemini) y tampoco aplica a proyectos sin tests — quedó como pendiente, fuera del alcance del prompt.

### Archivos modificados
- plugins/suplemento-core/skills/{spec-driven-development,documentation-convention,brain-adr}/SKILL.md, plugins/suplemento-core/commands/checkpoint.md
- plugins/suplemento-core/skills/project-init/references/{spec-md-template,claude-md-template}.md
- plugins/suplemento-core/.claude-plugin/plugin.json (0.10.1), CLAUDE.md (raíz)
- runtimes/gemini-antigravity/skills/{01-brain-kms,06-documentation-convention,11-spec-driven-development}.md, skills/references/gemini-template.md, runtime.json (0.1.1)
- CHANGELOG.md, brain/ADR-006-spec-md-se-reemplaza-no-se-acumula.md, brain/index.md, brain/sesiones.md, spec/completado.md, SPEC.md

### Próximo
- Quitar `[N] tests` del mensaje de confirmación de contexto en los 5 archivos.
- (Pendientes heredados sin cambios: `docs/conventions.md`/`glossary.md`, destino de `docs/principles.md`/`decisions.md`, renombre Brain KMS en Claude Code, `brain/TOASK.md`.)

---

## Sesión — 2026-09-11 (continuación 6) — Validación en producción: modo adopción funcionó

**Contexto:** el usuario probó en Antigravity IDE, sobre un proyecto real ya inicializado con Claude Code, el flujo completo: `curl | bash` (install-gemini.sh) → `project-init` dentro de Gemini.

- **Resultado: modo adopción de ADR-005 confirmado en producción, no solo en diseño.** El usuario reportó: "La transición desde Claude Code a Gemini quedó completamente establecida y alineada" — corrió el instalador y `project-init` completo, no solo una verificación parcial.
- Sin incidentes reportados en el instalador ni en la detección de proyecto existente — los dos bugs corregidos antes de esta prueba (nombres de archivo en `install-gemini.sh`/`GEMINI-RUNTIME.md`, skill vacía en `02-project-init.md`) no volvieron a aparecer.

### Archivos modificados
- Ninguno — sesión de validación, sin cambios de código.

### Próximo
- (Pendientes heredados sin cambios: `docs/conventions.md`/`glossary.md`, destino de `docs/principles.md`/`decisions.md`, renombre Brain KMS en Claude Code, `brain/TOASK.md`.)

---

## Sesión — 2026-09-11 (continuación 5) — Modo adopción en project-init de Gemini

**Contexto:** el usuario preguntó cómo manejar retomar, con Gemini + Antigravity IDE, un proyecto ya inicializado con Claude Code en la misma carpeta (`SPEC.md`/`brain/`/`CLAUDE.md` ya existentes) — un cambio real de agente e IDE, no solo de carpeta, así que "project-init" ya no aplicaría en modo "crear desde cero".

- **Hallazgo:** `runtimes/gemini-antigravity/skills/02-project-init.md` estaba completamente vacío (0 líneas) — la skill central para este escenario no tenía contenido. Verificado que las 12 skills restantes de Gemini sí tienen contenido (`wc -l` sobre todas).
- **ADR-005 (nuevo):** completa `02-project-init.md` portando el Paso 0 de detección de proyecto existente de Claude Code, agregando un **modo adopción** explícito: si `SPEC.md`/`brain/` ya existen y `GEMINI.md` no, la skill confirma con el usuario, adopta el contexto real (lee `SPEC.md`/`brain/` para poblar `GEMINI.md`, no plantilla en blanco) sin recrear nada, y pregunta si reutilizar el nombre de instancia ya asignado a Claude Code o asignar uno distinto.
- Se descartó crear un script de transición separado — `install-gemini.sh` ya no sobreescribe `GEMINI.md` existente; la lógica de adopción vive en la skill, no en el instalador.

### Archivos modificados
- runtimes/gemini-antigravity/skills/02-project-init.md (completado, antes vacío)
- brain/ADR-005-adopcion-de-proyecto-existente-en-runtime-gemini.md, brain/index.md, brain/sesiones.md
- SPEC.md

### Próximo
- (Pendientes heredados sin cambios: `docs/conventions.md`/`glossary.md`, destino de `docs/principles.md`/`decisions.md`, renombre Brain KMS en Claude Code, `brain/TOASK.md`.)

---

## Sesión — 2026-09-11 (continuación 4) — GEMINI-RUNTIME.md reescrito y aceptado

**Contexto:** el usuario reescribió `runtimes/gemini-antigravity/GEMINI-RUNTIME.md` completo (estructura más formal: target/compatibility/versión en encabezado, misión y principios del agente, mapa de arquitectura, protocolo de apertura de sesión, matriz de enrutamiento de skills, estrategia de git/changelog) y pidió aceptarlo.

- Documento ya alineado con lo decidido en la sesión: SemVer independiente por runtime, Changelog único con etiqueta de capa, Conventional Commits con scope.
- **Corregido antes de aceptar:** el árbol de archivos en §2 repetía el mismo error de nombres ya corregido en `install-gemini.sh` (`gitignore-template.md`, `geminiignore-template.md`, `spec-md-template.md`, `references/trackers/` no existen) — ajustado a los nombres reales.
- **Corregido antes de aceptar:** el encabezado fijaba `Runtime Target: Gemini 1.5 Pro / Ultra`, contradiciendo ADR-003 (que descartó atar el manifest a una versión de modelo específica). Cambiado a `Gemini (Antigravity IDE)`, sin versión.

### Archivos modificados
- runtimes/gemini-antigravity/GEMINI-RUNTIME.md
- brain/sesiones.md

### Próximo
- (Pendientes heredados sin cambios: `docs/conventions.md`/`glossary.md`, destino de `docs/principles.md`/`decisions.md`, renombre Brain KMS en Claude Code, `brain/TOASK.md`.)

---

## Sesión — 2026-09-11 (continuación 3) — Launcher de Gemini terminado, README reorganizado

**Contexto:** el usuario terminó `install-gemini.sh` (instalador de una línea, descarga el runtime a `.gemini/` sin clonar el repo) y trajo un borrador de sección de README con el comando de instalación. Pidió revisar y reorganizar `README.md` (272 líneas, desactualizado) moviendo contenido extenso a `docs/`, que tenía 8 de 10 archivos vacíos.

- **Bug encontrado y corregido en `install-gemini.sh`:** la lista `REFERENCES` pedía nombres de archivo que no existen en `skills/references/` (`gitignore-template.md`, `geminiignore-template.md`, `spec-md-template.md` en vez de `ignore-template.md`, `spec-folder-template.md`, `gemini-template.md`, `trackers-templates.md`) — el script habría fallado en cualquier instalación real (`curl -f`). Corregido antes de seguir.
- **ADR-004 (nuevo):** documenta la reorganización completa — README reducido a landing page (~65 líneas: TL;DR, instalación de ambos runtimes, índice a `docs/`, licencia); contenido movido y repartido en `docs/philosophy.md`, `docs/workflow.md`, `docs/spec.md`, `docs/plugins.md` (nuevos) y `docs/getting-started.md`, `docs/brain.md` (actualizados). Corrige también la nota `// EDIT:` obsoleta sobre Superpowers/claude-mem con el estado real (Superpowers retirado 2026-09-01).
- `docs/conventions.md` y `docs/glossary.md` quedan sin contenido — sin fuente clara en el README, no se inventó nada; pendiente explícito.
- `docs/principles.md` y `docs/decisions.md` quedan sin usar — su contenido esperado se fusionó en `philosophy.md` o no tenía fuente; pendiente evaluar si se fusionan formalmente o se retiran.
- A pedido del usuario, se agregó al final del README: "Hecho en Chile 🇨🇱, con mucho cariño, para todos los amigos y amigas de la sobreingeniería."

### Archivos modificados
- README.md (reescrito)
- docs/philosophy.md, docs/workflow.md, docs/spec.md, docs/plugins.md (nuevos)
- docs/getting-started.md, docs/brain.md (actualizados)
- install-gemini.sh (bug corregido)
- brain/ADR-004-readme-breve-y-docs-como-fuente-detallada.md, brain/index.md, brain/sesiones.md
- SPEC.md

### Próximo
- Completar `docs/conventions.md` y `docs/glossary.md`.
- Decidir destino de `docs/principles.md` y `docs/decisions.md`.
- (Pendientes heredados sin cambios: renombre Brain KMS en Claude Code, `brain/TOASK.md`.)

---

## Sesión — 2026-09-11 — v0.10.0: harness multi-runtime + Brain KMS

**Contexto:** formalización del hito iniciado en la sesión anterior (conversión completa de las 13 skills a `runtimes/gemini-antigravity/`). El usuario pidió registrar el hito, el rebautizo de `brain/` como Brain KMS (nombre sugerido por Gemini), y documentar la decisión de mantener `plugins/suplemento-core/` (Claude Code) en su ubicación actual en vez de reorganizarlo bajo `runtimes/`. A mitad de sesión el usuario corrigió el número de versión propuesto inicialmente (2.0.0 → 0.10.0, semver recién adoptado ~1.5 semanas atrás, sin serie previa real) y pidió reemplazar el eufemismo "brújula" por el término técnico "harness".

- **ADR-001 (nuevo):** primer ADR del proyecto — documenta la decisión multi-runtime, la no-reorganización de Claude Code, el rebautizo a Brain KMS (adoptado en Gemini, pendiente en Claude Code), la fijación de versión `0.10.0` (no `2.0.0`) en `plugin.json`, el versionado independiente por capa (Core/Claude Code/Gemini), y tres hallazgos: `docs/` con 8 de 10 archivos vacíos (sesión de chat no pasada en limpio); el cambio de Claude Code a v5 hace ~2 semanas sin registro de versión propio en su momento; y su causa raíz — al retirar Superpowers, el usuario detectó que Superpowers y `claude-mem` generaban consumo excesivo de tokens porque v5 espera recibir el contexto completo de la tarea de una vez (no una secuencia de tareas chicas), lo que llevaba a `claude-mem` a inyectar automáticamente todo el contexto disponible (incluido `SPEC.md` completo) en cada sesión.
- **`runtimes/README.md`** — documenta la convención: Claude Code queda en `plugins/`, `runtimes/` es para otros agentes.
- **`runtimes/gemini-antigravity/runtime.json`** (nuevo) — versiona el runtime de Gemini de forma independiente (`0.1.0`), con campo `core_version` apuntando a qué versión del Core implementa.
- **`plugin.json`** — primera vez que fija `"version"` (`0.10.0`), antes solo hash de commit; descripción usa "harness".
- **`marketplace.json`** y **`CHANGELOG.md`** de `suplemento-core` — actualizados con "harness", multi-runtime, Brain KMS, y nota sobre el punto de partida de semver.
- **`SPEC.md`** — pendiente de re-sincronizar con 0.10.0 (ver Próximo).

### Archivos modificados
- runtimes/README.md, runtimes/gemini-antigravity/runtime.json
- plugins/suplemento-core/.claude-plugin/plugin.json
- plugins/suplemento-core/CHANGELOG.md
- .claude-plugin/marketplace.json
- brain/ADR-001-harness-multi-runtime-y-brain-kms.md, brain/index.md, brain/sesiones.md

### Próximo
- Evaluar propagar el renombre Brain KMS a `plugins/suplemento-core/skills/brain-adr/` (Claude Code).
- Reconstruir contenido de `docs/` (8 archivos vacíos) cuando el usuario recupere el material de la sesión de chat no traspasada.
- Terminar el launcher de Gemini (en curso por el usuario, fuera de esta sesión de sincronización).
- Revisar `brain/TOASK.md` cuando haya tiempo para las preguntas tipo S.

---

## Sesión — 2026-09-11 (continuación) — CHANGELOG.md único en la raíz

**Contexto:** el usuario consultó a Gemini sobre cómo estructurar el changelog en escenario multi-runtime. Gemini recomendó un único `CHANGELOG.md` en la raíz con entradas etiquetadas por runtime, respaldado por Conventional Commits con scope — pero asumía versionado SemVer lockstep (una sola versión de proyecto compartida), lo que contradice el versionado independiente por capa recién decidido en ADR-001.

- **ADR-002 (nuevo):** adopta el CHANGELOG único en la raíz y Conventional Commits con scope por runtime; **descarta explícitamente** la parte lockstep del consejo de Gemini — se preserva el versionado independiente por capa de ADR-001.
- **`CHANGELOG.md`** (raíz, nuevo) — reemplaza a `plugins/suplemento-core/CHANGELOG.md` (eliminado), migra el historial completo y reestructura la entrada de hoy con etiquetas `[Core]` / `[Runtime Claude Code vX.Y.Z]` / `[Runtime Gemini vX.Y.Z]`.
- **`SPEC.md`** — fila §5 sobre ubicación del changelog actualizada (obsoleta, reemplazada por ADR-002); tabla §1 agrega `CHANGELOG.md` como fuente de la raíz.

### Archivos modificados
- CHANGELOG.md (nuevo, raíz)
- plugins/suplemento-core/CHANGELOG.md (eliminado)
- brain/ADR-002-changelog-unico-en-la-raiz.md, brain/index.md, brain/sesiones.md
- SPEC.md

### Próximo
- Adoptar prefijo de scope por runtime en commits futuros donde aplique (`feat(runtime-gemini)`, `fix(core)`), sin reescribir historial pasado.
- (Pendientes heredados de la sesión anterior, sin cambios: renombre Brain KMS en Claude Code, reconstrucción de `docs/`, launcher de Gemini, `brain/TOASK.md`.)

---

## Sesión — 2026-09-11 (continuación 2) — Licencia MIT y ajuste de runtime.json

**Contexto:** el usuario está armando el launcher de Gemini. Gemini le propuso un `runtime.json` con campos nuevos (`license: MIT`, `author: "Suplemento Estrella"`, `target_model`, `architecture`). El usuario pidió revisar si calzaba con lo ya decidido antes de aceptarlo.

- **ADR-003 (nuevo):** adopta licencia MIT para todo el repo (antes no declarada en ningún lado); corrige `author` de `runtime.json` a la persona real (coherente con `plugin.json`); incorpora el bloque `architecture` de la propuesta de Gemini (aporta valor real); descarta `target_model` (ata el manifest a una versión de modelo que se desactualiza sola).
- **`LICENSE`** (nuevo, raíz) — texto MIT, copyright Orlando (OrcaCl) 2026.
- **`plugin.json`** y **`runtime.json`** — ambos declaran `"license": "MIT"` por igual.
- **`runtime.json`** (Gemini) — agrega `display_name` y `architecture`; corrige `author`; sin `target_model`.

### Archivos modificados
- LICENSE (nuevo)
- plugins/suplemento-core/.claude-plugin/plugin.json
- runtimes/gemini-antigravity/runtime.json
- brain/ADR-003-licencia-mit-y-estructura-runtime-json.md, brain/index.md, brain/sesiones.md
- SPEC.md, CHANGELOG.md

### Próximo
- El usuario continúa armando el launcher de Gemini; sincronizar de nuevo cuando lo tenga.

---

## Sesión — 2026-09-10 — Auditoría y estandarización de 13 Skills (Gemini Runtime)

**Contexto:** Sincronización e integración de la metodología Suplemento Estrella + Brain KMS para el runtime de Gemini en Antigravity IDE.

- **Skill 01 (brain-kms):** Mapeo explícito a plantillas base en `skills/references/` (lectura bajo demanda).
- **Skill 02 (project-init):** Onboarding con regla del par `.gitignore` + `.geminiignore`, doble protección de `brain/files/secure/` y nombrado humano.
- **Skills de Código y Ejecución (03 - 10):** Integración de `code-simplicity`, `depuracion-sistematica` (límite 3 fixes), `disenar-antes-de-implementar` (compuerta dura), `documentation-convention` (checkpoints diferidos), `frontend-conventions` (puente `data-*`), `planificacion-por-fases` (cero placeholders), `raw-data-audit-trail` y `sequential-mode` (tolerancia cero a subagentes autónomos).
- **Skills de Flujo Diario y Stack (11 - 13):** Estandarización de `spec-driven-development` (rutas de enrutamiento sin emojis), `tdd-workflow` (alcance quirúrgico de tests) y `tooling-roles` (matriz agnóstica de stack).
- **Catálogo:** Finalizada la revisión de las 13 skills principales del sistema.

### Archivos modificados
- `skills/01-brain-kms.md` hasta `skills/13-tooling-roles.md`
- `skills/references/*` (Templates estáticos)

### Próximo
- Construir el archivo consolidado `GEMINI-RUNTIME.md` (rework unificado) al retomar en la siguiente sesión.
---

## Sesión — 2026-09-09 — Nombre humano para la instancia en project-init

**Contexto:** el usuario creó `brain/INT-000` documentando por qué le importa darle un nombre humano a la instancia de Code (humanizar y simplificar el trabajo entre los dos miembros del equipo). Pidió incorporar esa práctica al proceso de `project-init` para que todo proyecto nuevo bajo la metodología la ofrezca desde el inicio.

**Hitos:**
- **`project-init/SKILL.md`** — nuevo **Paso 3a** que ofrece al usuario 4 opciones para nombrar la instancia:
  1. Code elige su propio nombre (nombres humanos o referencia popular; nunca grosero/soez).
  2. El usuario asigna el nombre.
  3. Mantener el default: **Tomás**.
  4. Sin nombre — seguir con "Claude Code" / "Code" por omisión.
  El nombre elegido se registra en `CLAUDE.md → ## Contexto del proyecto`. Se agregó el punto 8 al checklist del Paso 3.
- **`references/claude-md-template.md`** — placeholder de la línea del nombre en `## Contexto del proyecto` + nota de uso (origen en Paso 3a, default Tomás, qué hacer con la opción 4).
- **`brain/index.md`** — INT-000 agregado a la tabla de registros (antes vacía).
- **`brain/INT-000...md`** — corregida la sección `## Commit`: apuntaba a una entrada "2026-08-19/20" de `sesiones.md` que nunca existió; ahora apunta a esta sesión. También se ajustó la nota de alcance que referenciaba un INT-001 inexistente.

### Archivos modificados
- plugins/suplemento-core/skills/project-init/SKILL.md
- plugins/suplemento-core/skills/project-init/references/claude-md-template.md
- brain/INT-000-nombre-humano-para-la-instancia.md
- brain/index.md, brain/sesiones.md, SPEC.md

### Próximo
- Revisar `brain/TOASK.md` cuando haya tiempo para las preguntas tipo S.

---

## Sesión — 4 ago 2026 — Inicialización meta de SPEC.md + brain/

**Contexto:** el usuario pidió iniciar el proyecto; se detectó que este repo es el constructor del plugin (no un consumidor), por lo que se aplicó `project-init` en modo uso meta.

- **Estructura creada:** `SPEC.md`, `CLAUDE.md`, `.claudeignore`, `spec/` (completado, datos, historial retirado con easter-egg, roadmap-skills), `brain/` (index, sesiones, TOASK migrado desde la raíz, trackers/, files/).
- **CHANGELOG.md** se ubicó dentro de `plugins/suplemento-core/`, no en la raíz del repo, porque el versionado real es del plugin, no del repo constructor.

### Archivos modificados
- spec/*, brain/*, SPEC.md, CLAUDE.md, .claudeignore, .gitignore, plugins/suplemento-core/CHANGELOG.md

### Próximo
- Completar la Sección 4 (reglas críticas) de SPEC.md/CLAUDE.md a medida que surjan.

---
