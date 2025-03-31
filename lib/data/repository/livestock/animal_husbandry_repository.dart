/// {@category Repository}
/// This file contains the implementation of an interface `AnimalHusbandryRepository` and its adapter `AnimalHusbandryRepositoryAdapter`
///
/// which provide methods to interact with the Pig Farming API in a Flutter application for managing pig farming-related data.
library;

import 'package:amca/data/api/livestock/pig_farming/animal_husbandry_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/meat/meat_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_production.dart';

/// Abstract class defining methods to interact with the Pig Farming API
abstract class AnimalHusbandryRepository {
  /// Creates a milk new animal husbandry record
  Future<MilkAnimalHusbandry> createMilkAnimalHusbandry(
      MilkAnimalHusbandry animalHusbandry);

  /// Creates a new meat new animal record
  Future<MeatAnimalHusbandry> createMeatAnimalHusbandry(
      MeatAnimalHusbandry animalHusbandry);

  /// Retrieves pig farming history for a specific user
  Future<List<MilkAnimalHusbandry>> getMilkAnimalHusbandryHistoryByUid(
      String? uid);

  Future<List<MeatAnimalHusbandry>> getMeatAnimalHusbandryHistoryByUid(
      String? uid);

  /// Retrieves all pig farming records (admin only)
  Future<List<MilkAnimalHusbandry>> getAllAnimalHusbandryHistoryByAdmin();

  /// Deletes a pig farming record
  Future<void> deleteAnimalHusbandry(String id);

  /// Retrieves costs and expenses for a specific pig farming record
  Future<List<CostAndExpense>> getCostsAndExpensesByAnimalHusbandry(
      String farmingId);

  /// Retrieves a specific pig farming record by ID
  Future<MeatAnimalHusbandry> getMeetById(String farmingId);

  Future<MilkAnimalHusbandry> getMilkById(String farmingId);

  /// Creates a new cost/expense record for pig farming
  Future<CostAndExpense?> createMilkCostExpense(
    CostAndExpense costAndExpense, {
    required MilkAnimalHusbandry farming,
  });

  /// Deletes a cost/expense record from pig farming
  Future<CostAndExpense?> deleteMilkCostExpense(
    String costAndExpenseId, {
    required MilkAnimalHusbandry farming,
  });

  /// Creates a new production record for pig farming
  Future<Production?> createProduction(
    Production production, {
    required MilkAnimalHusbandry farming,
  });

  /// Deletes a production record from pig farming
  Future<Production?> deleteProduction(
    String productionId, {
    required MilkAnimalHusbandry farming,
  });
}

/// Implementation of the `AnimalHusbandryRepository` interface
class AnimalHusbandryRepositoryAdapter implements AnimalHusbandryRepository {
  final AnimalHusbandryApi _api = locator<AnimalHusbandryApi>();

  @override
  Future<MilkAnimalHusbandry> createMilkAnimalHusbandry(
      MilkAnimalHusbandry animalHusbandry) {
    return _api.createMilkAnimalHusbandry(animalHusbandry);
  }

  @override
  Future<MeatAnimalHusbandry> createMeatAnimalHusbandry(
      MeatAnimalHusbandry animalHusbandry) {
    return _api.createMeatAnimalHusbandry(animalHusbandry);
  }

  @override
  Future<List<MilkAnimalHusbandry>> getMilkAnimalHusbandryHistoryByUid(
      String? uid) {
    return _api.getMilkAnimalHusbandryHistoryByUid(uid);
  }

  @override
  Future<List<MilkAnimalHusbandry>> getAllAnimalHusbandryHistoryByAdmin() {
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
  Future<MeatAnimalHusbandry> getMeetById(String farmingId) {
    return _api.getMeatById(farmingId);
  }

  @override
  Future<MilkAnimalHusbandry> getMilkById(String farmingId) {
    return _api.getMilkById(farmingId);
  }

  @override
  Future<CostAndExpense?> createMilkCostExpense(
    CostAndExpense costAndExpense, {
    required MilkAnimalHusbandry farming,
  }) {
    return _api.createPigCostExpense(costAndExpense, farming: farming);
  }

  @override
  Future<CostAndExpense?> deleteMilkCostExpense(
    String costAndExpenseId, {
    required MilkAnimalHusbandry farming,
  }) {
    return _api.deletePigCostExpense(costAndExpenseId, farming: farming);
  }

  @override
  Future<Production?> createProduction(
    Production production, {
    required MilkAnimalHusbandry farming,
  }) {
    return _api.createProduction(production, farming: farming);
  }

  @override
  Future<Production?> deleteProduction(
    String productionId, {
    required MilkAnimalHusbandry farming,
  }) {
    return _api.deleteProduction(productionId, farming: farming);
  }

  @override
  Future<List<MeatAnimalHusbandry>> getMeatAnimalHusbandryHistoryByUid(
      String? uid) {
    return _api.getMeatAnimalHusbandryHistoryByUid(uid);
  }
}
