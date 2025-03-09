/// {@category Features CostExpense Manage}
/// This file contains the definition of the `ManageCostExpenseVM` class, which serves as a ViewModel
/// for managing cost and expense data in a Flutter application.
library;

/// Imports of Bookstores and Resources
import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:amca/domain/model/permanent_farming.dart';
import 'package:amca/ui/features/costs_expenses/manage/product_service_data.dart';
import 'package:flutter/cupertino.dart';

/// A ViewModel for managing cost and expense data.
class ManageCostExpenseVM extends ChangeNotifier {
  ManageCostExpenseVM(this.farmingId);

  final FarmingRepository farmingRepository = locator<FarmingRepository>();/// Farming data repository.

  PermanentFarming? permanentFarming;/// Permanent farming.

  ProductOrService? productOrServiceSelected;/// Selected product or service.

  Description? descriptionSelected;/// Selected description.

  bool isLoading = true;/// Loading indicator.
  String farmingId;

  Future<void> init() async {
    isLoading = true;
    try {
      permanentFarming =
          await farmingRepository.getPermanentFarmingById(farmingId);
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  Future<CostAndExpense?> addCostAndExpenseToFarming(
      CostAndExpense costAndExpense) async {
    try {
      if (permanentFarming?.production != null) {
        final totalCostAndExpenses =
            permanentFarming?.calculateTotalCostAndExpense();
        final totalValueProduction = int.parse(//TODO - Cambiar poss calcular
                (permanentFarming?.production?[0].price.replaceAll(',', '')) ??
                    '0') -
            totalCostAndExpenses!;

        // permanentFarming = permanentFarming?.copyWith(
        //   production: permanentFarming?.production?.copyWith(
        //     totalValue: totalValueProduction.toString(),
        //   ),
        // );

      }
      return await farmingRepository.createCastExpensePermanent(costAndExpense,
          farming: permanentFarming!);
    } catch (e) {
      return null;
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

  Future<CostAndExpense?> deleteCostAndExpensePermanent(String costAndExpenseId) async {
    try {
      return await farmingRepository.deleteCostAndExpensePermanent(costAndExpenseId,
          farming: permanentFarming!);
    } catch (e) {
      return null;
    }
  }
}
