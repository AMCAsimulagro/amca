/// {@category Repository}
/// This file contains the implementation of an interface `FishHusbandryRepository` and its adapter `FishHusbandryRepositoryAdapter`
///
/// which provide methods to interact with the Fish Farming API in a Flutter application for managing fish farming-related data.
library;

import 'package:amca/data/api/livestock/fish_husbandry/fish_husbandry_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/fish_husbandry/fish_husbandry.dart';

/// Abstract class defining methods to interact with the Fish Husbandry API
abstract class FishHusbandryRepository {
  /// Creates a new fish husbandry record
  Future<FishHusbandry> createFishHusbandry(FishHusbandry fishHusbandry);

  /// Retrieves all fish husbandry records
  Future<List<FishHusbandry>> getAllFishHusbandry();

  /// Retrieves fish husbandry history by user ID
  Future<List<FishHusbandry>> getFishHusbandryHistoryByUid(String? uid);

  /// Retrieves all fish farming records (admin only)
  Future<List<FishHusbandry>> getAllFishHistoryByAdmin();

  /// Deletes a fish farming record
  Future<void> deleteFishHusbandry(String id);

  /// Retrieves costs and expenses for a specific fish farming record
  Future<List<CostAndExpense>> getCostsAndExpensesByFish(String farmingId);

  /// Retrieves a specific fish farming record by ID
  Future<FishHusbandry> getFishById(String farmingId);

  /// Creates a new cost/expense record for fish farming
  Future<CostAndExpense?> createFishCostExpense(
    CostAndExpense costAndExpense, {
    required FishHusbandry farming,
  });

  /// Deletes a cost/expense record from fish farming
  Future<CostAndExpense?> deleteFishCostExpense(
    String costAndExpenseId, {
    required FishHusbandry farming,
  });
}

/// Implementation of the `FishHusbandryRepository` interface
class FishHusbandryRepositoryAdapter implements FishHusbandryRepository {
  final FishHusbandryApi _api = locator<FishHusbandryApi>();

  @override
  Future<FishHusbandry> createFishHusbandry(FishHusbandry fishHusbandry) {
    return _api.createFishHusbandry(fishHusbandry);
  }

  @override
  Future<List<FishHusbandry>> getAllFishHusbandry() async {
    return await _api.getAllFishHistoryByAdmin();
  }

  @override
  Future<List<FishHusbandry>> getAllFishHistoryByAdmin() {
    return _api.getAllFishHistoryByAdmin();
  }

  @override
  Future<void> deleteFishHusbandry(String id) {
    return _api.deleteFishHusbandry(id);
  }

  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByFish(String farmingId) {
    return _api.getCostsAndExpensesByFish(farmingId);
  }

  @override
  Future<FishHusbandry> getFishById(String farmingId) {
    return _api.getFishById(farmingId);
  }

  @override
  Future<CostAndExpense?> createFishCostExpense(
    CostAndExpense costAndExpense, {
    required FishHusbandry farming,
  }) {
    return _api.createFishCostExpense(costAndExpense, farming: farming);
  }

  @override
  Future<CostAndExpense?> deleteFishCostExpense(
    String costAndExpenseId, {
    required FishHusbandry farming,
  }) {
    return _api.deleteFishCostExpense(costAndExpenseId, farming: farming);
  }

  @override
  Future<List<FishHusbandry>> getFishHusbandryHistoryByUid(String? uid) {
    return _api.getFishHusbandryHistoryByUid(uid);
  }
}
