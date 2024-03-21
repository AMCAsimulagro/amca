/// {@category Utils}
/// The `AsyncCallDialogManager` class provides a utility for making asynchronous calls
/// with dialog management, such as showing loading indicators and error dialogs.
///
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:flutter/material.dart';

class CallsWithDialogs {
  /// Executes the provided asynchronous function `call`, showing a loading indicator
  /// during its execution. Handles exceptions by displaying error dialogs.
  ///
  static Future<T?> call<T>(
    BuildContext context,
    Future<T> Function() call,
  ) async {
    try {
      Dialogs.showLoading(context);
      final result = await call().then((value) {
        Dialogs.close(
          context,
        );
      });
      return result as T;
    } on AppException catch (e) {
      Dialogs.close(
        context,
      );
      Dialogs.showErrorDialogByCode(context, codeError: e.codeError);
      rethrow;
    } catch (_) {
      Dialogs.close(
        context,
      );
      Dialogs.showErrorDialogByCode(context);
      rethrow;
    }
  }
}
