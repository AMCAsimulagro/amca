/// {@category Main}
import 'package:amca/dependecy_injection.dart';
import 'package:amca/firebase_options.dart';
import 'package:amca/ui/features/costs_expenses/costs_expenses_list_vm.dart';
import 'package:amca/ui/features/main_navigation/main_navigation_vm.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/features/splash/splash_page.dart';
import 'package:amca/ui/theme/color_schemes.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Función principal que inicia la aplicación.
///
/// Este método es el punto de entrada de la aplicación Flutter.
/// Inicializa Firebase, registra las dependencias, configura el idioma y
/// lanza la aplicación.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterNativeSplash.remove();
  DependecyInjection.registerInjections();
  await Jiffy.setLocale('es');
  runApp(const MyApp());
}

/// Aplicación principal de la aplicación.
///
/// Esta clase crea la estructura de la aplicación y define el tema general.
/// También registra los proveedores de cambio notificable para la gestión del estado.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: true,
          create: (context) => FarmingHistoryVM(),
        ),
        ChangeNotifierProvider(
          lazy: true,
          create: (context) => MainNavigationVM(),
        ),
      ],
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          title: 'Amca',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            fontFamily: 'Arial Rounded MT Bold',
            appBarTheme: const AppBarTheme(
              backgroundColor: AmcaPalette.lightGreen,
              foregroundColor: Colors.white,
            ),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es'),
            Locale('es_us'),
          ],
          home: SplashPage.create(),
        ),
      ),
    );
  }
}
