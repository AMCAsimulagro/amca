/// {@category Features CostExpense Manage}
/// This file contains the definition of the `ManageCostExpenseVM` class, which serves as a ViewModel
/// for managing cost and expense data in a Flutter application.

/// Imports of Bookstores and Resources
import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:amca/ui/features/costs_expenses/manage/product_service_data.dart';
import 'package:flutter/cupertino.dart';

/// A ViewModel for managing cost and expense data.
class ManageCostExpenseVM extends ChangeNotifier {
  ManageCostExpenseVM(this.farmingId);

  final FarmingRepository farmingRepository = locator<FarmingRepository>();/// Farming data repository.

  TransitoryFarming? transitoryFarming;/// Transitory farming.

  ProductOrService? productOrServiceSelected;/// Selected product or service.

  Description? descriptionSelected;/// Selected description.

  bool isLoading = true;/// Loading indicator.
  String farmingId;

  Future<void> init() async {
    isLoading = true;
    try {
      transitoryFarming =
          await farmingRepository.getTransitoryFarmingById(farmingId);
    } catch (e) {
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  Future<CostAndExpense?> addCostAndExpenseToFarming(
      CostAndExpense costAndExpense) async {
    try {
      if (transitoryFarming?.production != null) {
        final totalCostAndExpenses =
            transitoryFarming?.calculateTotalCostAndExpense();
        final totalValueProduction = int.parse(
                (transitoryFarming?.production?.price.replaceAll(',', '')) ??
                    '0') -
            totalCostAndExpenses!;
        transitoryFarming = transitoryFarming?.copyWith(
          production: transitoryFarming?.production?.copyWith(
            totalValue: totalValueProduction.toString(),
          ),
        );
      }
      return await farmingRepository.createCastExpense(costAndExpense,
          farming: transitoryFarming!);
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

  Future<CostAndExpense?> deleteCostAndExpense(String costAndExpenseId) async {
    try {
      return await farmingRepository.deleteCostAndExpense(costAndExpenseId,
          farming: transitoryFarming!);
    } catch (e) {
      return null;
    }
  }
}
