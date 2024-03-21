/// {@category Login}
import 'package:amca/ui/features/login/forgot_password/forgot_password_vm.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/assets.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/utils/extensions/string_extensions.dart';
import 'package:amca/ui/widgets/amca_back_button.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage._({super.key});

  static ChangeNotifierProvider<ForgotPasswordVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => ForgotPasswordVM(),
        child: ForgotPasswordPage._(key: key),
      );

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ForgotPasswordVM>(context);
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            height: double.infinity,
            width: double.infinity,
            image: AssetImage(Assets.background),
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const AmcaBackButton(),
                    Text(
                      AmcaWords.recoverPassword,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Card(
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
                              Text(
                                AmcaWords.recoverPasswordSummary,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              AmcaTextFormField(
                                textEditingController: _emailController,
                                textInputType: TextInputType.emailAddress,
                                labelText: AmcaWords.email,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                ],
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return AmcaWords.pleaseAddEmail;
                                  }
                                  if (!value!.isValidEmail()) {
                                    return AmcaWords.pleaseAddValidEmail;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              AmcaButton(
                                text: AmcaWords.recoverPassword,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    recoverPassword(vm);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> recoverPassword(ForgotPasswordVM vm) async {
    try {
      await CallsWithDialogs.call(context, () async {
        await vm.recoverPassword(_emailController.text.trim());
        await Dialogs.showSuccessDialogWithMessage(
          context,
          AmcaWords.emailHasBeenSentToRecoverYourPassword,
        );
        Navigator.pop(context);
      });
    } catch (_) {}
  }
}
