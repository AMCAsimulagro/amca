/// {@category Api}
library;

import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/domain/model/livestock/fish_husbandry/fish_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

abstract class FishTypesApi {
  Future<List<FishType>> getFishTypes();
  Future<FishType?> createFishType(FishType fishType);
  Future<FishType?> deleteFishType(FishType fishType);
}

class FishTypesApiAdapter extends FishTypesApi {
  final _firebaseDb = FirebaseFirestore.instance;

  @override
  Future<List<FishType>> getFishTypes() async {
    try {
      final coll = await _firebaseDb.collection(FirebaseCollections.fishTypes).get();
      return coll.docs.map((d) => FishType.fromJson({...d.data(), 'id': d.id})).toList();
    } catch (e) {
      throw AppException(codeError: 'getFishTypes_error');
    }
  }

  @override
  Future<FishType?> createFishType(FishType fishType) async {
    try {
      final id = fishType.id ?? const Uuid().v4();
      final toUpload = fishType.copyWith(id: id);
      await _firebaseDb.collection(FirebaseCollections.fishTypes).doc(id).set(toUpload.toJson());
      return toUpload;
    } catch (e) {
      throw AppException(codeError: 'createFishType_error');
    }
  }

  @override
  Future<FishType?> deleteFishType(FishType fishType) async {
    try {
      await _firebaseDb.collection(FirebaseCollections.fishTypes).doc(fishType.id).delete();
      return fishType;
    } catch (e) {
      throw AppException(codeError: 'deleteFishType_error');
    }
  }
}
