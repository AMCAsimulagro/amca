# ARQUITECTURA BD AMCA

## 1. Introducción
Este informe técnico describe cómo AMCA organiza su base de datos sobre Firebase. Explica las colecciones principales, los modelos de dominio persistidos, las relaciones implícitas, los repositorios y APIs encargados de leer/escribir datos, y las consideraciones de seguridad y despliegue.

## 2. Índice
1. [Visión General de la Persistencia](#3-visión-general-de-la-persistencia)
2. [Colecciones Firebase y su Responsabilidad](#4-colecciones-firebase-y-su-responsabilidad)
3. [Modelos y Estructura de Documentos](#5-modelos-y-estructura-de-documentos)
4. [Repositorios, APIs y Flujo de Lectura/Escritura](#6-repositorios-apis-y-flujo-de-lecturaescritura)
5. [Seguridad y Reglas Contextuales](#7-seguridad-y-reglas-contextuales)
6. [Integración con Firebase Auth y Métodos de Identificación](#8-integración-con-firebase-auth-y-métodos-de-identificación)
7. [Consideraciones de Escalabilidad y Mantenimiento](#9-consideraciones-de-escalabilidad-y-mantenimiento)

## 3. Visión General de la Persistencia
AMCA persiste su estado principal en Firestore, respaldado por FirebaseAuth y, en menor medida, Storage/UUID para nuevas entidades. Las colecciones están centralizadas en `lib/data/api/firebase_collections.dart`, manteniendo los nombres en constantes para evitar errores de escritura y facilitar refactors @lib/data/api/firebase_collections.dart#1-24.

## 4. Colecciones Firebase y su Responsabilidad
- **`users`**: aloja perfiles de usuarios autenticados (datos básicos, roles, metas). Relaciona documentos con farming mediante el campo `uidOwner`.
- **`farmingInfo` y `farming`**: registros de tipos de cultivo y configuraciones iniciales que alimentan formularios de creación. La colección `farmingInfo` es usada por `FarmingApi` para traer `CropTypes` @lib/data/api/farming_api.dart#22-124.
- **`sembrados`, `tiposDeSembrado`, `permanentcroptypes`**: catálogos auxiliares que soportan menús desplegables y validaciones en tiempo de ejecución.
- **`farmingPermanent` y las colecciones específicas de ganadería (`pigFarming`, `fishFarming`, `poultry`, etc.)**: contienen los historiales permanentes y transitorios para diferentes dominios de producción @lib/data/api/firebase_collections.dart#12-24.
- **`frequentQuestions`**: mantiene preguntas frecuentes para las secciones de ayuda.

## 5. Modelos y Estructura de Documentos
Los modelos en `lib/domain/model/` controlan la forma de los documentos Firestore:
- `TransitoryFarming`: campos de metadata (`createDate`, `partName`, `cropType`, etc.), costo/producción (`CostAndExpense`, `Production`) y referencia al propietario (`uidOwner`). Se serializa/deserializa con `fromJson`/`toJson`. @lib/domain/model/transitory_farming.dart#28-93
- `PermanentFarming` y `CostAndExpense`: estructuras similares que describen operaciones a más largo plazo y cada registro de gasto asociado.
- Otros modelos clave (`CropTypes`, `Production`, `Spawn`, etc.) proveen datos auxiliares para formularios y reportes.

Cada documento Firestore incluye subcolecciones o campos anidados (p. ej. `costsAndExpenses`) almacenados como listas de mapas de objetos `CostAndExpense` y se guardan directamente dentro del documento padre.

## 6. Repositorios, APIs y Flujo de Lectura/Escritura
- `FarmingRepository` define la interfaz de acceso; `FarmingRepositoryAdapter` delega en `FarmingApiAdapter` para comunicarse con Firestore @lib/data/repository/farming_repository.dart#1-222.
- `FarmingApiAdapter` se conecta a `FirebaseFirestore.instance` y `FirebaseAuth.instance`, ejecutando operaciones CRUD y manejando excepciones mediante `AppException` @lib/data/api/farming_api.dart#99-124.
- Los ViewModels (`CreateTransitoryFarmingVM`, `CostsExpensesListVM`, etc.) obtienen repositorios vía `GetIt` y notifican a la UI con `ChangeNotifier`. Este patrón asegura que todos los accesos a Firestore pasen por un único canal por colección, permitiendo controles de caching, logging y reintentos centralizados.

## 7. Seguridad y Reglas Contextuales
Aunque las reglas Firestore no están en el repositorio, la aplicación se diseñó para usarlas así:
- Usuarios autenticados (con UID) solo pueden leer/escribir documentos con `uidOwner` igual a su UID.
- Los administradores (roles administrativos dentro del campo de usuario) pueden acceder a colecciones generales (`farming`, `farmingPermanent`).
- Se recomienda activar `AppException` para encuadrar errores de permisos y mostrar retroalimentación amigable.

## 8. Integración con Firebase Auth y Métodos de Identificación
Los repositorios de login (`LoginRepositoryAdapter`, `UsersRepositoryAdapter`) utilizan `FirebaseAuth` para mantener sesiones y refrescar tokens. Cada documento relevante incluye el UID del dueño, facilitando la segmentación por usuario y la aplicación de reglas de seguridad. Las referencias a `FirebaseAuth.instance` dentro de los APIs aseguran que las operaciones se firman con credenciales válidas.

## 9. Consideraciones de Escalabilidad y Mantenimiento
1. **Nombres centrales**: al usar constantes (`FirebaseCollections`) se facilita agregar nuevas colecciones sin propagar strings.
2. **Desacoplamiento**: al separar repositorios de APIs se pueden reemplazar Firebase por otro proveedor (SQL, REST) sin tocar la UI.
3. **Pruebas**: la interfaz de repositorio permite mocks que simulen Firestore.
4. **Monitorización**: se recomienda instrumentar los repositorios para rastrear tiempos de respuesta y operaciones fallidas (especialmente a la hora de escribir gastos y producción).
5. **Copia de seguridad**: exportar documentos de las colecciones críticas (farming/transitory/permanent) mediante herramientas de Firebase o scripts de `firebase-tools`.

> Mantén este documento actualizado cuando se introduzcan nuevas colecciones (por ejemplo, para módulos de ganadería específicos) o cuando cambie la estrategia de persistencia.
