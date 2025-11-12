/// {@category Features CostExpense Manage}
/// This file contains the definition of the `ManageCostExpenseVM` class, which serves as a ViewModel
/// for managing cost and expense data in a Flutter application.
library;

import 'package:amca/data/repository/livestock/fish_husbandry_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/livestock/fish_husbandry/fish_husbandry.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:amca/ui/features/costs_expenses/manage/product_service_data.dart';
import 'package:flutter/cupertino.dart';

/// A ViewModel for managing cost and expense data.
class ManageCostExpenseVM extends ChangeNotifier {
  ManageCostExpenseVM(this.farmingId);

  final FishHusbandryRepository fishHusbandryRepository =
      locator<FishHusbandryRepository>();

  /// Farming data repository.

  FishHusbandry? fishHusbandry;

  /// Transitory farming.

  ProductOrService? productOrServiceSelected;

  /// Selected product or service.

  Description? descriptionSelected;

  /// Selected description.

  bool isLoading = true;

  /// Loading indicator.
  String farmingId;

  Future<void> init() async {
    isLoading = true;
    try {
      fishHusbandry = await fishHusbandryRepository.getFishById(farmingId);
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  Future<CostAndExpense?> addCostAndExpenseToFarming(
      CostAndExpense costAndExpense) async {
    try {
      if (fishHusbandry?.production != null) {
        final totalCostAndExpenses =
            fishHusbandry?.calculateTotalCostAndExpense();
        final totalValueProduction = int.parse(
                (fishHusbandry?.production?.price.replaceAll(',', '')) ?? '0') -
            totalCostAndExpenses!;
        fishHusbandry = fishHusbandry?.copyWith(
          production: fishHusbandry?.production?.copyWith(
            totalValue: totalValueProduction.toString(),
          ),
        );
      }
      return await fishHusbandryRepository.createFishCostExpense(costAndExpense,
          farming: fishHusbandry!);
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
      return await fishHusbandryRepository
          .deleteFishCostExpense(costAndExpenseId, farming: fishHusbandry!);
    } catch (e) {
      return null;
    }
  }
}
