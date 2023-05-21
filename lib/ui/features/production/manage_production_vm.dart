import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/production.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:flutter/cupertino.dart';

class ManageProductionVM extends ChangeNotifier {
  ManageProductionVM({this.farmingId});

  final FarmingRepository farmingRepository = locator<FarmingRepository>();

  List<CostAndExpense> partProductions = [];

  TransitoryFarming? transitoryFarming;

  bool isLoading = true;
  String? farmingId;

  Future<void> init() async {
    isLoading = true;
    try {
      transitoryFarming =
          await farmingRepository.getTransitoryFarmingById(farmingId!);
    } catch (e) {
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  Future<TransitoryFarming?> createProduction(Production production) async {
    isLoading = true;
    try {
      final totalCostAndExpenses = _calculateTotalCostAndExpense();
     /* transitoryFarming =
          await farmingRepository.getTransitoryFarmingById(farmingId!);*/
    } catch (e) {
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  int _calculateTotalCostAndExpense() {
    int totalCostAndExpense = 0;
    if ((transitoryFarming?.costsAndExpenses ?? []).isNotEmpty) {
      totalCostAndExpense = transitoryFarming?.costsAndExpenses?.map((e) {
        final price =  int.parse(e.price.replaceAll(',', ''));
        return price;
      }).reduce((value, element) => value + element) ?? 0;
    }
    return totalCostAndExpense;
  }
}
