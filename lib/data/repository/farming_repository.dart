import 'package:amca/data/api/farming_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/transitory_farming.dart';

abstract class FarmingRepository {
  Future<List<CropTypes>> getCropTypes();

  Future<List<String>> getSown();

  Future<TransitoryFarming> createTransitoryFarming(TransitoryFarming transitoryFarming);

  Future<TransitoryFarming> getTransitoryFarmingById(String farmingId);

  Future<List<TransitoryFarming>> getFarmingHistoryByUid(String? uid);

  Future<void> deleteTransitoryFarming(String id);

  Future<List<TransitoryFarming>> getAllFarmingHistoryByAdmin();

  Future<List<CostAndExpense>> getCostsAndExpensesByFarming(String farmingId);
}

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
  Future<TransitoryFarming> createTransitoryFarming(TransitoryFarming transitoryFarming) {
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
    return _api.getCostsAndExpensesByFarming();
  }

  @override
  Future<TransitoryFarming> getTransitoryFarmingById(String farmingId) {
    return _api.getTransitoryFarmingById(farmingId);
  }
}
