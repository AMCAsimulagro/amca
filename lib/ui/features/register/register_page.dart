/// {@category Register}
library;
import 'package:amca/domain/model/amca_user.dart';
import 'package:amca/ui/features/register/register_vm.dart';
import 'package:amca/ui/features/webview_page/webview_page.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/assets.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/utils/extensions/string_extensions.dart';
import 'package:amca/ui/widgets/amca_back_button.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_select_form_field.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage._({super.key});

  /// Factory method to create a [ChangeNotifierProvider] for [RegisterVM].

  static ChangeNotifierProvider<RegisterVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => RegisterVM()..loadStatesAndCities(),
        child: RegisterPage._(key: key),
      );

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _secondLastNameController = TextEditingController();
  final _identifierNameController = TextEditingController();
  final _stateController = TextEditingController();
  final _townController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final states = context.watch<RegisterVM>().states;
    final towns = context.watch<RegisterVM>().towns;
    final vm = Provider.of<RegisterVM>(context);
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
                      AmcaWords.fillAllFields,
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
                              AmcaTextFormField(
                                textEditingController: _nameController,
                                labelText: AmcaWords.names,
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return AmcaWords.pleaseAddName;
                                  }
                                  if (value!.length < 3) {
                                    return AmcaWords.pleaseAddValidName;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              AmcaTextFormField(
                                textEditingController: _lastNameController,
                                labelText: AmcaWords.firstLastName,
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return AmcaWords.pleaseAddLastName;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              AmcaTextFormField(
                                textEditingController:
                                    _secondLastNameController,
                                labelText: AmcaWords.secondLastName,
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return AmcaWords.pleaseAddSecondLastName;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              AmcaTextFormField(
                                textEditingController:
                                    _identifierNameController,
                                textInputType: TextInputType.number,
                                labelText: AmcaWords.identifier,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return AmcaWords.pleaseAddIdentifier;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              AmcaSelectFormField(
                                labelText: AmcaWords.state,
                                textEditingController: _stateController,
                                options:
                                    states.map((e) => e.departamento!).toList(),
                                validator: (stateSelected) {
                                  if (stateSelected != null &&
                                      stateSelected.isEmpty) {
                                    return AmcaWords.pleaseSelectState;
                                  }
                                  return null;
                                },
                                optionSelected: (optionSelected) {
                                  _townController.clear();
                                  vm.setState(optionSelected);
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              AmcaSelectFormField(
                                labelText: AmcaWords.town,
                                textEditingController: _townController,
                                options: towns,
                                optionSelected: (townSelected) {},
                                validator: (townSelected) {
                                  if (townSelected != null &&
                                      townSelected.isEmpty) {
                                    return AmcaWords.pleaseSelectTown;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
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
                              AmcaTextFormField(
                                textEditingController: _passwordController,
                                labelText: AmcaWords.password,
                                obscureText: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                ],
                                validator: (pass) {
                                  if (pass != null && pass.isEmpty) {
                                    return AmcaWords.pleaseAddPassword;
                                  }
                                  if (pass != _repeatPasswordController.text) {
                                    return AmcaWords.differentPasswords;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              AmcaTextFormField(
                                textEditingController:
                                    _repeatPasswordController,
                                labelText: AmcaWords.repeatPassword,
                                obscureText: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(
                                      RegExp(r'\s')),
                                ],
                                validator: (pass) {
                                  if (pass != null && pass.isEmpty) {
                                    return AmcaWords.pleaseAddRepeatPassword;
                                  }
                                  if (pass != _passwordController.text) {
                                    return AmcaWords.differentPasswords;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: vm.acceptPolicies,
                                    onChanged: (value) {
                                      vm.acceptPolicies = !vm.acceptPolicies;
                                    },
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => const WebViewPage(
                                              title: AmcaWords.dataPolicy,
                                              url: AmcaWords.policyUrl,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        AmcaWords.acceptPolicies,
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: Colors.lightBlue,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              AmcaButton(
                                text: AmcaWords.register,
                                onPressed: () async {
                                  if (!vm.acceptPolicies) {
                                    await Dialogs.showErrorDialogWithMessage(
                                      context,
                                      AmcaWords.youShouldAcceptPolicies,
                                    );
                                    return;
                                  }
                                  if (_formKey.currentState!.validate() &&
                                      vm.acceptPolicies) {
                                    createUser(vm);
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

  Future<void> createUser(RegisterVM vm) async {
    final user = AmcaUser(
      names: _nameController.text.trim(),
      firstLastName: _lastNameController.text.trim(),
      secondLastName: _secondLastNameController.text.trim(),
      identification: _identifierNameController.text.trim(),
      state: _stateController.text.trim(),
      town: _townController.text.trim(),
      email: _emailController.text.trim(),
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await vm.createUser(user, _passwordController.text.trim());
        await Dialogs.showSuccessDialogWithMessage(
          context,
          AmcaWords.yourAccountHasBeenCreated,
        );
        Navigator.pop(context);
      });
    } catch (_) {}
  }
}
