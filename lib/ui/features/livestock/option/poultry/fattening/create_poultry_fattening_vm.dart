/// {@category Features Poultry Fattening}
/// ViewModel for creating/updating poultry fattening batches.
library;

import 'package:amca/data/repository/livestock/poultry_fattening_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_batch.dart';
import 'package:flutter/foundation.dart';

class CreatePoultryFatteningVM extends ChangeNotifier {
  final PoultryFatteningRepository _repository =
      locator<PoultryFatteningRepository>();

  PoultryFatteningBatch? currentBatch;

  bool get isEditMode => currentBatch != null;

  void init({PoultryFatteningBatch? batch}) {
    currentBatch = batch;
  }

  Future<PoultryFatteningBatch> saveBatch(PoultryFatteningBatch batch) async {
    final result = await _repository.createBatch(batch);
    currentBatch = result;
    notifyListeners();
    return result;
  }

  Future<void> deleteBatch(String batchId) async {
    await _repository.deleteBatch(batchId);
  }
}
