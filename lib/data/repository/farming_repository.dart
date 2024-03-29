/// {@category Repository}
/// This file contains the implementation of an interface `FarmingRepository` and its adapter `FarmingRepositoryAdapter`
/// 
/// which provide methods to interact with the Farming API in a Flutter application for managing farming-related data.

/// Imports of Bookstores and Resources
import 'package:amca/data/api/farming_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/transitory_farming.dart';

/// Abstract class defining methods to interact with the Farming API for managing farming-related data.
abstract class FarmingRepository {
  Future<List<CropTypes>> getCropTypes();/// Retrieves all crop types from the Farming API.

  Future<List<String>> getSown();/// Retrieves all types of sown crops from the Farming API.

  Future<TransitoryFarming> createTransitoryFarming(
      TransitoryFarming transitoryFarming);/// Creates a new transitory farming record in the Farming API.

  Future<TransitoryFarming> getTransitoryFarmingById(String farmingId);/// Retrieves a transitory farming record by its ID from the Farming API.

  Future<List<TransitoryFarming>> getFarmingHistoryByUid(String? uid);/// Retrieves all farming history for a specific user by their UID from the Farming API.

  Future<void> deleteTransitoryFarming(String id);/// Deletes a transitory farming record by its ID from the Farming API.

  Future<List<TransitoryFarming>> getAllFarmingHistoryByAdmin();/// Retrieves all farming history for all users from the Farming API (admin only).

  Future<List<CostAndExpense>> getCostsAndExpensesByFarming(String farmingId);/// Retrieves all costs and expenses associated with a farming record from the Farming API.

  Future<CostAndExpense?> createCastExpense(
    CostAndExpense costAndExpense, {
    required TransitoryFarming farming,
  });/// Creates a new cost and expense record associated with a farming record in the Farming API.

  Future<CostAndExpense?> deleteCostAndExpense(String costAndExpenseId,
      {required TransitoryFarming farming});/// Deletes a cost and expense record associated with a farming record from the Farming API.

  Future<CropTypes?> createCropType(CropTypes cropTypes);/// Creates a new crop type in the Farming API.

  Future<CropTypes?> deleteCropType(CropTypes cropTypes);/// Deletes a crop type from the Farming API.
}

/// Implementation of the `FarmingRepository` interface.
class FarmingRepositoryAdapter extends FarmingRepository {
  final FarmingApi _api = locator<FarmingApi>();

  @override
  Future<List<CropTypes>> getCropTypes() {
    return _api.getCropTypes();
  }

  @override
  Future<List<String>> getSown() {
    return _api.getSown();
  }

  @override
  Future<TransitoryFarming> createTransitoryFarming(
      TransitoryFarming transitoryFarming) {
    return _api.createTransitoryFarming(transitoryFarming);
  }

  @override
  Future<List<TransitoryFarming>> getFarmingHistoryByUid(String? uid) {
    return _api.getFarmingHistoryByUid(uid);
  }

  @override
  Future<void> deleteTransitoryFarming(String id) {
    return _api.deleteTransitoryFarming(id);
  }

  @override
  Future<List<TransitoryFarming>> getAllFarmingHistoryByAdmin() {
    return _api.getAllFarmingHistoryByAdmin();
  }

  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByFarming(String farmingId) {
    return _api.getCostsAndExpensesByFarming(farmingId);
  }

  @override
  Future<TransitoryFarming> getTransitoryFarmingById(String farmingId) {
    return _api.getTransitoryFarmingById(farmingId);
  }

  @override
  Future<CostAndExpense?> createCastExpense(
    CostAndExpense costAndExpense, {
    required TransitoryFarming farming,
  }) {
    return _api.createCastExpense(costAndExpense, farming: farming);
  }

  @override
  Future<CostAndExpense?> deleteCostAndExpense(String costAndExpenseId, {required TransitoryFarming farming}) {
    return _api.deleteCostAndExpense(costAndExpenseId, farming: farming);
  }

  @override
  Future<CropTypes?> createCropType(CropTypes cropTypes) {
    return _api.createCropType(cropTypes);
  }

  @override
  Future<CropTypes?> deleteCropType(CropTypes cropTypes) {
    return _api.deleteCropType(cropTypes);
  }
}
