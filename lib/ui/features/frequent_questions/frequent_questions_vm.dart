/// {@category Frequent Questions}
/// This file contains the view model class `FrequentQuestionsVM` which is responsible for managing frequently asked questions (FAQs).
/// The [FrequentQuestionsVM] class provides functionality for retrieving and managing a list of frequently asked questions. It interacts with the [FrequentQuestionRepository] to fetch FAQs from the data source.

/// Imports of Bookstores and Resources
import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/data/repository/frequent_question_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/frequent_question.dart';
import 'package:flutter/cupertino.dart';

/// View model class for managing frequently asked questions.
class FrequentQuestionsVM extends ChangeNotifier {
  final FrequentQuestionRepository frequentRepository =
      locator<FrequentQuestionRepository>();

  /// List of frequent questions.
  List<FrequentQuestion> frequentQuestions = [];
  bool isLoading = true;

  /// Method to initialize the view model.
  /// Retrieves the list of frequent questions from the repository.
  Future<void> init() async {
    isLoading = true;
    try {
      frequentQuestions = await frequentRepository.getFrequentQuestions();
    } catch (e) {
      // Handle any errors that occur during initialization.
    } finally {
      isLoading = false;
      // Notify listeners that the initialization process is complete.
      notifyListeners();
    }
  }
}
