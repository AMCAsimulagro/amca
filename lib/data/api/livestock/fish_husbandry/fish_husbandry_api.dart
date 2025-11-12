library;

import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/fish_husbandry/fish_husbandry.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

abstract class FishHusbandryApi {
  Future<FishHusbandry> createFishHusbandry(FishHusbandry fishHusbandry);

  Future<List<FishHusbandry>> getFishHusbandryHistoryByUid(String? uid);

  Future<List<FishHusbandry>> getAllFishHistoryByAdmin();

  Future<void> deleteFishHusbandry(String id);

  Future<List<CostAndExpense>> getCostsAndExpensesByFish(String farmingId);

  Future<FishHusbandry> getFishById(String farmingId);

  Future<CostAndExpense?> createFishCostExpense(
    CostAndExpense costAndExpense, {
    required FishHusbandry farming,
  });

  Future<CostAndExpense?> deleteFishCostExpense(
    String costAndExpenseId, {
    required FishHusbandry farming,
  });
}

class FishHusbandryApiAdapter implements FishHusbandryApi {
  final _firebaseDb = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<FishHusbandry> createFishHusbandry(FishHusbandry fishHusbandry) async {
    try {
      final fishHusbandryId = fishHusbandry.id ?? const Uuid().v4();
      final fishHusbandryToUpload = fishHusbandry.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        id: fishHusbandryId,
      );

      await _firebaseDb
          .collection(FirebaseCollections.fishFarming)
          .doc(fishHusbandryId)
          .set(fishHusbandryToUpload.toJson());
      return fishHusbandryToUpload;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<FishHusbandry>> getAllFishHistoryByAdmin() async {
    try {
      final collection =
          await _firebaseDb.collection(FirebaseCollections.fishFarming).get();
      return collection.docs
          .map((doc) => FishHusbandry.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => a.createDate.compareTo(b.createDate));
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<void> deleteFishHusbandry(String id) async {
    try {
      return await _firebaseDb
          .collection(FirebaseCollections.fishFarming)
          .doc(id)
          .delete();
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByFish(
      String farmingId) async {
    final result = await getFishById(farmingId);
    return result.costsAndExpenses ?? [];
  }

  @override
  Future<CostAndExpense?> createFishCostExpense(
    CostAndExpense costAndExpense, {
    required FishHusbandry farming,
  }) async {
    try {
      var costAndExpenseList = farming.costsAndExpenses ?? [];
      costAndExpense.uidOwner = _firebaseAuth.currentUser?.uid ?? '';
      final costAndExpenseId = costAndExpense.id ?? const Uuid().v4();
      final costAndExpenseToUpload = costAndExpense.copyWith(
        id: costAndExpenseId,
      );
      int index =
          costAndExpenseList.indexWhere((obj) => obj.id == costAndExpenseId);
      if (index != -1) {
        costAndExpenseList
            .replaceRange(index, index + 1, [costAndExpenseToUpload]);
      } else {
        costAndExpenseList.add(costAndExpenseToUpload);
      }
      final farmingToUpload = farming.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        costsAndExpenses: costAndExpenseList,
      );
      await createFishHusbandry(farmingToUpload);
      return costAndExpenseToUpload;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        message: e.message,
        codeError: e.code,
      );
    } catch (e) {
      throw AppException(
        codeError: Constants.generalError,
      );
    }
  }

  @override
  Future<CostAndExpense?> deleteFishCostExpense(
    String costAndExpenseId, {
    required FishHusbandry farming,
  }) async {
    try {
      var costAndExpenseList = farming.costsAndExpenses ?? [];
      costAndExpenseList
          .removeWhere((element) => element.id == costAndExpenseId);

      final farmingToUpload = farming.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        costsAndExpenses: costAndExpenseList,
      );
      await createFishHusbandry(farmingToUpload);
      return null;
    } on FirebaseAuthException catch (e) {
      throw AppException(
        message: e.message,
        codeError: e.code,
      );
    } catch (e) {
      throw AppException(
        codeError: Constants.generalError,
      );
    }
  }

  @override
  Future<FishHusbandry> getFishById(String farmingId) async {
    try {
      final data = await _firebaseDb
          .collection(FirebaseCollections.fishFarming)
          .doc(farmingId)
          .get();
      return FishHusbandry.fromJson(data.data()!);
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<FishHusbandry>> getFishHusbandryHistoryByUid(String? uid) async {
    try {
      final userId = uid ?? _firebaseAuth.currentUser?.uid ?? '';
      final collection = await _firebaseDb
          .collection(FirebaseCollections.fishFarming)
          .where("uidOwner", isEqualTo: userId)
          .get();

      return collection.docs
          .map((doc) => FishHusbandry.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => b.createDate.compareTo(a.createDate));
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }
}
