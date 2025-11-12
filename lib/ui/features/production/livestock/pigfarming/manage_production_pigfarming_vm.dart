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

import 'package:amca/data/repository/livestock/pig_farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/pig_farming/pig_farming.dart';
import 'package:amca/domain/model/livestock/pig_farming/production.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

/// ## Clase ManageProductionVM
class ManageProductionPigfarmingVm extends ChangeNotifier {
  /// ManageProductionVM constructor with optional farmingId
  ManageProductionPigfarmingVm({this.farmingId});

  /// Farming repository
  final PigFarmingRepository pigFarmingRepository =
      locator<PigFarmingRepository>();

  /// List of CostAndExpense
  List<CostAndExpense> partProductions = [];

  /// TransitoryFarming object
  PigFarming? pigFarming;

  /// Indicates if it is loading data
  bool isLoading = true;

  /// Production identifier
  String? farmingId;

  /// ## Function to initialize the class
  Future<void> init() async {
    isLoading = true;
    try {
      /// Loads the current production information
      pigFarming =
          await pigFarmingRepository.getPigFarmingById(farmingId!);
    } catch (e) {
      // Handle errors loading data
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  /// ## Function to create a new production
  Future<PigFarming?> createProduction(Production production) async {
    isLoading = true;
    try {
      /// Calculates the total cost and expense

      final profitCrop = pigFarming?.profit();

      /// Calculates the total production value
      final totalValueProduction =
          int.parse((production.price.replaceAll(',', ''))) - profitCrop!;

      /// Creates a copy of the production with the updated total value, ID (if missing), and owner ID
      final productionToUpdate = production.copyWith(
        totalValue: totalValueProduction.toString(),
        id: production.id ?? const Uuid().v4(),
        uidOwner: pigFarming?.uidOwner,
      );

      /// Creates a copy of TransitoryFarming with the updated production
      pigFarming = pigFarming?.copyWith(
        production: productionToUpdate,
      );

      /// Saves the updated information to the database
      await pigFarmingRepository.createPigFarming(pigFarming!);
      return pigFarming;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  /// ## Function to delete the current production
  Future<PigFarming?> deleteProduction() async {
    isLoading = true;
    try {
      /// Creates a copy of TransitoryFarming with production set to null
      pigFarming = pigFarming?.copyWith(
        production: null,
      );

      /// Saves the updated information to the database
      final result = await pigFarmingRepository.createPigFarming(pigFarming!);
      return result;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }
}
