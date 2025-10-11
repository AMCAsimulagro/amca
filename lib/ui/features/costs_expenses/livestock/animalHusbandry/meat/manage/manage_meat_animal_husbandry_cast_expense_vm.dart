/// {@category Features CostExpense Manage}
/// This file contains the definition of the `ManageCostExpenseVM` class, which serves as a ViewModel
/// for managing cost and expense data in a Flutter application.
library;

import 'package:amca/data/repository/livestock/animal_husbandry_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/meat/meat_animal_husbandry.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:amca/ui/features/costs_expenses/manage/product_service_data.dart';
import 'package:flutter/cupertino.dart';

/// A ViewModel for managing cost and expense data.
class ManageCostExpenseVM extends ChangeNotifier {
  ManageCostExpenseVM(this.farmingId);

  final AnimalHusbandryRepository animalHusbandryRepository =
      locator<AnimalHusbandryRepository>();

  /// Farming data repository.

  MeatAnimalHusbandry? meatAnimalHusbandry;

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
      meatAnimalHusbandry =
          await animalHusbandryRepository.getMeatById(farmingId);
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  Future<CostAndExpense?> addCostAndExpenseToFarming(
      CostAndExpense costAndExpense) async {
    try {
      if (meatAnimalHusbandry?.production != null) {
        final totalCostAndExpenses =
            meatAnimalHusbandry?.calculateTotalCostAndExpense();
        final totalValueProduction = int.parse(
                (meatAnimalHusbandry?.production?.price.replaceAll(',', '')) ??
                    '0') -
            totalCostAndExpenses!;
        meatAnimalHusbandry = meatAnimalHusbandry?.copyWith(
          production: meatAnimalHusbandry?.production?.copyWith(
            totalValue: totalValueProduction.toString(),
          ),
        );
      }
      return await animalHusbandryRepository
          .createMeatCostExpense(costAndExpense, farming: meatAnimalHusbandry!);
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
      return await animalHusbandryRepository.deleteMeatCostExpense(
          costAndExpenseId,
          farming: meatAnimalHusbandry!);
    } catch (e) {
      return null;
    }
  }
}
