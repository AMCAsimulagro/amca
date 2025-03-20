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

import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/production.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

/// ## Clase ManageProductionVM
class ManageProductionVM extends ChangeNotifier {
  /// ManageProductionVM constructor with optional farmingId
  ManageProductionVM({this.farmingId});

  /// Farming repository
  final FarmingRepository farmingRepository = locator<FarmingRepository>();

  /// List of CostAndExpense
  List<CostAndExpense> partProductions = [];

  /// TransitoryFarming object
  TransitoryFarming? transitoryFarming;

  /// Indicates if it is loading data
  bool isLoading = true;

  /// Production identifier
  String? farmingId;

  /// ## Function to initialize the class
  Future<void> init() async {
    isLoading = true;
    try {
      /// Loads the current production information
      transitoryFarming =
          await farmingRepository.getTransitoryFarmingById(farmingId!);
    } catch (e) {
      // Handle errors loading data
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  /// ## Function to create a new production
  Future<TransitoryFarming?> createProduction(Production production) async {
    isLoading = true;
    try {
      /// Calculates the total cost and expense

      final profitCrop = transitoryFarming?.profitCrop();

      /// Calculates the total production value
      final totalValueProduction =
          int.parse((production.price.replaceAll(',', ''))) - profitCrop!;

      /// Creates a copy of the production with the updated total value, ID (if missing), and owner ID
      final productionToUpdate = production.copyWith(
        totalValue: totalValueProduction.toString(),
        id: production.id ?? const Uuid().v4(),
        uidOwner: transitoryFarming?.uidOwner,
      );

      /// Creates a copy of TransitoryFarming with the updated production
      transitoryFarming = transitoryFarming?.copyWith(
        production: productionToUpdate,
      );

      /// Saves the updated information to the database
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

  /// ## Function to delete the current production
  Future<TransitoryFarming?> deleteProduction() async {
    isLoading = true;
    try {
      /// Creates a copy of TransitoryFarming with production set to null
      transitoryFarming = transitoryFarming?.copyWith(
        production: null,
      );

      /// Saves the updated information to the database
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
