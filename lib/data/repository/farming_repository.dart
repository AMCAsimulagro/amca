import 'package:amca/data/api/farming_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/transitory_farming.dart';

abstract class FarmingRepository {
  Future<List<CropTypes>> getCropTypes();

  Future<List<String>> getSown();

  Future<TransitoryFarming> createTransitoryFarming(TransitoryFarming transitoryFarming);

  Future<List<TransitoryFarming>> getFarmingHistoryByUid(String? uid);
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
}
