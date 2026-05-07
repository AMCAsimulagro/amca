# Requerimientos - Sección Pollos de Engorde

Este documento describe con detalle los requerimientos que debe cumplir la sección de pollos de engorde dentro de la aplicación. Está redactado en un lenguaje claro para cualquier interesado no técnico y mantiene el rigor necesario para servir de referencia al equipo técnico.

## 1. Requerimientos funcionales

### EN-001 - Registrar y editar lotes de engorde - Funcional
El sistema debe permitir que el usuario inicie un nuevo lote o vuelva a editar uno existente desde el mismo formulario. Los campos requeridos deben ser: nombre del lote, nombre de la granja, cantidad inicial de aves, peso promedio, etapa de producción, raza (con opción para ingresar una raza personalizada), fecha de inicio y fecha estimada de venta. Se debe validar que no queden campos obligatorios vacíos, aceptar números con coma o punto decimal y actualizar automáticamente los títulos y el botón principal cuando se cargue un lote existente. Al guardar, la información debe persistir en la base de datos a través del ViewModel y el repositorio sin duplicar lógica.

### EN-002 - Listar lotes del usuario y permitir acciones rápidas - Funcional
La pantalla principal debe mostrar un listado de los lotes vinculados al usuario autenticado, ordenados por fecha de creación más reciente. Mientras se cargan los datos debe aparecer un indicador de progreso; si no hay lotes, el texto debe indicar que aún no hay registros. El listado debe poder refrescarse arrastrando hacia abajo. Cada tarjeta debe mostrar: nombre del lote, granja, fecha de inicio y cantidad inicial, además de botones para acceder al detalle, editar o eliminar. Antes de eliminar se debe mostrar un diálogo de confirmación que evite acciones accidentales.

### EN-003 - Eliminar lotes con confirmación y actualización local - Funcional
Cuando el usuario confirme la eliminación desde el listado, el lote debe borrarse en el repositorio y desaparecer inmediatamente de la lista sin necesitar recargar toda la vista. El texto del diálogo debe utilizar el mensaje estándar de confirmación y la acción debe ejecutarse dentro de una llamada segura que muestre estados de carga o errores con diálogos amigables.

### EN-004 - Consultar y editar seguimiento semanal - Funcional
Desde el detalle de un lote deben mostrarse los registros semanales de seguimiento. El usuario debe poder crear uno nuevo o actualizar uno existente mediante botones identificados con íconos. Cada registro debe mostrar la semana, fecha, peso final (cuando aplica), alimento consumido y mortalidad. Las modificaciones deben gestionarse con pantallas específicas (como `AddPoultryTrackingPage`) y al hacerlo el lote debe reflejar la información más reciente en el gráfico y la lista.

### EN-013 - Visualizar gráficas de seguimiento - Funcional
La misma pantalla de detalle debe ofrecer pestañas con gráficos para mostrar la evolución del peso promedio, consumo de alimento y mortalidad por semana. Los datos deben provenir de los registros almacenados para el lote y presentarse en tarjetas `ChartCard` con `LineChart` y `BarChart`, de modo que el usuario pueda comparar visualmente el avance sin necesidad de exportar la información.

### EN-005 - Registrar un seguimiento semanal desde flujo específico - Funcional
La pantalla de captura de seguimiento debe solicitar: fecha, tipo de registro (normal o final), consumo de alimento, mortalidad y peso promedio final si corresponde. Las validaciones deben impedir dejar campos obligatorios vacíos y asegurarse de que los números tengan sentido. Al guardar debe crearse un nuevo registro y mostrarse un diálogo de éxito antes de regresar al detalle del lote.

### EN-006 - Gestionar costos y gastos asociados a un lote - Funcional
Desde el detalle del lote debe poder accederse a la pantalla de costos y gastos. Ahí deben listarse los ítems existentes con producto, descripción, tipo (costo/gasto), precio y fecha. El usuario debe poder seleccionar un ítem para modificarlo o agregar uno nuevo, guiado por listas predefinidas de productos y descripciones. Cada operación debe guardarse en Firebase mediante el repositorio y la lista debe refrescarse automáticamente al volver para mostrar los montos actualizados.

### EN-007 - Eliminar un costo o gasto y refrescar el total - Funcional
En la lista de costos y gastos se debe poder borrar un ítem tocando sobre él y confirmando la acción. El sistema debe eliminar la entrada del lote en Firebase y actualizar la lista editada sin recargar todo, manteniendo sincronizados los totales con la información actual.

## 2. Requerimientos no funcionales

### EN-008 - Canalizar operaciones a través del repositorio y Firebase - No funcional
Todas las acciones sobre lotes, seguimientos y costos deben pasar por `PoultryFatteningRepository`, que a su vez delega en `PoultryFatteningApiAdapter`. Esta capa debe conectarse con Firestore, usar la autenticación de Firebase para identificar al usuario y capturar errores específicos (`FirebaseAuthException`), encapsulándolos en `AppException` para mantener trazabilidad de fallos y ofrecer mensajes consistentes.

### EN-009 - Fluidez en la experiencia y manejo de estados - No funcional
Las vistas deben consumir modelos basados en `ChangeNotifier` y usar `Provider` para actualizar solo aquello que cambia. Los indicadores de carga (`CircularProgressIndicator`) y las funciones de refresco (`RefreshIndicator`) deben informar al usuario y evitar bloqueos en pantalla. Las llamadas a la red deben ejecutarse de forma asíncrona (`async/await`) con un manejo de errores centralizado mediante `CallsWithDialogs` para mostrar retroalimentación clara.

### EN-010 - Validación y localización uniforme - No funcional
Los formularios deben reutilizar componentes (`AmcaTextFormField`, `AmcaDatePickerField`) y textos localizados (`AmcaWords`), lo que garantiza mensajes coherentes en español. Los campos numéricos deben aceptar coma o punto decimal y las fechas deben presentarse en formatos locales (`yyyy-MM-dd` para ingreso y `dd/MM/yyyy` para visualización), reduciendo la fricción del usuario.

## 3. Requerimientos de diseño

### EN-011 - Mantener identidad visual y jerarquía visual - Diseño
La paleta verde clara de AMCA debe aplicarse en barras de navegación, botones principales y elementos clave (`AmcaPalette.lightGreen`), mientras que `AmcaWords` debe utilizarse como referencia textual. Las tarjetas de lote, listas y gráficos deben emplear espaciado y tipografía consistentes, con iconos legibles, bordes suaves y `ChartCard` con líneas y barras para resaltar los indicadores más importantes.

### EN-012 - Navegación clara y retroalimentación en cada paso - Diseño
Las transiciones entre pantallas deben hacerse con rutas explícitas (`Navigator.push`) y, al volver, se debe retornar un valor (`Navigator.pop(context, true)`) para refrescar la pantalla origen cuando sea necesario. Los botones de edición/eliminación deben usar colores distintivos (gris y rojo) y los diálogos deben confirmar acciones críticas, proporcionando un flujo predecible y seguro para el usuario.
