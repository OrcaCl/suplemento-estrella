# Formularios — lista de verificación

> **Fuente y licencia:** adaptado de la guía `forms` de *Modern Web Guidance* (GoogleChrome/modern-web-guidance, https://github.com/GoogleChrome/modern-web-guidance), licencia Apache-2.0 (copia en `LICENSE-Apache-2.0.txt`). **Cambios:** traducido al español, resumido y reorganizado; las reglas de seguridad se cruzan con `seguridad-por-diseno`. Detalle en `NOTICE.md`. Sin respaldo de los autores originales. Se leyó la guía general y, de las 18 guías específicas, la descripción y las reglas destacadas de cada una (sección 11); no su detalle.

Un formulario accesible es también un formulario más fácil de completar y de proteger: las reglas de accesibilidad están en `accesibilidad.md`.

## 1. Estructura

- Envolver los controles en `<form>`, con `action` y `name` en cada control. Un `<search>` para búsquedas y filtros. Nunca `<form>` dentro de `<form>`.
- Con varios formularios en una página, darle nombre a cada uno con `aria-labelledby` apuntando a su encabezado.
- **`method="POST"` para datos sensibles y para cambiar estado; `GET` solo para consultas idempotentes** (el GET queda en el historial y en los logs). Nunca un GET que modifique datos.
- Elementos nativos: `<button type="submit">`, `<textarea>`, `<select>` y el `<input type>` adecuado; nunca `<div>`, `<span>` o `<a>` como controles.
- Poner `type="button"` en los botones secundarios, para que no envíen el formulario por defecto.
- Agrupar controles relacionados con `<fieldset>` y `<legend>` (la leyenda, primer hijo). No usar `fieldset` solo por estilo.
- El botón de envío usa lenguaje de acción ("Guardar cambios") y, en pagos, el monto exacto ("Pagar $100").
- No enviar el formulario automáticamente al cambiar un `select`, radio o checkbox, ni reordenar los controles con CSS en contra del orden del DOM (rompe el orden de Tab).

## 2. Etiquetas y estado

- Toda entrada con `<label for>` asociada. La etiqueta va antes y arriba en campos de texto, `textarea` y `select`; en línea, a continuación, en checkbox y radio.
- Etiquetas visibles. Las instrucciones críticas ("3 a 12 caracteres") en la etiqueta o en un texto de ayuda persistente, nunca solo en el `placeholder`.
- Ayuda y errores enlazados con `aria-describedby`; `aria-invalid="true"` en los controles que fallan la validación propia, y se quita al resolverlos.
- Indicar lo obligatorio de forma visible **y** programática (`required`). No comunicar el estado solo con color: agregar ícono o texto.
- Los errores dinámicos se anuncian con `aria-live`.
- No usar `aria-label` cuando hay una `<label>` visible.

## 3. Autocompletado y ayudas de entrada

- `autocomplete` con el valor correcto (`email`, `tel`, `current-password`, `new-password`, `cc-number`, `cc-exp`, `cc-csc`, `street-address`…).
- `inputmode` para elegir el teclado (`numeric` para PIN) y `enterkeyhint` para la tecla Intro (`next`, `done`).
- Quitar la corrección automática en identificadores, no en prosa: `autocorrect="off"`, `autocapitalize="none"`, `spellcheck="false"` en usuarios, correos, URL, códigos y búsquedas.
- **No usar `type="number"`** para tarjetas, códigos postales ni códigos de un solo uso: elimina ceros iniciales y genera problemas de desplazamiento. Usar `type="text"` con `inputmode="numeric"`.
- Un solo campo para números complejos (tarjeta, teléfono) y para el código de un solo uso (`autocomplete="one-time-code"`); **no** repartirlo en varias cajas que avanzan solas.
- **No bloquear el pegado ni desactivar `autocomplete` en contraseñas y códigos de verificación.**

## 4. Restricciones y validación

- Restricciones nativas primero: `required`, `minlength`, `maxlength`, `pattern`. Estilos de error con `:user-invalid`, **no** con `:invalid` a secas (marcaría campos vacíos antes de que el usuario los toque).
- `setCustomValidity` para mensajes propios, que expliquen cómo corregir el problema.
- Al fallar el envío, mover el foco al primer campo inválido o a un resumen de errores.
- **No deshabilitar el botón de envío para forzar la validación**: dejar enviar y señalar los errores. Sí deshabilitarlo **después** de un envío válido, para evitar envíos duplicados.
- Validar al enviar o al salir del campo (`blur`), no en cada pulsación, y limpiar el error en cuanto se resuelve. Sin anuncios `aria-live` por tecla.

## 5. Diseño responsivo y estilo

- Una columna. Los controles heredan la fuente (`font: inherit`) con un tamaño mínimo de 1rem (16 px) para que iOS no haga zoom.
- Objetivos táctiles amplios (la fuente pide al menos 48 px en móvil; el mínimo de WCAG es 24 px). Unidades `rem`, `line-height` sin unidad y propiedades lógicas (`margin-inline-start`).
- `accent-color` para dar marca a checkbox y radio nativos; `appearance: none` para flechas propias sin romper la semántica.
- Borde del campo con contraste suficiente (`#767676` o más oscuro sobre blanco). **Nunca quitar el foco visible** sin un reemplazo de buen contraste.
- Ocultar un control con la receta de `.visually-hidden` (`clip-path: inset(50%)` y 1 px), **no** con `display: none`, que lo saca del árbol de accesibilidad.

## 6. JavaScript y AJAX

- En campos de chat o texto, comprobar `KeyboardEvent.isComposing` antes de tratar Intro como "enviar": si no, se interrumpe la composición con IME (japonés, chino, coreano).
- En envíos por AJAX, `e.preventDefault()`, anunciar el resultado con `role="status"` o `aria-live`, y `aria-expanded`/`aria-controls` en lo que se despliega.
- **No bloquear el envío si el JavaScript falla:** debe haber una alternativa del lado del servidor.

## 7. Identidad, pagos y seguridad

- `autocomplete="new-password"` al registrarse y `"current-password"` al iniciar sesión; permitir pegar; un botón `type="button"` con `aria-pressed` para mostrar u ocultar la contraseña.
- **HTTPS en todas las páginas. Tokens anti-CSRF criptográficamente seguros** en toda acción que cambie estado (POST, PUT, DELETE). Nunca un GET para modificar datos.
- Sanear la entrada antes de insertarla en el DOM (ver `SKILL.md`, "Seguridad del puente `data-*`"). Sin JavaScript en línea (`onclick="…"`) para poder aplicar una CSP estricta.
- Protección contra spam en formularios abiertos con CAPTCHA accesible o un campo trampa oculto a la tecnología asistiva (`tabindex="-1"` y `aria-hidden="true"`).

## 8. Direcciones y nombres

- Un solo campo para el nombre; no obligar a separar "nombre" y "apellido" en un público global. No exigir solo caracteres latinos.
- `autocomplete="street-address"`; código postal opcional; casilla "Igual que la dirección de envío" cuando se piden dos direcciones (con `shipping`/`billing` en `autocomplete` dentro de un `fieldset`).

## 9. Formularios de varios pasos

- Mostrar el avance con una etiqueta clara y un indicador accesible (`aria-current="step"` o `<progress>`); permitir ir y volver sin perder lo escrito.
- Al cambiar de paso sin recargar, mover el foco al encabezado del paso nuevo (`tabindex="-1"`) o a su primer campo; los pasos inactivos fuera del orden de Tab y del árbol de accesibilidad (`hidden` o `inert`).
- Que el teclado móvil no tape los campos ni los botones.

## 10. Pruebas y analítica

- Probar con teclado solo, varios dispositivos y navegadores, y con usuarios reales: una herramienta automática no basta.
- Medir la tasa de finalización y los puntos de abandono con eventos discretos, **sin registrar datos personales** en las etiquetas de los eventos.

## 11. Guías específicas (descripción y reglas destacadas)

- **Campos obligatorios y validación tardía** (`required-field-feedback`, `validate-input-after-interaction`, `select-menu-interaction`): un campo obligatorio no debe verse inválido al cargar la página; recién cuando el usuario lo tocó y falló. Usar `:user-invalid`. **No** esconder la lista de reglas hasta que el valor sea válido: el usuario necesita saber qué escribir. Un `<select>` obligatorio cuya primera opción tiene valor vacío se marca como inválido de inmediato: mostrar el error solo tras la interacción.
- **Inicio y registro de sesión, direcciones y pagos** (`autofill-sign-in-form`, `autofill-sign-up-form`, `autofill-address-form`, `autofill-payment-form`): siempre `<form>` (no `<div>` con envío solo por JavaScript); `type="email"` para correos y `type="tel"` para teléfonos; `placeholder` nunca como única pista de formato ni en lugar de `<label>`.
- **Código de un solo uso por SMS** (`sms-otp-form`): un único `<input>` con `autocomplete="one-time-code"` e `inputmode="numeric"`; **no** repartir los dígitos en varias cajas.
- **Interruptor** (`switch`): un checkbox nativo con `role="switch"` y su `<label>` (patrón ARIA, no de la fuente): conserva el envío del formulario, el teclado y la semántica.
- **Deslizador** (`slider`): un `<input type="range">` con etiqueta, no `<div>`; foco visible con contraste de 3:1 aunque se quite la apariencia nativa; no combinar pseudoselectores de WebKit y Firefox en una lista separada por comas (el navegador descarta toda la regla).
- **Marca en los controles** (`brand-consistent-forms`): `accent-color` junto con `color-scheme: light dark`; **no** confiar a ciegas en el contraste automático del navegador (errores conocidos en Safari): comprobarlo.
- **Selects:** usar el `<select>` nativo (selector del sistema, teclado y accesibilidad incluidos); no recrearlo con `<div>`s. Verificar el contraste de 3:1 de lo que se estile; sin `z-index` ni bloqueo de scroll ad hoc en listas desplegables.
- **Campos que se ajustan al contenido** (`form-fields-automatically-fit-contents`): `field-sizing: content`.
- **Intro en chats** (`ime-safe-enter-submit`): comprobar `isComposing` antes de enviar (ver sección 6).

