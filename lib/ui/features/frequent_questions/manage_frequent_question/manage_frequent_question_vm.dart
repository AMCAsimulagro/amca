/// {@category Frequent Questions}
/// This file contains the implementation of the [ManageFrequentQuestionVM] class, which is responsible for managing frequent questions.
library;

/// Imports of Bookstores and Resources
// import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/data/repository/frequent_question_repository.dart';
import 'package:amca/dependecy_injection.dart';
// import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/frequent_question.dart';
import 'package:flutter/cupertino.dart';

/// ViewModel class responsible for managing frequent questions.
class ManageFrequentQuestionVM extends ChangeNotifier {

  /// Instance of the frequent question repository.
  final FrequentQuestionRepository frequentRepository =
      locator<FrequentQuestionRepository>();
  bool isLoading = true;/// Flag indicating whether data is loading.

  late FrequentQuestion? frequentQuestion;/// The frequent question being managed.

  ManageFrequentQuestionVM(this.frequentQuestion);/// Creates an instance of [ManageFrequentQuestionVM].

  /// Manages a frequent question, either creating or updating it.
  Future<void> manageFrequentQuestion(FrequentQuestion frequentQuestion) async {
    try {
     await frequentRepository.manageFrequentQuestion(
        frequentQuestion,
      );
      return;
    } catch (e) {
      // Rethrow the exception to be handled by the caller.
      rethrow;
    }
  }

  /// Deletes a frequent question.
  Future<void> deleteFrequentQuestion() async {
    try {
      await frequentRepository.deleteFrequentQuestion(
        frequentQuestion!,
      );
      return;
    } catch (e) {
       // Rethrow the exception to be handled by the caller.
      rethrow;
    }
  }
}
