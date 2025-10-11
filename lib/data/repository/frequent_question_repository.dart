/// {@category Repository}
/// This file contains the implementation of an interface `FrequentQuestionRepository` and its adapter `FrequentQuestionRepositoryAdapter`
/// 
/// which provide methods to interact with the Frequent Question API in a Flutter application for managing frequent question-related data.
library;

/// Imports of Bookstores and Resources
import 'package:amca/data/api/frequent_question_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/frequent_question.dart';

/// Abstract class defining methods to interact with the Frequent Question API for managing frequent question-related data.
abstract class FrequentQuestionRepository {
  Future<List<FrequentQuestion>> getFrequentQuestions();/// Retrieves all frequent questions from the Frequent Question API.

  Future<FrequentQuestion> manageFrequentQuestion(
      FrequentQuestion frequentQuestion);/// Manages a frequent question in the Frequent Question API.

  Future<void> deleteFrequentQuestion(FrequentQuestion frequentQuestion); /// Deletes a frequent question from the Frequent Question API.
}

/// Implementation of the `FrequentQuestionRepository` interface.
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
