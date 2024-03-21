/// {@category Menu farming info}
import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:flutter/cupertino.dart';

class AllFarmingInfoVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();
  List<CropTypes> farmingInfo = [];
  bool isLoading = true;

  Future<void> init() async {
    isLoading = true;
    try {
      farmingInfo = await farmingRepository.getCropTypes();
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
