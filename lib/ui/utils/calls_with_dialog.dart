import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:flutter/material.dart';

class CallsWithDialogs {
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
