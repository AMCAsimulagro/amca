import 'package:amca/dependecy_injection.dart';
import 'package:amca/firebase_options.dart';
import 'package:amca/ui/features/costs_expenses/costs_expenses_list_vm.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/features/splash/splash_page.dart';
import 'package:amca/ui/theme/color_schemes.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  DependecyInjection.registerInjections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: true,
          create: (context) => FarmingHistoryVM(),
        ),
      ],
      child: Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: (_) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MaterialApp(
          title: 'Amca',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            fontFamily: 'Arial Rounded MT Bold',
            appBarTheme: const AppBarTheme(
              backgroundColor: AmcaPalette.lightGreen,
              foregroundColor: Colors.white, //here you can give the text color
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            fontFamily: 'Arial Rounded MT Bold',
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es'),
          ],
          home: SplashPage.create(),
        ),
      ),
    );
  }
}
