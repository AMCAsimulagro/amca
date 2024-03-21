/// {@category Dependency Injection}
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

/// Singleton locator instance for dependency injection.
final GetIt locator = GetIt.instance;

/// Class responsible for registering injections in the application.
class DependecyInjection {
  /// Registers all necessary dependencies in the application.
  static void registerInjections() {
    locator.registerSingleton<StateRepository>(StateRepositoryAdapter());

    locator.registerSingleton<LoginApi>(LoginApiAdapter());
    locator.registerSingleton<LoginRepository>(LoginRepositoryAdapter());

    locator.registerSingleton<FarmingApi>(FarmingApiAdapter());
    locator.registerSingleton<FarmingRepository>(FarmingRepositoryAdapter());

    locator.registerSingleton<UsersApi>(UsersApiAdapter());
    locator.registerSingleton<UsersRepository>(UsersRepositoryAdapter());

    locator.registerSingleton<FrequentQuestionApi>(FrequentQuestionApiAdapter());
    locator.registerSingleton<FrequentQuestionRepository>(
        FrequentQuestionRepositoryAdapter());
  }
}
