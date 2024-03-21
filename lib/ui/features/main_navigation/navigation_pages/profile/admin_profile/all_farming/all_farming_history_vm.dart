/// {@category Menu farming info}
import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:flutter/cupertino.dart';

class AllFarmingHistoryVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();
  List<TransitoryFarming> farmingHistory = [];
  bool isLoading = true;

  Future<void> init() async {
    isLoading = true;
    try {
      farmingHistory = await farmingRepository.getAllFarmingHistoryByAdmin();
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
