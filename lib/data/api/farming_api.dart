import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/spawn.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

abstract class FarmingApi {
  Future<List<CropTypes>> getCropTypes();

  Future<List<String>> getSown();

  Future<TransitoryFarming> createTransitoryFarming(
      TransitoryFarming transitoryFarming);

  Future<List<TransitoryFarming>> getFarmingHistoryByUid(String? uid);

  Future<List<TransitoryFarming>> getAllFarmingHistoryByAdmin();

  Future<void> deleteTransitoryFarming(String id);

  Future<List<CostAndExpense>> getCostsAndExpensesByFarming(String farmingId);

  Future<TransitoryFarming> getTransitoryFarmingById(String farmingId);

  Future<CostAndExpense?> createCastExpense(
    CostAndExpense costAndExpense, {
    required TransitoryFarming farming,
  });

  Future<CostAndExpense?> deleteCostAndExpense(String costAndExpenseId,
      {required TransitoryFarming farming});

  Future<CropTypes?> createCropType(CropTypes cropTypes);

  Future<CropTypes?> deleteCropType(CropTypes cropTypes);
}

class FarmingApiAdapter extends FarmingApi {
  final _firebaseDb = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<List<CropTypes>> getCropTypes() async {
    try {
      final collection =
          await _firebaseDb.collection(FirebaseCollections.farmingInfo).get();
      final data =
          collection.docs.map((doc) => CropTypes.fromJson(doc.data())).toList();

      return data;
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
  Future<List<String>> getSown() async {
    try {
      final collection = await _firebaseDb
          .collection(FirebaseCollections.sembrados)
          .doc(FirebaseCollections.tiposDeSembrado)
          .get();
      final data = Spawn.fromJson(collection.data()!);

      return data.tipo;
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
  Future<TransitoryFarming> createTransitoryFarming(
      TransitoryFarming transitoryFarming) async {
    try {
      final transitoryId = transitoryFarming.id ?? const Uuid().v4();
      final transitoryFarmingToUpload = transitoryFarming.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        id: transitoryId,
      );

      await _firebaseDb
          .collection(FirebaseCollections.farming)
          .doc(transitoryId)
          .set(transitoryFarmingToUpload.toJson());
      return transitoryFarmingToUpload;
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
  Future<List<TransitoryFarming>> getFarmingHistoryByUid(String? uid) async {
    try {
      final userId = uid ?? _firebaseAuth.currentUser?.uid ?? '';
      final collection = await _firebaseDb
          .collection(FirebaseCollections.farming)
          .where("uidOwner", isEqualTo: userId)
          .get();
      final data = collection.docs
          .map((doc) => TransitoryFarming.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => b.createDate.compareTo(a.createDate));
      return data;
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
  Future<List<TransitoryFarming>> getAllFarmingHistoryByAdmin() async {
    try {
      final collection =
          await _firebaseDb.collection(FirebaseCollections.farming).get();
      final data = collection.docs
          .map((doc) => TransitoryFarming.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => a.createDate.compareTo(b.createDate));
      return data;
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
  Future<void> deleteTransitoryFarming(String id) async {
    try {
      return await _firebaseDb
          .collection(FirebaseCollections.farming)
          .doc(id)
          .delete();
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
  Future<List<CostAndExpense>> getCostsAndExpensesByFarming(
      String farmingId) async {
    final result = await getTransitoryFarmingById(farmingId);
    return result.costsAndExpenses ?? [];
  }

  @override
  Future<TransitoryFarming> getTransitoryFarmingById(String farmingId) async {
    try {
      final data = await _firebaseDb
          .collection(FirebaseCollections.farming)
          .doc(farmingId)
          .get();
      return TransitoryFarming.fromJson(data.data()!);
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
  Future<CostAndExpense?> createCastExpense(
    CostAndExpense costAndExpense, {
    required TransitoryFarming farming,
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
      await createTransitoryFarming(farmingToUpload);
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
  Future<CostAndExpense?> deleteCostAndExpense(String costAndExpenseId,
      {required TransitoryFarming farming}) async {
    try {
      var costAndExpenseList = farming.costsAndExpenses ?? [];
      costAndExpenseList
          .removeWhere((element) => element.id == costAndExpenseId);

      final farmingToUpload = farming.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        costsAndExpenses: costAndExpenseList,
      );
      await createTransitoryFarming(farmingToUpload);
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
  Future<CropTypes?> createCropType(CropTypes cropTypes) async {
    try {
      final cropId = cropTypes.id ?? const Uuid().v4();
      final cropTypeToUpload = cropTypes.copyWith(
        id: cropId,
      );
      await _firebaseDb
          .collection(FirebaseCollections.farmingInfo)
          .doc(cropId)
          .set(cropTypeToUpload.toJson());
      return cropTypeToUpload;
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
  Future<CropTypes?> deleteCropType(CropTypes cropTypes) async {
    try {
      await _firebaseDb
          .collection(FirebaseCollections.farmingInfo)
          .doc(cropTypes.id)
          .delete();
      return cropTypes;
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
}
