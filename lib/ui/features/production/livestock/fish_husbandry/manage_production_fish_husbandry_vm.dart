/// {@category Manage Production}
/// This code defines the `ManageProductionVM` class, which is responsible for managing production in the application. The class has the following responsibilities:
///
/// * **Get production information:** Loads the current production data from the database.
/// * **Create a new production:** Creates a new production object and saves it to the database.
/// * **Delete production:** Delete the current production from the database.
///
/// **The class also includes the following properties:**
///
/// * **`partProductions`:** List of `CostAndExpense` objects that represent the costs and expenses of the production.
/// * **`transitoryFarming`:** `TransitoryFarming` object that represents the current production information.
/// * **`isLoading`:** Indicates whether the class is loading data from the database.
/// * **`farmingId`:** Production identifier.
///
/// **The functions of the class are:**
///
/// * **`init()`:** Initializes the class by loading the current production data.
/// * **`createProduction(Production production)`:** Creates a new production object and saves it to the database.
/// * **`deleteProduction()`:** Deletes the current production from the database.
library;

import 'package:amca/data/repository/livestock/fish_husbandry_repository.dart'; //
import 'package:amca/dependecy_injection.dart'; //
import 'package:amca/domain/model/cost_expense.dart'; //
import 'package:amca/domain/model/livestock/fish_husbandry/fish_husbandry.dart'; //
import 'package:amca/domain/model/livestock/fish_husbandry/production.dart'; //
import 'package:flutter/cupertino.dart'; //
import 'package:uuid/uuid.dart'; //

/// ## Clase ManageProductionFishHusbandryVM
class ManageProductionFishHusbandryVM extends ChangeNotifier {
  /// ManageProductionVM constructor with optional farmingId
  ManageProductionFishHusbandryVM({this.farmingId});

  /// Farming repository
  final FishHusbandryRepository fishHusbandryRepository =
      locator<FishHusbandryRepository>();

  /// List of CostAndExpense
  List<CostAndExpense> partProductions = [];

  /// TransitoryFarming object
  FishHusbandry? fishHusbandry;

  /// Indicates if it is loading data
  bool isLoading = true;

  /// Production identifier
  String? farmingId;

  /// ## Function to initialize the class
  Future<void> init() async {
    isLoading = true;
    try {
      /// Loads the current production information
      fishHusbandry = await fishHusbandryRepository.getFishById(farmingId!);
    } catch (e) {
      // Handle errors loading data
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  /// ## Function to create a new production
  Future<FishHusbandry?> createProduction(Production production) async {
    isLoading = true;
    try {
      /// Calculates the total cost and expense
      final profitCrop = fishHusbandry?.calculateTotalCostAndExpense() ?? 0;

      /// Calculates the total production value
      final totalValueProduction =
          int.parse((production.price.replaceAll(',', ''))) - profitCrop;

      /// Creates a copy of the production with the updated total value, ID (if missing), and owner ID
      final productionToUpdate = production.copyWith(
        totalValue: totalValueProduction.toString(),
        id: production.id ?? const Uuid().v4(),
        uidOwner: fishHusbandry?.uidOwner,
      );

      /// Creates a copy of FishHusbandry with the updated production
      fishHusbandry = fishHusbandry?.copyWith(
        production: productionToUpdate,
      );

      /// Saves the updated information to the database
      if (fishHusbandry != null) {
        final result =
            await fishHusbandryRepository.createFishHusbandry(fishHusbandry!);
        return result;
      }
      return null;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  /// ## Function to delete the current production
  Future<FishHusbandry?> deleteProduction() async {
    isLoading = true;
    try {
      if (fishHusbandry != null) {
        /// Creates a copy of FishHusbandry with production set to null
        fishHusbandry = fishHusbandry?.copyWith(
          production: null,
        );

        /// Saves the updated information to the database
        final result =
            await fishHusbandryRepository.createFishHusbandry(fishHusbandry!);
        return result;
      }
      return null;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }
}
