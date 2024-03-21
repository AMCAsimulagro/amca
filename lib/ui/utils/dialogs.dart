/// {@category Utils}
/// Class that contains static methods to display different types of dialogs.

import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:amca/ui/utils/firebase_exception_code.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';

class Dialogs {
  /// Displays a loading dialog with a circular progress indicator.
  ///
  /// This dialog cannot be closed by tapping outside of it.
  static Future<void> showLoading(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return const _Dialog();
      },
    );
  }

  /// Displays an error dialog with a message based on the given error code.
  ///
  /// This dialog can be closed by tapping outside of it.
  static Future<void> showErrorDialogByCode(BuildContext context,
      {String? codeError}) {
    return showDialog(
      barrierDismissible: false,

      /// Displays an error dialog with a message based on the given error code.
      ///
      /// This dialog can be closed by tapping outside of it.
      context: context,
      builder: (_) {
        return _Dialog(
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline_sharp,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  ApiExceptionsCode.getAuthMessage(
                      codeError ?? Constants.generalError),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                AmcaButton(
                  text: AmcaWords.accept,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Displays a success dialog with a provided message.
  ///
  /// This dialog can be closed by tapping outside of it.
  static Future<void> showSuccessDialogWithMessage(
      BuildContext context, String message) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return _Dialog(
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: AmcaPalette.darkGreen,
                  size: 60,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                AmcaButton(
                  text: AmcaWords.accept,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Displays an error dialog with a provided message.
  ///
  /// This dialog can be closed by tapping outside of it.
  static Future<void> showErrorDialogWithMessage(
      BuildContext context, String message) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return _Dialog(
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline_sharp,
                  color: Colors.red,
                  size: 60,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                AmcaButton(
                  text: AmcaWords.accept,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Displays a success dialog with a message and button options provided.
  ///
  /// This dialog can be closed by tapping outside of it.
  static Future<void> showSuccessDialogWithOptions(
    BuildContext context,
    String message, {
    String? button1,
    String? button2,
    required Function() onTap,
  }) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return _Dialog(
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          button2 ?? AmcaWords.cancel,
                          style: const TextStyle(
                            color: AmcaPalette.lightGreen,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        onTap();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          button1 ?? AmcaWords.accept,
                          style: const TextStyle(
                            color: AmcaPalette.lightGreen,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Displays a success dialog with a text field and button options provided.
  ///
  /// This dialog can be closed by tapping outside of it.
  static Future<void> showSuccessDialogWithTextField(
    BuildContext context,
    String? labelText, {
    String? title,
    String? button1,
    String? button2,
    String? value,
    final FormFieldValidator<String>? validator,
    required Function(String) onTap,
  }) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        final textController = TextEditingController();
        if ((value ?? '').isNotEmpty) {
          textController.text = value!;
        }
        final _formKey = GlobalKey<FormState>();
        return _Dialog(
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title ?? '',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AmcaTextFormField(
                    textEditingController: textController,
                    textInputType: TextInputType.text,
                    maxLength: 30,
                    labelText: labelText,
                    validator: validator,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            button2 ?? AmcaWords.cancel,
                            style: const TextStyle(
                              color: AmcaPalette.lightGreen,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pop();
                            onTap(textController.text);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            button1 ?? AmcaWords.accept,
                            style: const TextStyle(
                              color: AmcaPalette.lightGreen,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Closes the current dialog if it is mounted.
  ///
  /// If [mounted] is `false`, no action is taken.
  static void close(
    BuildContext context, {
    bool mounted = true,
  }) {
    if (!mounted) return;
    Navigator.pop(context, true);
  }
}
/// Widget privado que define el aspecto de un diálogo genérico.
class _Dialog extends StatelessWidget {
  const _Dialog({
    super.key,
    this.content,
  });

  /// The content of the dialog.
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: content ??
            Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(
                  height: 15,
                ),
                Text('${AmcaWords.loading}...')
              ],
            ),
      ),
    );
  }
}
