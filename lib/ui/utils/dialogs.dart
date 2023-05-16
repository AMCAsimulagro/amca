import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:amca/ui/utils/firebase_exception_code.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showLoading(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return const _Dialog();
      },
    );
  }

  static Future<void> showErrorDialogByCode(BuildContext context,
      {String? codeError}) {
    return showDialog(
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

  static void close(
    BuildContext context, {
    bool mounted = true,
  }) {
    if (!mounted) return;
    Navigator.pop(context,true);
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog({
    super.key,
    this.content,
  });

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
