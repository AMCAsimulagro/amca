import 'package:amca/data/api/farming_api.dart';
import 'package:amca/data/api/login_api.dart';
import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/data/repository/login_repository.dart';
import 'package:amca/data/repository/state_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

class DependecyInjection {
  static void registerInjections() {
    locator.registerSingleton<StateRepository>(StateRepositoryAdapter());
    locator.registerSingleton<LoginApi>(LoginApiAdapter());
    locator.registerSingleton<LoginRepository>(LoginRepositoryAdapter());
    locator.registerSingleton<FarmingApi>(FarmingApiAdapter());
    locator.registerSingleton<FarmingRepository>(FarmingRepositoryAdapter());
  }
}
