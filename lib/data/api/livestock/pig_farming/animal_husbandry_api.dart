library;

import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/meet/meet_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_production.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

abstract class AnimalHusbandryApi {
  Future<MilkAnimalHusbandry> createAnimalHusbandry(
      MilkAnimalHusbandry animalHusbandry);

  Future<List<MilkAnimalHusbandry>> getMilkAnimalHusbandryHistoryByUid(
      String? uid);

  Future<List<MeetAnimalHusbandry>> getMeetAnimalHusbandryHistoryByUid(
      String? uid);

  Future<List<MilkAnimalHusbandry>> getAllAnimalHusbandryHistoryByAdmin();

  Future<void> deleteAnimalHusbandry(String id);

  Future<List<CostAndExpense>> getCostsAndExpensesByAnimalHusbandry(
      String farmingId);

  Future<MilkAnimalHusbandry> getMilkById(String farmingId);

  Future<MeetAnimalHusbandry> getMeetById(String farmingId);

  Future<CostAndExpense?> createPigCostExpense(
    CostAndExpense costAndExpense, {
    required MilkAnimalHusbandry farming,
  });

  Future<CostAndExpense?> deletePigCostExpense(
    String costAndExpenseId, {
    required MilkAnimalHusbandry farming,
  });

  Future<Production?> createProduction(
    Production production, {
    required MilkAnimalHusbandry farming,
  });

  Future<Production?> deleteProduction(
    String productionId, {
    required MilkAnimalHusbandry farming,
  });
}

class AnimalHusbandryApiAdapter implements AnimalHusbandryApi {
  final _firebaseDb = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<MilkAnimalHusbandry> createAnimalHusbandry(
      MilkAnimalHusbandry animalHusbandry) async {
    try {
      final animalHusbandryId = animalHusbandry.id ?? const Uuid().v4();
      final animalHusbandryToUpload = animalHusbandry.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        id: animalHusbandryId,
      );

      await _firebaseDb
          .collection(FirebaseCollections.animalHusbandry)
          .doc(animalHusbandryId)
          .set(animalHusbandryToUpload.toJson());
      return animalHusbandryToUpload;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<MilkAnimalHusbandry>> getMilkAnimalHusbandryHistoryByUid(
      String? uid) async {
    try {
      final userId = uid ?? _firebaseAuth.currentUser?.uid ?? '';
      final collection = await _firebaseDb
          .collection(FirebaseCollections.animalHusbandry)
          .where("uidOwner", isEqualTo: userId)
          .get();

      return collection.docs
          .map((doc) => MilkAnimalHusbandry.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => b.createDate.compareTo(a.createDate));
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<MilkAnimalHusbandry>>
      getAllAnimalHusbandryHistoryByAdmin() async {
    try {
      final collection = await _firebaseDb
          .collection(FirebaseCollections.animalHusbandry)
          .get();
      return collection.docs
          .map((doc) => MilkAnimalHusbandry.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => a.createDate.compareTo(b.createDate));
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<void> deleteAnimalHusbandry(String id) async {
    try {
      return await _firebaseDb
          .collection(FirebaseCollections.animalHusbandry)
          .doc(id)
          .delete();
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByAnimalHusbandry(
      String farmingId) async {
    final result = await getMilkById(farmingId);
    return result.costsAndExpenses ?? [];
  }

  @override
  Future<MilkAnimalHusbandry> getMilkById(String farmingId) async {
    try {
      final data = await _firebaseDb
          .collection(FirebaseCollections.animalHusbandry)
          .doc(farmingId)
          .get();
      return MilkAnimalHusbandry.fromJson(data.data()!);
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<CostAndExpense?> createPigCostExpense(
    CostAndExpense costAndExpense, {
    required MilkAnimalHusbandry farming,
  }) async {
    try {
      var costExpenseList = farming.costsAndExpenses ?? [];
      final costExpenseId = costAndExpense.id ?? const Uuid().v4();
      final costExpenseToUpload = costAndExpense.copyWith(
        id: costExpenseId,
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
      );

      costExpenseList.add(costExpenseToUpload);
      final updatedFarming =
          farming.copyWith(costsAndExpenses: costExpenseList);
      await createAnimalHusbandry(updatedFarming);
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
    required MilkAnimalHusbandry farming,
  }) async {
    try {
      final costExpenseList = farming.costsAndExpenses
          ?.where((element) => element.id != costAndExpenseId)
          .toList();

      final updatedFarming =
          farming.copyWith(costsAndExpenses: costExpenseList);
      await createAnimalHusbandry(updatedFarming);
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
    required MilkAnimalHusbandry farming,
  }) async {
    try {
      final productionList = farming.production ?? [];
      final productionId = production.id ?? const Uuid().v4();
      final productionToUpload = production.copyWith(
        id: productionId,
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
      );

      productionList.add(productionToUpload);
      final updatedFarming = farming.copyWith(production: productionList);
      await createAnimalHusbandry(updatedFarming);
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
    required MilkAnimalHusbandry farming,
  }) async {
    try {
      final productionList = farming.production
          ?.where((element) => element.id != productionId)
          .toList();

      final updatedFarming = farming.copyWith(production: productionList);
      await createAnimalHusbandry(updatedFarming);
      return null;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<MeetAnimalHusbandry> getMeetById(String farmingId) async {
    try {
      final data = await _firebaseDb
          .collection(FirebaseCollections.animalHusbandry)
          .doc(farmingId)
          .get();
      return MeetAnimalHusbandry.fromJson(data.data()!);
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<MeetAnimalHusbandry>> getMeetAnimalHusbandryHistoryByUid(
      String? uid) async {
    try {
      final userId = uid ?? _firebaseAuth.currentUser?.uid ?? '';
      final collection = await _firebaseDb
          .collection(FirebaseCollections.animalHusbandry)
          .where("uidOwner", isEqualTo: userId)
          .get();

      return collection.docs
          .map((doc) => MeetAnimalHusbandry.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => b.createDate.compareTo(a.createDate));
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }
}
