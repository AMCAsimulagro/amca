import 'package:amca/data/api/frequent_question_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/frequent_question.dart';

abstract class FrequentQuestionRepository {
  Future<List<FrequentQuestion>> getFrequentQuestions();

  Future<FrequentQuestion> manageFrequentQuestion(
      FrequentQuestion frequentQuestion);

  Future<void> deleteFrequentQuestion(FrequentQuestion frequentQuestion);
}

class FrequentQuestionRepositoryAdapter extends FrequentQuestionRepository {
  final FrequentQuestionApi _api = locator<FrequentQuestionApi>();

  @override
  Future<List<FrequentQuestion>> getFrequentQuestions() {
    return _api.getFrequentQuestions();
  }

  @override
  Future<FrequentQuestion> manageFrequentQuestion(
      FrequentQuestion frequentQuestion) {
    return _api.manageFrequentQuestion(frequentQuestion);
  }

  @override
  Future<void> deleteFrequentQuestion(FrequentQuestion frequentQuestion) {
    return _api.deleteFrequentQuestion(frequentQuestion);
  }
}
