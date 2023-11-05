import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/data/repository/frequent_question_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/frequent_question.dart';
import 'package:flutter/cupertino.dart';

class ManageFrequentQuestionVM extends ChangeNotifier {
  final FrequentQuestionRepository frequentRepository =
      locator<FrequentQuestionRepository>();
  bool isLoading = true;

  late FrequentQuestion? frequentQuestion;

  ManageFrequentQuestionVM(this.frequentQuestion);

  Future<void> manageFrequentQuestion(FrequentQuestion frequentQuestion) async {
    try {
     await frequentRepository.manageFrequentQuestion(
        frequentQuestion,
      );
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFrequentQuestion() async {
    try {
      await frequentRepository.deleteFrequentQuestion(
        frequentQuestion!,
      );
      return;
    } catch (e) {
      rethrow;
    }
  }
}
