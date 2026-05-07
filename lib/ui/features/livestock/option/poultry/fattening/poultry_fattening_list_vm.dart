/// {@category Features Poultry Fattening}
/// ViewModel for poultry fattening batch list.
library;

import 'package:amca/data/repository/livestock/poultry_fattening_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_batch.dart';
import 'package:flutter/foundation.dart';

class PoultryFatteningListVM extends ChangeNotifier {
  final PoultryFatteningRepository _repository =
      locator<PoultryFatteningRepository>();

  bool isLoading = true;
  List<PoultryFatteningBatch> batches = [];

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
    try {
      batches = await _repository.getBatchHistoryByUid(null);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBatch(String batchId) async {
    await _repository.deleteBatch(batchId);
    batches.removeWhere((element) => element.id == batchId);
    notifyListeners();
  }
}
