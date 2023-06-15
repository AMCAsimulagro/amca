import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/production.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

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
      final totalCostAndExpenses = transitoryFarming?.calculateTotalCostAndExpense();
      final totalValueProduction =
          int.parse((production.price.replaceAll(',', ''))) -
              totalCostAndExpenses!;
      final productionToUpdate = production.copyWith(
        totalValue: totalValueProduction.toString(),
        id: production.id ?? const Uuid().v4(),
        uidOwner: transitoryFarming?.uidOwner,
      );
      transitoryFarming = transitoryFarming?.copyWith(
        production: productionToUpdate,
      );
      final result =
          await farmingRepository.createTransitoryFarming(transitoryFarming!);
      return transitoryFarming;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  Future<TransitoryFarming?> deleteProduction() async {
    isLoading = true;
    try {
      transitoryFarming = transitoryFarming?.copyWith(
        production: null,
      );
      final result =
          await farmingRepository.createTransitoryFarming(transitoryFarming!);
      return result;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }
}
