import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
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
  Future<List<TransitoryFarming>> getAllFarmingHistoryByAdmin() async {
    try {
      final collection = await _firebaseDb
          .collection(FirebaseCollections.farming)
          .get();
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
          .collection(FirebaseCollections.farming).doc(id).delete();
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
