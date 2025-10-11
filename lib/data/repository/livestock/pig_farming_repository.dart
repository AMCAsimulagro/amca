/// {@category Repository}
/// This file contains the implementation of an interface `PigFarmingRepository` and its adapter `PigFarmingRepositoryAdapter`
/// 
/// which provide methods to interact with the Pig Farming API in a Flutter application for managing pig farming-related data.
library;

import 'package:amca/data/api/livestock/pig_farming/pig_farming_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/pig_farming/pig_farming.dart';
import 'package:amca/domain/model/livestock/pig_farming/production.dart';

/// Abstract class defining methods to interact with the Pig Farming API
abstract class PigFarmingRepository {
  /// Creates a new pig farming record
  Future<PigFarming> createPigFarming(PigFarming pigFarming);
  
  /// Retrieves pig farming history for a specific user
  Future<List<PigFarming>> getPigFarmingHistoryByUid(String? uid);
  
  /// Retrieves all pig farming records (admin only)
  Future<List<PigFarming>> getAllPigFarmingHistoryByAdmin();
  
  /// Deletes a pig farming record
  Future<void> deletePigFarming(String id);
  
  /// Retrieves costs and expenses for a specific pig farming record
  Future<List<CostAndExpense>> getCostsAndExpensesByPigFarming(String farmingId);
  
  /// Retrieves a specific pig farming record by ID
  Future<PigFarming> getPigFarmingById(String farmingId);
  
  /// Creates a new cost/expense record for pig farming
  Future<CostAndExpense?> createPigCostExpense(
    CostAndExpense costAndExpense, {
    required PigFarming farming,
  });
  
  /// Deletes a cost/expense record from pig farming
  Future<CostAndExpense?> deletePigCostExpense(
    String costAndExpenseId, {
    required PigFarming farming,
  });
  
  /// Creates a new production record for pig farming
  Future<Production?> createProduction(
    Production production, {
    required PigFarming farming,
  });
  
  /// Deletes a production record from pig farming
  Future<Production?> deleteProduction(
    String productionId, {
    required PigFarming farming,
  });
}

/// Implementation of the `PigFarmingRepository` interface
class PigFarmingRepositoryAdapter implements PigFarmingRepository {
  final PigFarmingApi _api = locator<PigFarmingApi>();

  @override
  Future<PigFarming> createPigFarming(PigFarming pigFarming) {
    return _api.createPigFarming(pigFarming);
  }

  @override
  Future<List<PigFarming>> getPigFarmingHistoryByUid(String? uid) {
    return _api.getPigFarmingHistoryByUid(uid);
  }

  @override
  Future<List<PigFarming>> getAllPigFarmingHistoryByAdmin() {
    return _api.getAllPigFarmingHistoryByAdmin();
  }

  @override
  Future<void> deletePigFarming(String id) {
    return _api.deletePigFarming(id);
  }

  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByPigFarming(String farmingId) {
    return _api.getCostsAndExpensesByPigFarming(farmingId);
  }

  @override
  Future<PigFarming> getPigFarmingById(String farmingId) {
    return _api.getPigFarmingById(farmingId);
  }

  @override
  Future<CostAndExpense?> createPigCostExpense(
    CostAndExpense costAndExpense, {
    required PigFarming farming,
  }) {
    return _api.createPigCostExpense(costAndExpense, farming: farming);
  }

  @override
  Future<CostAndExpense?> deletePigCostExpense(
    String costAndExpenseId, {
    required PigFarming farming,
  }) {
    return _api.deletePigCostExpense(costAndExpenseId, farming: farming);
  }

  @override
  Future<Production?> createProduction(
    Production production, {
    required PigFarming farming,
  }) {
    return _api.createProduction(production, farming: farming);
  }

  @override
  Future<Production?> deleteProduction(
    String productionId, {
    required PigFarming farming,
  }) {
    return _api.deleteProduction(productionId, farming: farming);
  }
}