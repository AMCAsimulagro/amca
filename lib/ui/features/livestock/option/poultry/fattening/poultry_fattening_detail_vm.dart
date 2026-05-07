/// {@category Features Poultry Fattening}
/// ViewModel for poultry fattening batch detail.
library;

import 'package:amca/data/repository/livestock/poultry_fattening_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_batch.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_tracking.dart';
import 'package:flutter/foundation.dart';

class PoultryFatteningDetailVM extends ChangeNotifier {
  PoultryFatteningDetailVM(this.batchId);

  final String batchId;
  final PoultryFatteningRepository _repository =
      locator<PoultryFatteningRepository>();

  bool isLoading = true;
  PoultryFatteningBatch? batch;

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

  Future<PoultryFatteningTracking?> saveTracking(
    PoultryFatteningTracking tracking,
  ) async {
    if (batch == null) return null;
    final result =
        await _repository.createTracking(tracking, batch: batch!);
    if (result != null) {
      batch = await _repository.getBatchById(batchId);
      notifyListeners();
    }
    return result;
  }

  Future<void> deleteTracking(String trackingId) async {
    if (batch == null) return;
    await _repository.deleteTracking(trackingId, batch: batch!);
    batch = await _repository.getBatchById(batchId);
    notifyListeners();
  }
}
