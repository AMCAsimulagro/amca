library;

import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/meat/meat_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_production.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

abstract class AnimalHusbandryApi {
  Future<MilkAnimalHusbandry> createMilkAnimalHusbandry(
      MilkAnimalHusbandry animalHusbandry);

  Future<MeatAnimalHusbandry> createMeatAnimalHusbandry(
      MeatAnimalHusbandry animalHusbandry);

  Future<List<MilkAnimalHusbandry>> getMilkAnimalHusbandryHistoryByUid(
      String? uid);

  Future<List<MeatAnimalHusbandry>> getMeatAnimalHusbandryHistoryByUid(
      String? uid);

  Future<List<MilkAnimalHusbandry>> getAllMilkHistoryByAdmin();

  Future<List<MeatAnimalHusbandry>> getAllMeatHistoryByAdmin();

  Future<void> deleteAnimalHusbandry(String id);

  Future<List<CostAndExpense>> getCostsAndExpensesByMilk(String farmingId);

  Future<List<CostAndExpense>> getCostsAndExpensesByMeat(String farmingId);

  Future<MilkAnimalHusbandry> getMilkById(String farmingId);

  Future<MeatAnimalHusbandry> getMeatById(String farmingId);

  Future<CostAndExpense?> createMilkCostExpense(
    CostAndExpense costAndExpense, {
    required MilkAnimalHusbandry farming,
  });

  Future<CostAndExpense?> deleteMilkCostExpense(
    String costAndExpenseId, {
    required MilkAnimalHusbandry farming,
  });

  Future<CostAndExpense?> createMeatCostExpense(
    CostAndExpense costAndExpense, {
    required MeatAnimalHusbandry farming,
  });

  Future<CostAndExpense?> deleteMeatCostExpense(
    String costAndExpenseId, {
    required MeatAnimalHusbandry farming,
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
  Future<MilkAnimalHusbandry> createMilkAnimalHusbandry(
      MilkAnimalHusbandry animalHusbandry) async {
    try {
      final animalHusbandryId = animalHusbandry.id ?? const Uuid().v4();
      final animalHusbandryToUpload = animalHusbandry.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        id: animalHusbandryId,
      );

      await _firebaseDb
          .collection(FirebaseCollections.milkAnimalHusbandry)
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
  Future<MeatAnimalHusbandry> createMeatAnimalHusbandry(
      MeatAnimalHusbandry animalHusbandry) async {
    try {
      final animalHusbandryId = animalHusbandry.id ?? const Uuid().v4();
      final animalHusbandryToUpload = animalHusbandry.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        id: animalHusbandryId,
      );

      await _firebaseDb
          .collection(FirebaseCollections.meatAnimalHusbandry)
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
          .collection(FirebaseCollections.milkAnimalHusbandry)
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
  Future<List<MilkAnimalHusbandry>> getAllMilkHistoryByAdmin() async {
    try {
      final collection = await _firebaseDb
          .collection(FirebaseCollections.milkAnimalHusbandry)
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
  Future<List<MeatAnimalHusbandry>> getAllMeatHistoryByAdmin() async {
    try {
      final collection = await _firebaseDb
          .collection(FirebaseCollections.meatAnimalHusbandry)
          .get();
      return collection.docs
          .map((doc) => MeatAnimalHusbandry.fromJson(doc.data()))
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
          .collection(FirebaseCollections.milkAnimalHusbandry)
          .doc(id)
          .delete();
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByMilk(
      String farmingId) async {
    final result = await getMilkById(farmingId);
    return result.costsAndExpenses ?? [];
  }

  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByMeat(
      String farmingId) async {
    final result = await getMeatById(farmingId);
    return result.costsAndExpenses ?? [];
  }

  @override
  Future<MilkAnimalHusbandry> getMilkById(String farmingId) async {
    try {
      final data = await _firebaseDb
          .collection(FirebaseCollections.milkAnimalHusbandry)
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
  Future<CostAndExpense?> createMilkCostExpense(
    CostAndExpense costAndExpense, {
    required MilkAnimalHusbandry farming,
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
      await createMilkAnimalHusbandry(farmingToUpload);
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
  Future<CostAndExpense?> deleteMilkCostExpense(
    String costAndExpenseId, {
    required MilkAnimalHusbandry farming,
  }) async {
    try {
      var costAndExpenseList = farming.costsAndExpenses ?? [];
      costAndExpenseList
          .removeWhere((element) => element.id == costAndExpenseId);

      final farmingToUpload = farming.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        costsAndExpenses: costAndExpenseList,
      );
      await createMilkAnimalHusbandry(farmingToUpload);
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
  Future<CostAndExpense?> createMeatCostExpense(
    CostAndExpense costAndExpense, {
    required MeatAnimalHusbandry farming,
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
      await createMeatAnimalHusbandry(farmingToUpload);
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
  Future<CostAndExpense?> deleteMeatCostExpense(
    String costAndExpenseId, {
    required MeatAnimalHusbandry farming,
  }) async {
    try {
      var costAndExpenseList = farming.costsAndExpenses ?? [];
      costAndExpenseList
          .removeWhere((element) => element.id == costAndExpenseId);

      final farmingToUpload = farming.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        costsAndExpenses: costAndExpenseList,
      );
      await createMeatAnimalHusbandry(farmingToUpload);
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
      await createMilkAnimalHusbandry(updatedFarming);
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
      await createMilkAnimalHusbandry(updatedFarming);
      return null;
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<MeatAnimalHusbandry> getMeatById(String farmingId) async {
    try {
      final data = await _firebaseDb
          .collection(FirebaseCollections.meatAnimalHusbandry)
          .doc(farmingId)
          .get();
      return MeatAnimalHusbandry.fromJson(data.data()!);
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  @override
  Future<List<MeatAnimalHusbandry>> getMeatAnimalHusbandryHistoryByUid(
      String? uid) async {
    try {
      final userId = uid ?? _firebaseAuth.currentUser?.uid ?? '';
      final collection = await _firebaseDb
          .collection(FirebaseCollections.meatAnimalHusbandry)
          .where("uidOwner", isEqualTo: userId)
          .get();

      return collection.docs
          .map((doc) => MeatAnimalHusbandry.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => b.createDate.compareTo(a.createDate));
    } on FirebaseAuthException catch (e) {
      throw AppException(message: e.message, codeError: e.code);
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }
}
