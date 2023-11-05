import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/data/repository/frequent_question_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/frequent_question.dart';
import 'package:flutter/cupertino.dart';

class FrequentQuestionsVM extends ChangeNotifier {
  final FrequentQuestionRepository frequentRepository =
      locator<FrequentQuestionRepository>();
  List<FrequentQuestion> frequentQuestions = [];
  bool isLoading = true;

  Future<void> init() async {
    isLoading = true;
    try {
      frequentQuestions = await frequentRepository.getFrequentQuestions();
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
