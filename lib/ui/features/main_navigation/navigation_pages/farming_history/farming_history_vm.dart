/// {@category Menu Farmin}

import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:amca/domain/model/permanent_farming.dart';
import 'package:flutter/cupertino.dart';

class FarmingHistoryVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();
  List<TransitoryFarming> farmingHistory = [];
  List<PermanentFarming> farmingHistoryPermanent = [];
  bool isLoading = true;

  Future<void> init() async {
    isLoading = true;
    try {
      farmingHistory = await farmingRepository.getFarmingHistoryByUid(null);
      farmingHistoryPermanent = await farmingRepository.getPermanentFarmingHistoryByUid(null);
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
