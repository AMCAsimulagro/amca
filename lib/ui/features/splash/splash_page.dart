import 'package:amca/ui/features/login/options_login_page.dart';
import 'package:amca/ui/features/main_navigation/main_navigation_page.dart';
import 'package:amca/ui/features/splash/splash_vm.dart';
import 'package:amca/ui/utils/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  static ChangeNotifierProvider<SplashVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => SplashVM(),
        child: SplashPage._(key: key),
      );

  const SplashPage._({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _handleSplash();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(Assets.logo),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  void _handleSplash() {
    Future.delayed(const Duration(seconds: 3), () async {
      final vm = Provider.of<SplashVM>(context,listen: false);
      var isLogged = await vm.isLogged();
      if (!mounted) return;
      isLogged
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const MainNavigationPage(),
              ),
            )
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const OptionsLoginPage(),
              ),
            );
    });
  }
}
