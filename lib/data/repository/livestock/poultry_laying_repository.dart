/// {@category Repository}
/// Repository for poultry laying galpones and daily records.
library;

import 'package:amca/domain/model/livestock/poultry_laying/laying_daily_record.dart';
import 'package:amca/domain/model/livestock/poultry_laying/laying_galpon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PoultryLayingRepository {
  Future<LayingGalpon> createOrUpdateGalpon(LayingGalpon galpon);
  Future<List<LayingGalpon>> listGalponsByUser(String userId);
  Future<LayingGalpon?> getGalponById(String galponId);
  Future<LayingDailyRecord> createOrUpdateDailyRecord(LayingDailyRecord record);
  Future<List<LayingDailyRecord>> listDailyRecords(String galponId);
  Future<void> finalizeGalpon(LayingGalpon galpon);
  Future<void> reactivateGalpon(String galponId);
  Future<LayingGalpon?> refreshGalpon(String galponId);
}

class PoultryLayingRepositoryAdapter implements PoultryLayingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _galpons => _firestore.collection('laying_galpons');
  CollectionReference get _closures => _firestore.collection('laying_closure_documents');

  @override
  Future<LayingGalpon> createOrUpdateGalpon(LayingGalpon galpon) async {
    final docRef = galpon.id != null ? _galpons.doc(galpon.id) : _galpons.doc();
    final data = galpon.toMap();
    data['updatedAt'] = FieldValue.serverTimestamp();
    if (galpon.id == null) {
      data['createdAt'] = FieldValue.serverTimestamp();
    }
    await docRef.set(data, SetOptions(merge: true));
    final snapshot = await docRef.get();
    return LayingGalpon.fromMap(snapshot.data() as Map<String, dynamic>, docRef.id);
  }

  @override
  Future<LayingGalpon?> getGalponById(String galponId) async {
    final snapshot = await _galpons.doc(galponId).get();
    if (!snapshot.exists) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return LayingGalpon.fromMap(data as Map<String, dynamic>, snapshot.id);
  }

  @override
  Future<List<LayingGalpon>> listGalponsByUser(String userId) async {
    final query = await _galpons.where('userId', isEqualTo: userId).get();
    return query.docs
        .map((doc) => LayingGalpon.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  @override
  Future<LayingDailyRecord> createOrUpdateDailyRecord(LayingDailyRecord record) async {
    final docRef = record.id != null
        ? _galpons.doc(record.galponId).collection('laying_daily_records').doc(record.id)
        : _galpons.doc(record.galponId).collection('laying_daily_records').doc();
    final data = record.toMap();
    data['updatedAt'] = FieldValue.serverTimestamp();
    if (record.id == null) {
      data['createdAt'] = FieldValue.serverTimestamp();
    }
    await docRef.set(data, SetOptions(merge: true));
    final snapshot = await docRef.get();
    return LayingDailyRecord.fromMap(snapshot.data() as Map<String, dynamic>, docRef.id);
  }

  @override
  Future<List<LayingDailyRecord>> listDailyRecords(String galponId) async {
    final query = await _galpons
        .doc(galponId)
        .collection('laying_daily_records')
        .orderBy('date', descending: true)
        .get();
    return query.docs
        .map((doc) => LayingDailyRecord.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  @override
  Future<void> finalizeGalpon(LayingGalpon galpon) async {
    final records = await listDailyRecords(galpon.id ?? '');
    final totalProduction = records.fold<int>(0, (sum, record) => sum + record.totalProduction);
    final totalFoodConsumed = records.fold<double>(0, (sum, record) => sum + record.foodConsumedKg);
    final totalBrokenEggs = records.fold<int>(0, (sum, record) => sum + record.brokenEggs);
    final totalDirtyEggs = records.fold<int>(0, (sum, record) => sum + record.dirtyEggs);
    final totalMortality = records.fold<int>(0, (sum, record) => sum + record.mortality);
    final closureRef = _closures.doc();
    await closureRef.set({
      'galponId': galpon.id,
      'closingDate': FieldValue.serverTimestamp(),
      'totalProduction': totalProduction,
      'totalFoodConsumedKg': totalFoodConsumed,
      'totalBrokenEggs': totalBrokenEggs,
      'totalDirtyEggs': totalDirtyEggs,
      'totalMortality': totalMortality,
      'generatedAt': FieldValue.serverTimestamp(),
    });
    await _galpons.doc(galpon.id).set({
      'state': 'finalizado',
      'closingDocumentId': closureRef.id,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Future<void> reactivateGalpon(String galponId) async {
    final doc = await _galpons.doc(galponId).get();
    final data = doc.data() as Map<String, dynamic>?;
    final closureId = data?['closingDocumentId'] as String?;
    if (closureId != null) {
      await _closures.doc(closureId).delete();
    }
    await _galpons.doc(galponId).set({
      'state': 'activo',
      'closingDocumentId': FieldValue.delete(),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  @override
  Future<LayingGalpon?> refreshGalpon(String galponId) async {
    final doc = await _galpons.doc(galponId).get();
    if (!doc.exists) return null;
    return LayingGalpon.fromMap(doc.data() as Map<String, dynamic>, doc.id);
  }
}
