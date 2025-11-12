/// {@category Features CostExpense}
/// This file contains the implementation of the [CostsExpensesListVM] class, which serves as the ViewModel for managing
/// the list of costs and expenses related to farming activities. It interacts with the data layer through the [FarmingRepository]
/// to fetch and update farming-related data. The ViewModel provides functionality to initialize data fetching and handles
/// the loading state of the data. Dependencies include the [FarmingRepository], [CostAndExpense] model, and Flutter's [ChangeNotifier].
library;

/// Imports of Bookstores and Resources
import 'package:amca/data/repository/livestock/pig_farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:flutter/cupertino.dart';

/// ViewModel for managing the list of costs and expenses related to farming activities.
class CostsExpensesListVM extends ChangeNotifier {
  CostsExpensesListVM({this.farmingId});

  /// Instance of [PigFarmingRepository] for fetching farming-related data.
  final PigFarmingRepository pigFarmingRepository =
      locator<PigFarmingRepository>();

  /// List of costs and expenses.
  List<CostAndExpense> costsAndExpenses = [];

  bool isLoading = true;

  /// Indicates whether the data is currently being loaded.
  String? farmingId;

  /// The ID of the farming activity.

  /// Initializes the data fetching process.
  Future<void> init() async {
    isLoading = true;
    try {
      final managePigFarmingCostAndExpenses =
          await pigFarmingRepository.getPigFarmingById(farmingId!);
      costsAndExpenses = managePigFarmingCostAndExpenses.costsAndExpenses ?? [];
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }
}
