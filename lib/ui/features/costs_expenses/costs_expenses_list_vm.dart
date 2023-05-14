import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:flutter/cupertino.dart';

class CostsExpensesListVM extends ChangeNotifier {
  CostsExpensesListVM({this.farmingId});

  final FarmingRepository farmingRepository = locator<FarmingRepository>();

  List<CostAndExpense> costsAndExpenses = [];

  bool isLoading = true;
  String? farmingId;

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
