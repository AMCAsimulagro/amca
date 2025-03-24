/// {@category Repository}
/// This file contains the implementation of an interface `AnimalHusbandryRepository` and its adapter `AnimalHusbandryRepositoryAdapter`
///
/// which provide methods to interact with the Pig Farming API in a Flutter application for managing pig farming-related data.
library;

import 'package:amca/data/api/livestock/pig_farming/animal_husbandry_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/animal_husbandry.dart';
import 'package:amca/domain/model/livestock/production.dart';

/// Abstract class defining methods to interact with the Pig Farming API
abstract class AnimalHusbandryRepository {
  /// Creates a new pig farming record
  Future<AnimalHusbandry> createAnimalHusbandry(
      AnimalHusbandry animalHusbandry);

  /// Retrieves pig farming history for a specific user
  Future<List<AnimalHusbandry>> getAnimalHusbandryHistoryByUid(String? uid);

  /// Retrieves all pig farming records (admin only)
  Future<List<AnimalHusbandry>> getAllAnimalHusbandryHistoryByAdmin();

  /// Deletes a pig farming record
  Future<void> deleteAnimalHusbandry(String id);

  /// Retrieves costs and expenses for a specific pig farming record
  Future<List<CostAndExpense>> getCostsAndExpensesByAnimalHusbandry(
      String farmingId);

  /// Retrieves a specific pig farming record by ID
  Future<AnimalHusbandry> getAnimalHusbandryById(String farmingId);

  /// Creates a new cost/expense record for pig farming
  Future<CostAndExpense?> createPigCostExpense(
    CostAndExpense costAndExpense, {
    required AnimalHusbandry farming,
  });

  /// Deletes a cost/expense record from pig farming
  Future<CostAndExpense?> deletePigCostExpense(
    String costAndExpenseId, {
    required AnimalHusbandry farming,
  });

  /// Creates a new production record for pig farming
  Future<Production?> createProduction(
    Production production, {
    required AnimalHusbandry farming,
  });

  /// Deletes a production record from pig farming
  Future<Production?> deleteProduction(
    String productionId, {
    required AnimalHusbandry farming,
  });
}

/// Implementation of the `AnimalHusbandryRepository` interface
class AnimalHusbandryRepositoryAdapter implements AnimalHusbandryRepository {
  final AnimalHusbandryApi _api = locator<AnimalHusbandryApi>();

  @override
  Future<AnimalHusbandry> createAnimalHusbandry(
      AnimalHusbandry animalHusbandry) {
    return _api.createAnimalHusbandry(animalHusbandry);
  }

  @override
  Future<List<AnimalHusbandry>> getAnimalHusbandryHistoryByUid(String? uid) {
    return _api.getAnimalHusbandryHistoryByUid(uid);
  }

  @override
  Future<List<AnimalHusbandry>> getAllAnimalHusbandryHistoryByAdmin() {
    return _api.getAllAnimalHusbandryHistoryByAdmin();
  }

  @override
  Future<void> deleteAnimalHusbandry(String id) {
    return _api.deleteAnimalHusbandry(id);
  }

  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByAnimalHusbandry(
      String farmingId) {
    return _api.getCostsAndExpensesByAnimalHusbandry(farmingId);
  }

  @override
  Future<AnimalHusbandry> getAnimalHusbandryById(String farmingId) {
    return _api.getAnimalHusbandryById(farmingId);
  }

  @override
  Future<CostAndExpense?> createPigCostExpense(
    CostAndExpense costAndExpense, {
    required AnimalHusbandry farming,
  }) {
    return _api.createPigCostExpense(costAndExpense, farming: farming);
  }

  @override
  Future<CostAndExpense?> deletePigCostExpense(
    String costAndExpenseId, {
    required AnimalHusbandry farming,
  }) {
    return _api.deletePigCostExpense(costAndExpenseId, farming: farming);
  }

  @override
  Future<Production?> createProduction(
    Production production, {
    required AnimalHusbandry farming,
  }) {
    return _api.createProduction(production, farming: farming);
  }

  @override
  Future<Production?> deleteProduction(
    String productionId, {
    required AnimalHusbandry farming,
  }) {
    return _api.deleteProduction(productionId, farming: farming);
  }
}
