library;

import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_batch.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_cost_expense.dart';
import 'package:amca/domain/model/livestock/poultry_fattening/poultry_fattening_tracking.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

abstract class PoultryFatteningApi {
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

class PoultryFatteningApiAdapter implements PoultryFatteningApi {
  final _firebaseDb = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<PoultryFatteningBatch> createBatch(PoultryFatteningBatch batch) async {
    try {
      final batchId = batch.id ?? const Uuid().v4();
      final batchToUpload = batch.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        id: batchId,
      );
      await _firebaseDb
          .collection(FirebaseCollections.poultryFatteningBatches)
          .doc(batchId)
          .set(batchToUpload.toJson());
      return batchToUpload;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<PoultryFatteningBatch>> getBatchHistoryByUid(String? uid) async {
    try {
      final userId = uid ?? _firebaseAuth.currentUser?.uid ?? '';
      final collection = await _firebaseDb
          .collection(FirebaseCollections.poultryFatteningBatches)
          .where('uidOwner', isEqualTo: userId)
          .get();
      return collection.docs
          .map((doc) => PoultryFatteningBatch.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => b.creationDate.compareTo(a.creationDate));
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<PoultryFatteningBatch>> getAllBatchHistoryByAdmin() async {
    try {
      final collection = await _firebaseDb
          .collection(FirebaseCollections.poultryFatteningBatches)
          .get();
      return collection.docs
          .map((doc) => PoultryFatteningBatch.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => a.creationDate.compareTo(b.creationDate));
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<void> deleteBatch(String id) async {
    try {
      await _firebaseDb
          .collection(FirebaseCollections.poultryFatteningBatches)
          .doc(id)
          .delete();
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<PoultryFatteningBatch> getBatchById(String batchId) async {
    try {
      final data = await _firebaseDb
          .collection(FirebaseCollections.poultryFatteningBatches)
          .doc(batchId)
          .get();
      return PoultryFatteningBatch.fromJson(data.data()!);
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<PoultryFatteningTracking?> createTracking(
    PoultryFatteningTracking tracking, {
    required PoultryFatteningBatch batch,
  }) async {
    try {
      final trackingList = List<PoultryFatteningTracking>.from(batch.tracking);
      final trackingId = tracking.id ?? const Uuid().v4();
      final trackingToUpload = tracking.copyWith(id: trackingId);
      final index =
          trackingList.indexWhere((element) => element.id == trackingId);
      if (index != -1) {
        trackingList[index] = trackingToUpload;
      } else {
        trackingList.add(trackingToUpload);
      }
      final updatedBatch = batch.copyWith(tracking: trackingList);
      await createBatch(updatedBatch);
      return trackingToUpload;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<PoultryFatteningTracking?> deleteTracking(
    String trackingId, {
    required PoultryFatteningBatch batch,
  }) async {
    try {
      final trackingList = batch.tracking
          .where((element) => element.id != trackingId)
          .toList();
      final updatedBatch = batch.copyWith(tracking: trackingList);
      await createBatch(updatedBatch);
      return null;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<PoultryFatteningCostExpense?> createCostExpense(
    PoultryFatteningCostExpense costExpense, {
    required PoultryFatteningBatch batch,
  }) async {
    try {
      final costList =
          List<PoultryFatteningCostExpense>.from(batch.costsAndExpenses);
      final costExpenseId = costExpense.id ?? const Uuid().v4();
      final costExpenseToUpload = costExpense.copyWith(id: costExpenseId);
      final index =
          costList.indexWhere((element) => element.id == costExpenseId);
      if (index != -1) {
        costList[index] = costExpenseToUpload;
      } else {
        costList.add(costExpenseToUpload);
      }
      final updatedBatch = batch.copyWith(costsAndExpenses: costList);
      await createBatch(updatedBatch);
      return costExpenseToUpload;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<PoultryFatteningCostExpense?> deleteCostExpense(
    String costExpenseId, {
    required PoultryFatteningBatch batch,
  }) async {
    try {
      final costList = batch.costsAndExpenses
          .where((element) => element.id != costExpenseId)
          .toList();
      final updatedBatch = batch.copyWith(costsAndExpenses: costList);
      await createBatch(updatedBatch);
      return null;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }
}
