/// {@category Features CostExpense}
/// This file contains the implementation of the [CostsExpensesListVM] class, which serves as the ViewModel for managing
/// the list of costs and expenses related to farming activities. It interacts with the data layer through the [FarmingRepository]
/// to fetch and update farming-related data. The ViewModel provides functionality to initialize data fetching and handles
/// the loading state of the data. Dependencies include the [FarmingRepository], [CostAndExpense] model, and Flutter's [ChangeNotifier].

/// Imports of Bookstores and Resources
import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:flutter/cupertino.dart';

/// ViewModel for managing the list of costs and expenses related to farming activities.
class CostsExpensesListVM extends ChangeNotifier {
  CostsExpensesListVM({this.farmingId});

 /// Instance of [FarmingRepository] for fetching farming-related data.
  final FarmingRepository farmingRepository = locator<FarmingRepository>();

/// List of costs and expenses.
  List<CostAndExpense> costsAndExpenses = [];

  bool isLoading = true;  /// Indicates whether the data is currently being loaded.
  String? farmingId;/// The ID of the farming activity.

/// Initializes the data fetching process.
  Future<void> init() async {
    isLoading = true;
    try {
      final transitoryFarming = await farmingRepository.getTransitoryFarmingById(farmingId!);
      costsAndExpenses = transitoryFarming.costsAndExpenses ?? [];
    } catch (e) {
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }
}
