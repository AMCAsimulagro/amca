import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/ui/features/login/forgot_password/forgot_password_page.dart';
import 'package:amca/ui/features/login/login_vm.dart';
import 'package:amca/ui/features/main_navigation/main_navigation_page.dart';
import 'package:amca/ui/features/register/register_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/assets.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static ChangeNotifierProvider<LoginVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => LoginVM(),
        child: LoginPage._(key: key),
      );

  LoginPage._({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginVM>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: AmcaPalette.darkGreen,
      body: Stack(
        children: [
          const Image(
            height: double.infinity,
            width: double.infinity,
            image: AssetImage(Assets.background),
            fit: BoxFit.cover,
          ),
          const Image(
            image: AssetImage(Assets.logo),
            height: 220,
            width: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RegisterPage.create()));
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  AmcaWords.doNotHaveAnAccount,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Card(
              margin: const EdgeInsets.all(16),
              surfaceTintColor: Colors.white,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AmcaTextFormField(
                        labelText: AmcaWords.identifier,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(
                              RegExp(r'\s')),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) {
                          vm.identification = value;
                        },
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return AmcaWords.pleaseWriteIdentifier;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      AmcaTextFormField(
                        obscureText: true,
                        onChanged: (value) {
                          vm.password = value;
                        },
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return AmcaWords.pleaseWritePassword;
                          }
                          return null;
                        },
                        labelText: AmcaWords.password,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => ForgotPasswordPage.create()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                AmcaWords.forgotPassword,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AmcaButton(
                        text: AmcaWords.logIn,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            doLogin(
                              context,
                              vm,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> doLogin(
    BuildContext context,
    LoginVM vm,
  ) async {
    try {
      await CallsWithDialogs.call(context, () async {
        await vm.doLogin();
      });
      NavigationHelper.pushAndRemoveUntil(const MainNavigationPage(), context);
    } catch (_) {}
  }
}
