library;

import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/pig_farming/pig_farming.dart';
import 'package:amca/domain/model/livestock/pig_farming/production.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

abstract class PigFarmingApi {
  Future<PigFarming> createPigFarming(PigFarming pigFarming);
  Future<List<PigFarming>> getPigFarmingHistoryByUid(String? uid);
  Future<List<PigFarming>> getAllPigFarmingHistoryByAdmin();
  Future<void> deletePigFarming(String id);
  Future<List<CostAndExpense>> getCostsAndExpensesByPigFarming(String farmingId);
  Future<PigFarming> getPigFarmingById(String farmingId);
  Future<CostAndExpense?> createPigCostExpense(
    CostAndExpense costAndExpense, {
    required PigFarming farming,
  });
  Future<CostAndExpense?> deletePigCostExpense(
    String costAndExpenseId, {
    required PigFarming farming,
  });
  Future<Production?> createProduction(
    Production production, {
    required PigFarming farming,
  });
  Future<Production?> deleteProduction(
    String productionId, {
    required PigFarming farming,
  });
}

class PigFarmingApiAdapter implements PigFarmingApi {
  final _firebaseDb = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<PigFarming> createPigFarming(PigFarming pigFarming) async {
    try {
      final pigFarmingId = pigFarming.id ?? const Uuid().v4();
      final pigFarmingToUpload = pigFarming.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        id: pigFarmingId,
      );

      await _firebaseDb
          .collection(FirebaseCollections.pigFarming)
          .doc(pigFarmingId)
          .set(pigFarmingToUpload.toJson());
      return pigFarmingToUpload;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<PigFarming>> getPigFarmingHistoryByUid(String? uid) async {
    try {
      final userId = uid ?? _firebaseAuth.currentUser?.uid ?? '';
      final collection = await _firebaseDb
          .collection(FirebaseCollections.pigFarming)
          .where("uidOwner", isEqualTo: userId)
          .get();
      
      return collection.docs
          .map((doc) => PigFarming.fromJson(doc.data()))
          .toList()
          ..sort((a, b) => b.createDate.compareTo(a.createDate));
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<PigFarming>> getAllPigFarmingHistoryByAdmin() async {
    try {
      final collection = await _firebaseDb.collection(FirebaseCollections.pigFarming).get();
      return collection.docs
          .map((doc) => PigFarming.fromJson(doc.data()))
          .toList()
          ..sort((a, b) => a.createDate.compareTo(b.createDate));
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<void> deletePigFarming(String id) async {
    try {
      return await _firebaseDb
          .collection(FirebaseCollections.pigFarming)
          .doc(id)
          .delete();
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByPigFarming(String farmingId) async {
    final result = await getPigFarmingById(farmingId);
    return result.costsAndExpenses ?? [];
  }

  @override
  Future<PigFarming> getPigFarmingById(String farmingId) async {
    try {
      final data = await _firebaseDb
          .collection(FirebaseCollections.pigFarming)
          .doc(farmingId)
          .get();
      return PigFarming.fromJson(data.data()!);
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<CostAndExpense?> createPigCostExpense(
    CostAndExpense costAndExpense, {
    required PigFarming farming,
  }) async {
    try {
      var costExpenseList = farming.costsAndExpenses ?? [];
      final costExpenseId = costAndExpense.id ?? const Uuid().v4();
      final costExpenseToUpload = costAndExpense.copyWith(
        id: costExpenseId,
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
      );
      int index = costExpenseList.indexWhere((element) => element.id == costExpenseId);
      if (index != -1) {
        costExpenseList[index] = costExpenseToUpload;
      } else {
        costExpenseList.add(costExpenseToUpload);
      }
      final updatedFarming = farming.copyWith(costsAndExpenses: costExpenseList);
      await createPigFarming(updatedFarming);
      return costExpenseToUpload;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<CostAndExpense?> deletePigCostExpense(
    String costAndExpenseId, {
    required PigFarming farming,
  }) async {
    try {
      final costExpenseList = farming.costsAndExpenses
          ?.where((element) => element.id != costAndExpenseId)
          .toList();

      final updatedFarming = farming.copyWith(costsAndExpenses: costExpenseList);
      await createPigFarming(updatedFarming);
      return null;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<Production?> createProduction(
    Production production, {
    required PigFarming farming,
  }) async {
    try {
      final productionId = production.id ?? const Uuid().v4();
      final productionToUpload = production.copyWith(
        id: productionId,
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
      );
      final updatedFarming = farming.copyWith(production: production);
      await createPigFarming(updatedFarming);
      return productionToUpload;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<Production?> deleteProduction(
    String productionId, {
    required PigFarming farming,
  }) async {
    try {
      // TODO: Revisar si es lista o un solo objeto
      // final productionList = farming.production
      //     ?.where((element) => element.id != productionId)
      //     .toList();

      final updatedFarming = farming.copyWith(production: farming.production);
      await createPigFarming(updatedFarming);
      return null;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }
}