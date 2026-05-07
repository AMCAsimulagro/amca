/// {@category Features Poultry Costs}
/// ViewModel for managing poultry cost/expense items.
library;

import 'package:amca/data/repository/livestock/poultry_fattening_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_batch.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_cost_expense.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:amca/ui/features/costs_expenses/manage/product_service_data.dart';
import 'package:flutter/foundation.dart';

class ManagePoultryCostExpenseVM extends ChangeNotifier {
  ManagePoultryCostExpenseVM(this.batchId);

  final String batchId;
  final PoultryFatteningRepository _repository =
      locator<PoultryFatteningRepository>();

  PoultryFatteningBatch? batch;
  ProductOrService? productOrServiceSelected;
  Description? descriptionSelected;
  bool isLoading = true;

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
    try {
      batch = await _repository.getBatchById(batchId);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setProductOrServiceSelected(String name, {bool updateScreen = true}) {
    productOrServiceSelected = ProductServiceData.productServiceList
        .firstWhere((element) => name == element.productOrServiceName);
    if (updateScreen) {
      notifyListeners();
    }
  }

  void setDescriptionSelected(String name, {bool updateScreen = true}) {
    descriptionSelected = productOrServiceSelected?.description
        .firstWhere((element) => name == element.description);
    if (updateScreen) {
      notifyListeners();
    }
  }

  Future<PoultryFatteningCostExpense?> addCostExpense(
    PoultryFatteningCostExpense costExpense,
  ) async {
    if (batch == null) return null;
    return _repository.createCostExpense(costExpense, batch: batch!);
  }

  Future<void> deleteCostExpense(String costExpenseId) async {
    if (batch == null) return;
    await _repository.deleteCostExpense(costExpenseId, batch: batch!);
  }
}
