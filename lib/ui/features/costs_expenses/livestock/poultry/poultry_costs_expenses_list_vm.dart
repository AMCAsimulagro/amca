/// {@category Features Poultry Costs}
/// ViewModel for poultry costs/expenses list.
library;

import 'package:amca/data/repository/livestock/poultry_fattening_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_batch.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_cost_expense.dart';
import 'package:flutter/foundation.dart';

class PoultryCostsExpensesListVM extends ChangeNotifier {
  PoultryCostsExpensesListVM({required this.batchId});

  final String batchId;
  final PoultryFatteningRepository _repository =
      locator<PoultryFatteningRepository>();

  bool isLoading = true;
  PoultryFatteningBatch? batch;
  List<PoultryFatteningCostExpense> costsAndExpenses = [];

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
    try {
      batch = await _repository.getBatchById(batchId);
      costsAndExpenses = batch?.costsAndExpenses ?? [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
