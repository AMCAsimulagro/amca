# ARQUITECTURA AMCA

## 1. Introducción
AMCA es una aplicación móvil Flutter orientada a la gestión financiera y de monitoreo agrícola/livestock. La arquitectura está pensada para separar claramente los aspectos de presentación, dominio, acceso a datos e infraestructura, con especial énfasis en la integración con Firebase, la inyección de dependencias y ViewModels basados en `ChangeNotifier`.

## 2. Índice
1. [Visión General](#3-visión-general)
2. [Capas y Responsabilidades](#4-capas-y-responsabilidades)
3. [Flujo de Datos y Dependencias](#5-flujo-de-datos-y-dependencias)
4. [Gestión del Estado y ViewModels](#6-gestión-del-estado-y-viewmodels)
5. [Integración con Firebase](#7-integración-con-firebase)
6. [Capas de Presentación y Temas](#8-capas-de-presentación-y-temas)
7. [Utilidades y Recursos Auxiliares](#9-utilidades-y-recursos-auxiliares)
8. [Consideraciones de Despliegue](#10-consideraciones-de-despliegue)

## 3. Visión General
El punto de entrada está en `lib/main.dart`, donde se inicializa Firebase, se configura la inyección de dependencias, se fija la orientación de la app, se aplican temas Material 3 y se establece `SplashPage` como pantalla inicial. La aplicación se estructura en capas para mantener la responsabilidad única de cada carpeta principal dentro de `lib/`.

## 4. Capas y Responsabilidades
- **Capa de datos (`lib/data/`)**: contiene los adaptadores a Firebase (`api/`) y los repositorios que abstraen la lógica de persistencia (`repository/`). Se aplica el patrón repositorio para aislar la UI de los detalles de la base de datos.
- **Capa de dominio (`lib/domain/model/`)**: reúne los modelos de negocio (`TransitoryFarming`, `PermanentFarming`, `CostAndExpense`, `CropTypes`, etc.) y excepciones específicas (`AppException`). Son clases inmutables que describen el estado que se comparte entre las capas superiores.
- **Capa de presentación (`lib/ui/`)**: organizada por características, cada subdirectorio (`features/`) agrupa widgets, ViewModels y páginas. También incluye temas, utilidades visuales y widgets reutilizables.
- **Infraestructura (`lib/dependecy_injection.dart`)**: centraliza la inicialización de servicios y repositorios con `GetIt`, exponiendo una instancia global `locator`.

## 5. Flujo de Datos y Dependencias
1. La UI solicita acciones desde un ViewModel (`lib/ui/features/.../..._vm.dart`).
2. El ViewModel obtiene su repositorio a través de `locator<FarmingRepository>()`, que a su vez delega en el API correspondiente (`FarmingApiAdapter`).
3. El API se comunica con Firestore/FirebaseAuth usando `lib/data/api/firebase_collections.dart`, maneja errores y lanza `AppException` cuando es necesario.
4. Los resultados se devuelven al ViewModel, que notifica a los widgets registrados mediante `ChangeNotifier`.

Todos los adaptadores siguen interfaces (`FarmingRepository`, `FarmingApi`, etc.), lo que facilita el mocking para pruebas o el reemplazo de la capa de persistencia en el futuro.

## 6. Gestión del Estado y ViewModels
La app basa su estado en `Provider`/`ChangeNotifier`. En `main.dart`, se configura un `MultiProvider` con `ChangeNotifierProvider` perezoso para `MainNavigationVM`, `FarmingHistoryVM` y demás ViewModels relevantes. Estos modelos (ej. `CreateTransitoryFarmingVM`, `CostsExpensesListVM`) encapsulan la lógica de negocio y exponen propiedades observables (`isLoading`, listas de `CropTypes`, etc.).

## 7. Integración con Firebase
- **Inicialización**: `main()` invoca `Firebase.initializeApp()` con `firebase_options.dart` generado por FlutterFire.
- **Autenticación**: los servicios (`LoginApiAdapter`, `UsersRepositoryAdapter`) usan `FirebaseAuth` para gestionar sesiones.
- **Firestore**: `FarmingApiAdapter` y similares consumen colecciones como `FirebaseCollections.farmingInfo`, gestionan documentos y transforman la respuesta usando `fromJson()` de los modelos.
- **UUID**: se usa `uuid` para claves deterministas de documentos cuando se crean recursos nuevos.

## 8. Capas de Presentación y Temas
- `lib/ui/theme/` define `color_schemes.dart` y `AmcaPalette` para mantener coherencia visual.
- `ui/features/` se divide por dominio (farming, livestock, costs_expenses, splash, main_navigation, etc.) y cada característica contiene páginas, widgets y ViewModels ad-hoc.
- `ui/widgets/` ofrece componentes reutilizables como `AmcaTextFormField` que incorporan validaciones y estilos comunes.

## 9. Utilidades y Recursos Auxiliares
- `lib/ui/utils/` aloja constantes, palabras/localización (`amca_words.dart`), y helpers para colores, fechas y validaciones.
- `docgen` y `dart doc` se pueden ejecutar tal como se describe en `README.md` para generar documentación técnica adicional.

## 10. Consideraciones de Despliegue
1. Ejecutar `flutter pub get` y compilar para las plataformas deseadas (Android/iOS). Banco de claves y certificados (por ejemplo, `keystore.jks`) ya están en el repositorio.
2. Los entornos Firebase se configuran mediante `firebase_options.dart` y credenciales externas.
3. El ciclo de lanzamiento debe incluir pruebas de vista en `lib/ui/features/*` y verificación de las integraciones con Firebase.

> Nota: Este documento se actualiza cuando se agreguen nuevas características o módulos que requieran ajuste de la arquitectura explicada.
