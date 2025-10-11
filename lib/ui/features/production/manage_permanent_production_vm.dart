//@ts-check

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
/// * **`permanentFarming`:** `PermanentFarming` object that represents the current production information.
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
import 'package:amca/domain/model/production_permanent.dart';
import 'package:amca/domain/model/permanent_farming.dart';
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
  //List<Production> production = [];

  /// permanentFarming object
  PermanentFarming? permanentFarming;

  /// Indicates if it is loading data
  bool isLoading = true;

  /// Production identifier
  String? farmingId;

  /// ## Function to initialize the class
  Future<void> init() async {
    isLoading = true;
    try {
      /// Loads the current production information
      permanentFarming =
          await farmingRepository.getPermanentFarmingById(farmingId!);
    } catch (e) {
      // Handle errors loading data
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  /// ## Function to create a new production
  Future<PermanentFarming?> createProduction(Production production) async {
    isLoading = true;
    try {
      /// Calculates the total cost , expenses and  inversion initial
      final totalCostAndExpenses = permanentFarming?.profitCrop();

      // Refers to the profits already recorded at the time of cultivation
      final listTotalPrice = permanentFarming?.totalPrice();

      /// Calculates the total production value
      final totalValueProduction =
          int.parse((production.price.replaceAll(',', ''))) + listTotalPrice!;

      final finallyTotalProfit = totalValueProduction - totalCostAndExpenses!;

      /// Creates a copy of the production with the updated total value, ID (if missing), and owner ID
      final productionToUpdate = production.copyWith(
        //totalValue: totalValueProduction.toString(),
        id: production.id ?? const Uuid().v4(),
        uidOwner: permanentFarming?.uidOwner,
      );

      final List<Production> updatedProductions =
          List<Production>.from(permanentFarming?.production ?? []);
      updatedProductions
          .add(productionToUpdate); // Using the null-aware operator

      permanentFarming = permanentFarming?.copyWith(
        production: updatedProductions,
        totalProfit: finallyTotalProfit.toString(),
      );

      /// Saves the updated information to the database
      await farmingRepository.createPermanentFarming(permanentFarming!);
      return permanentFarming;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  /// ## Function to delete the current production
  Future<PermanentFarming?> deleteProduction(int index) async {
    isLoading = true;
    try {
      /// Creates a copy of permanentFarming with production set to null

      final listProducts = permanentFarming?.production;

      if (index >= 0 && index < listProducts!.length) {
        listProducts.removeAt(index);
      }

      final totalCostAndExpenses = permanentFarming?.profitCrop();

      // Refers to the profits already recorded at the time of cultivation
      final listTotalPrice = permanentFarming?.totalPrice();

      /// Calculates the total production value
      final totalValueProduction = listTotalPrice!;

      final finallyTotalProfit = totalValueProduction - totalCostAndExpenses!;

      permanentFarming = permanentFarming?.copyWith(
        production: listProducts!.isEmpty ? null : listProducts,
        totalProfit: finallyTotalProfit.toString(),
      );

      /// Saves the updated information to the database
      final result =
          await farmingRepository.createPermanentFarming(permanentFarming!);
      return result;
    } catch (e) {
      return null;
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }
}
