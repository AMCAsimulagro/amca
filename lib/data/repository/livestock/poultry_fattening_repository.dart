/// {@category Repository}
/// Repository for poultry fattening batches.
library;

import 'package:amca/data/api/livestock/poultry_fattening/poultry_fattening_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_batch.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_cost_expense.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_tracking.dart';

abstract class PoultryFatteningRepository {
  Future<PoultryFatteningBatch> createBatch(PoultryFatteningBatch batch);
  Future<List<PoultryFatteningBatch>> getBatchHistoryByUid(String? uid);
  Future<List<PoultryFatteningBatch>> getAllBatchHistoryByAdmin();
  Future<void> deleteBatch(String id);
  Future<PoultryFatteningBatch> getBatchById(String batchId);
  Future<PoultryFatteningTracking?> createTracking(
    PoultryFatteningTracking tracking, {
    required PoultryFatteningBatch batch,
  });
  Future<PoultryFatteningTracking?> deleteTracking(
    String trackingId, {
    required PoultryFatteningBatch batch,
  });
  Future<PoultryFatteningCostExpense?> createCostExpense(
    PoultryFatteningCostExpense costExpense, {
    required PoultryFatteningBatch batch,
  });
  Future<PoultryFatteningCostExpense?> deleteCostExpense(
    String costExpenseId, {
    required PoultryFatteningBatch batch,
  });
}

class PoultryFatteningRepositoryAdapter implements PoultryFatteningRepository {
  final PoultryFatteningApi _api = locator<PoultryFatteningApi>();

  @override
  Future<PoultryFatteningBatch> createBatch(PoultryFatteningBatch batch) {
    return _api.createBatch(batch);
  }

  @override
  Future<List<PoultryFatteningBatch>> getBatchHistoryByUid(String? uid) {
    return _api.getBatchHistoryByUid(uid);
  }

  @override
  Future<List<PoultryFatteningBatch>> getAllBatchHistoryByAdmin() {
    return _api.getAllBatchHistoryByAdmin();
  }

  @override
  Future<void> deleteBatch(String id) {
    return _api.deleteBatch(id);
  }

  @override
  Future<PoultryFatteningBatch> getBatchById(String batchId) {
    return _api.getBatchById(batchId);
  }

  @override
  Future<PoultryFatteningTracking?> createTracking(
    PoultryFatteningTracking tracking, {
    required PoultryFatteningBatch batch,
  }) {
    return _api.createTracking(tracking, batch: batch);
  }

  @override
  Future<PoultryFatteningTracking?> deleteTracking(
    String trackingId, {
    required PoultryFatteningBatch batch,
  }) {
    return _api.deleteTracking(trackingId, batch: batch);
  }

  @override
  Future<PoultryFatteningCostExpense?> createCostExpense(
    PoultryFatteningCostExpense costExpense, {
    required PoultryFatteningBatch batch,
  }) {
    return _api.createCostExpense(costExpense, batch: batch);
  }

  @override
  Future<PoultryFatteningCostExpense?> deleteCostExpense(
    String costExpenseId, {
    required PoultryFatteningBatch batch,
  }) {
    return _api.deleteCostExpense(costExpenseId, batch: batch);
  }
}
