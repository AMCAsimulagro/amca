/// {@category Features Poultry Fattening}
/// ViewModel for adding tracking entries.
library;

import 'package:amca/data/repository/livestock/poultry_fattening_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_batch.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_tracking.dart';
import 'package:flutter/foundation.dart';

class AddPoultryTrackingVM extends ChangeNotifier {
  AddPoultryTrackingVM(this.batchId);

  final String batchId;
  final PoultryFatteningRepository _repository =
      locator<PoultryFatteningRepository>();

  PoultryFatteningBatch? batch;
  bool isLoading = true;

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
    try {
      batch = await _repository.getBatchById(batchId);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<PoultryFatteningTracking?> addTracking(
    PoultryFatteningTracking tracking,
  ) async {
    if (batch == null) return null;
    return _repository.createTracking(tracking, batch: batch!);
  }
}
