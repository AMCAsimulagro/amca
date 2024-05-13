/// {@category Api}
///This file contains the implementation of an interface `FarmingApi` and its adapter `FarmingApiAdapter`
///
/// which provides methods to interact with the Firebase database in a Flutter application.
/// These methods are designed to perform operations related to agriculture,
/// how to obtain crop types, create and delete transient agriculture records, manage costs and expenses, among others.

/// Imports of Bookstores and Resources
import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/domain/model/cost_expense.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/spawn.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:amca/domain/model/permanent_farming.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

/// Abstract interface defining methods to interact with the database related to farming.
abstract class FarmingApi {
  /// Retrieves a list of crop types from the database.
  Future<List<CropTypes>> getCropTypes();

  /// Retrieves a list of Permanent crop types from the database.
  Future<List<CropTypes>> getPermanentCropTypes();

  /// Retrieves a list of spawn from the database.
  Future<List<String>> getSown();

  /// Creates a transitory farming record in the database.
  Future<TransitoryFarming> createTransitoryFarming(
      TransitoryFarming transitoryFarming);

  /// Creates a permanent farming record in the database.
  Future<PermanentFarming> createPermanentFarming(
      PermanentFarming permanentFarming);

  /// Retrieves the history of transitory farming records associated with a specific user.
  Future<List<TransitoryFarming>> getFarmingHistoryByUid(String? uid);

  /// Retrieves the history of transitory farming records associated with a specific user.
  Future<List<PermanentFarming>> getPermanentFarmingHistoryByUid(String? uid);

  /// Retrieves the complete history of transitory farming records for an admin.
  Future<List<TransitoryFarming>> getAllFarmingHistoryByAdmin();

  /// Deletes a transitory farming record from the database.
  Future<void> deleteTransitoryFarming(String id);

  /// Deletes a transitory farming record from the database.
  Future<void> deletePermanentFarming(String id);

  /// Retrieves the costs and expenses associated with a specific farming record.
  Future<List<CostAndExpense>> getCostsAndExpensesByFarming(String farmingId);

   /// Retrieves the costs and expenses associated with a specific farming record.
  Future<List<CostAndExpense>> getCostsAndExpensesByFarmingPermanent(String farmingId);

  /// Retrieves a transitory farming record by its unique identifier.
  Future<TransitoryFarming> getTransitoryFarmingById(String farmingId);

  /// Retrieves a permanent farming record by its unique identifier.
  Future<PermanentFarming> getPermanentFarmingById(String farmingId);

  /// Creates a new cost or expense associated with a farming record.
  Future<CostAndExpense?> createCastExpense(
    CostAndExpense costAndExpense, {
    required TransitoryFarming farming,
  });

  /// Creates a new cost or expense associated with a farming record.
  Future<CostAndExpense?> createCastExpensePermanent(
    CostAndExpense costAndExpense, {
    required PermanentFarming farming,
  });

  /// Deletes a cost or expense associated with a farming record.
  Future<CostAndExpense?> deleteCostAndExpense(String costAndExpenseId,
      {required TransitoryFarming farming});

  /// Deletes a cost or expense associated with a farming record.
  Future<CostAndExpense?> deleteCostAndExpensePermanent(String costAndExpenseId,
      {required PermanentFarming farming});

  /// Creates a new crop type in the database.
  Future<CropTypes?> createCropType(CropTypes cropTypes);

  /// Deletes a crop type from the database.
  Future<CropTypes?> deleteCropType(CropTypes cropTypes);
}

/// Implementation of the `FarmingApi` interface.
class FarmingApiAdapter extends FarmingApi {
  final _firebaseDb = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  /// Implementation of getCropTypes
  /// Connects to [Firebase] and gets all the values ​​and returns them
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

  /// Implementation of getPermanentCropTypes
  /// Connects to [Firebase] and gets all the values ​​and returns them
  @override
  Future<List<CropTypes>> getPermanentCropTypes() async {
    try {
      final collection = await _firebaseDb
          .collection(FirebaseCollections.permanentcroptypes)
          .get();
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

// Implementation of getSown
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

// Implementation of createTransitoryFarming
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

  // Implementation of createPermanentFarming
  @override
  Future<PermanentFarming> createPermanentFarming(
      PermanentFarming permanentFarming) async {
    try {
      final permanentId = permanentFarming.id ?? const Uuid().v4();
      final permanentFarmingToUpload = permanentFarming.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        id: permanentId,
      );

      await _firebaseDb
          .collection(FirebaseCollections.farmingPermanent)
          .doc(permanentId)
          .set(permanentFarmingToUpload.toJson());
      return permanentFarmingToUpload;
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

  // Implementation of getFarmingHistoryByUid
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

  // Implementation of getFarmingHistoryByUid
  @override
  Future<List<PermanentFarming>> getPermanentFarmingHistoryByUid(
      String? uid) async {
    try {
      final userId = uid ?? _firebaseAuth.currentUser?.uid ?? '';
      final collection = await _firebaseDb
          .collection(FirebaseCollections.farmingPermanent)
          .where("uidOwner", isEqualTo: userId)
          .get();
      final data = collection.docs
          .map((doc) => PermanentFarming.fromJson(doc.data()))
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

  // Implementation of getAllFarmingHistoryByAdmin
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

// Implementation of deleteTransitoryFarming
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

  // Implementation of deletePermanentFarming
  @override
  Future<void> deletePermanentFarming(String id) async {
    try {
      return await _firebaseDb
          .collection(FirebaseCollections.farmingPermanent)
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

// Implementation of getCostsAndExpensesByFarming
  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByFarming(
      String farmingId) async {
    final result = await getTransitoryFarmingById(farmingId);
    return result.costsAndExpenses ?? [];
  }

  // Implementation of getCostsAndExpensesByFarming
  @override
  Future<List<CostAndExpense>> getCostsAndExpensesByFarmingPermanent(
      String farmingId) async {
    final result = await getPermanentFarmingById(farmingId);
    return result.costsAndExpenses ?? [];
  }

// Implementation of getTransitoryFarmingById
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

  // Implementation of getPermanentFarmingById
  @override
  Future<PermanentFarming> getPermanentFarmingById(String farmingId) async {
    try {
      final data = await _firebaseDb
          .collection(FirebaseCollections.farmingPermanent)
          .doc(farmingId)
          .get();
      return PermanentFarming.fromJson(data.data()!);
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

// Implementation of createCastExpense
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

  // Implementation of createCastExpense
  @override
  Future<CostAndExpense?> createCastExpensePermanent(
    CostAndExpense costAndExpense, {
    required PermanentFarming farming,
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
      await createPermanentFarming(farmingToUpload);
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

// Implementation of deleteCostAndExpense
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

  // Implementation of deleteCostAndExpense
  @override
  Future<CostAndExpense?> deleteCostAndExpensePermanent(String costAndExpenseId,
      {required PermanentFarming farming}) async {
    try {
      var costAndExpenseList = farming.costsAndExpenses ?? [];
      costAndExpenseList
          .removeWhere((element) => element.id == costAndExpenseId);

      final farmingToUpload = farming.copyWith(
        uidOwner: _firebaseAuth.currentUser?.uid ?? '',
        costsAndExpenses: costAndExpenseList,
      );
      await createPermanentFarming(farmingToUpload);
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

// Implementation of createCropType
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

// Implementation of deleteCropType
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
