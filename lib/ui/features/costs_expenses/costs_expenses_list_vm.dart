import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:flutter/cupertino.dart';

class CostsExpensesListVM extends ChangeNotifier {
  CostsExpensesListVM(this.farmingId);

  final FarmingRepository farmingRepository = locator<FarmingRepository>();

  List<CostAndExpense> costsAndExpenses = [];

  bool isLoading = true;
  String farmingId;

  Future<void> init() async {
    isLoading = true;
    try {
      costsAndExpenses = await farmingRepository.getCostsAndExpensesByFarming(farmingId);
    } catch (e) {
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }
}
