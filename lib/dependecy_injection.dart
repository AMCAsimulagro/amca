/// {@category Dependency}
///
/// This file contains the dependency injection implementation for the application.
/// It is responsible for registering all the dependencies necessary for communication with the APIs
/// and data repositories related to user authentication, data collection
/// agricultural, frequently asked questions and other services.
///
/// This implementation uses the `GetIt` package to manage dependencies efficiently
/// and centralized.
///
/// {@tool snippet}
/// Example of Use:
/// ```dart
/// DependecyInjection.registerInjections();
/// ```
/// {@end-tool}
import 'package:amca/data/api/farming_api.dart';
import 'package:amca/data/api/frequent_question_api.dart';
import 'package:amca/data/api/login_api.dart';
import 'package:amca/data/api/users_api.dart';
import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/data/repository/frequent_question_repository.dart';
import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/data/repository/state_repository.dart';
import 'package:amca/data/repository/users_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

/// Proporciona una instancia global del servicio de localización de dependencias.
final GetIt locator = GetIt.instance;

/// Clase encargada de la inyección de dependencias.
class DependecyInjection {
  /// Registra todas las inyecciones necesarias para la aplicación.
  static void registerInjections() {
    locator.registerSingleton<StateRepository>(StateRepositoryAdapter());

    locator.registerSingleton<LoginApi>(LoginApiAdapter());
    locator.registerSingleton<LoginRepository>(LoginRepositoryAdapter());

    locator.registerSingleton<FarmingApi>(FarmingApiAdapter());
    locator.registerSingleton<FarmingRepository>(FarmingRepositoryAdapter());

    locator.registerSingleton<UsersApi>(UsersApiAdapter());
    locator.registerSingleton<UsersRepository>(UsersRepositoryAdapter());

    locator
        .registerSingleton<FrequentQuestionApi>(FrequentQuestionApiAdapter());
    locator.registerSingleton<FrequentQuestionRepository>(
        FrequentQuestionRepositoryAdapter());
  }
}
