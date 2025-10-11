/// {@category Frequent Questions}
/// This file contains the implementation of the [ManageFrequentQuestionPage] class, which is responsible for managing frequent questions.
/// Users can create, update, or delete frequent questions using this page.
library;

/// Imports of Bookstores and Resources
import 'dart:developer';

import 'package:amca/domain/model/frequent_question.dart';
import 'package:amca/ui/features/frequent_questions/manage_frequent_question/manage_frequent_question_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// StatefulWidget responsible for managing frequent questions.
class ManageFrequentQuestionPage extends StatefulWidget {

  /// Creates a [ManageFrequentQuestionPage].
  ///
  /// The [frequentQuestion] parameter is optional and represents the frequent question to be managed.
  static ChangeNotifierProvider<ManageFrequentQuestionVM> create({
    Key? key,
    FrequentQuestion? frequentQuestion,
  }) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => ManageFrequentQuestionVM(frequentQuestion),
        child: ManageFrequentQuestionPage._(
          key: key,
          frequentQuestion: frequentQuestion,
        ),
      );

  const ManageFrequentQuestionPage._({
    super.key,
    this.frequentQuestion,
  });

/// The frequent question being managed.
  final FrequentQuestion? frequentQuestion;

  @override
  State<ManageFrequentQuestionPage> createState() =>
      _ManageFrequentQuestionPageState();
}

class _ManageFrequentQuestionPageState
    extends State<ManageFrequentQuestionPage> {
  final titleTextCtrl = TextEditingController();
  final contentTextCtrl = TextEditingController();
  late bool isEditMode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isEditMode = widget.frequentQuestion != null;
    titleTextCtrl.text = widget.frequentQuestion?.title ?? '';
    contentTextCtrl.text = widget.frequentQuestion?.content ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.frequentQuestion),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<ManageFrequentQuestionVM>(
        builder: (context, vm, _) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 100,
                left: 24,
                right: 24,
              ),
              children: [
                AmcaTextFormField(
                  textEditingController: titleTextCtrl,
                  labelText: AmcaWords.title,
                  maxLength: 50,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return AmcaWords.pleaseWriteATitle;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AmcaTextFormField(
                  textEditingController: contentTextCtrl,
                  labelText: AmcaWords.content,
                  maxLength: 200,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return AmcaWords.pleaseWriteAContent;
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                AmcaButton(
                  text: widget.frequentQuestion != null
                      ? AmcaWords.update
                      : AmcaWords.create,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _manageFrequentQuestion();
                    }
                  },
                ),
                if (isEditMode)
                  AmcaButton(
                    text: AmcaWords.delete,
                    type: AmcaButtonType.destroy,
                    onPressed: () {
                      showOptionDialog(context);
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _manageFrequentQuestion() async {
    final manageVM = Provider.of<ManageFrequentQuestionVM>(
      context,
      listen: false,
    );

    var frequentQuestion = manageVM.frequentQuestion ??
        FrequentQuestion(
          title: titleTextCtrl.text,
          content: contentTextCtrl.text,
        );
    if (isEditMode) {
      frequentQuestion = frequentQuestion.copyWith(
        title: titleTextCtrl.text,
        content: contentTextCtrl.text,
      );
    }
    try {
      await CallsWithDialogs.call(context, () async {
        await manageVM.manageFrequentQuestion(frequentQuestion);
        await Dialogs.showSuccessDialogWithMessage(
          context,
          isEditMode
              ? AmcaWords.yourFrequentQuestionHaveBeenUpdated
              : AmcaWords.yourFrequentQuestionHaveBeenCreated,
        );
        Navigator.pop(context, true);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> showOptionDialog(BuildContext context) async {
    await Dialogs.showSuccessDialogWithOptions(
        context, AmcaWords.areYouSureToDeleteThisFrequentQuestion,
        onTap: () async {
      await deleteFrequentQuestion();
    });
  }

  Future<void> deleteFrequentQuestion() async {
    final manageVM = Provider.of<ManageFrequentQuestionVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await manageVM.deleteFrequentQuestion();
        await Dialogs.showSuccessDialogWithMessage(
            context, AmcaWords.yourFrequentQuestionHaveBeenDeleted);
        Navigator.pop(context);
      });
    } catch (_) {}
  }
}
