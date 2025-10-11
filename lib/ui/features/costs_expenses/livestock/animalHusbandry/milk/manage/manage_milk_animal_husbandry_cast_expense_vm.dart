/// {@category Features CostExpense Manage}
/// This file contains the definition of the `ManageCostExpenseVM` class, which serves as a ViewModel
/// for managing cost and expense data in a Flutter application.
library;

import 'package:amca/data/repository/livestock/animal_husbandry_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_animal_husbandry.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:amca/ui/features/costs_expenses/manage/product_service_data.dart';
import 'package:flutter/cupertino.dart';

/// A ViewModel for managing cost and expense data.
class ManageCostExpenseVM extends ChangeNotifier {
  ManageCostExpenseVM(this.farmingId);

  final AnimalHusbandryRepository animalHusbandryRepository =
      locator<AnimalHusbandryRepository>();

  /// Farming data repository.

  MilkAnimalHusbandry? animalHusbandry;

  /// Permanent farming.

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
      animalHusbandry = await animalHusbandryRepository.getMilkById(farmingId);
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  Future<CostAndExpense?> addCostAndExpenseToFarming(
      CostAndExpense costAndExpense) async {
    try {
      return await animalHusbandryRepository.createMilkCostExpense(
          costAndExpense,
          farming: animalHusbandry!);
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

  Future<CostAndExpense?> deleteCostAndExpensePermanent(
      String costAndExpenseId) async {
    try {
      return await animalHusbandryRepository.deleteMilkCostExpense(
          costAndExpenseId,
          farming: animalHusbandry!);
    } catch (e) {
      return null;
    }
  }
}
