/// Utilities to build city-level production metrics from Firestore data.
///
/// This module implements a pragmatic, client-side aggregation strategy:
/// 1) Find all user UIDs that belong to a given department+city (from `users` collection).
/// 2) Query the farming / livestock collections using `where('uidOwner', 'in', <uidsChunk>)`.
/// 3) Aggregate numeric fields (parsing strings where necessary).
///
/// Notes:
/// - Firestore `whereIn` accepts max 10 elements, so the implementation chunks UID lists.
/// - This is fine for small / medium datasets but is inefficient at scale. For production
///   we recommend denormalizing owner city/state into farming documents or maintaining
///   pre-aggregated metrics in a separate collection updated by Cloud Functions.
library;

import 'dart:math';

import 'package:amca/data/api/firebase_collections.dart';
import 'package:amca/data/api/users_api.dart';
import 'package:amca/domain/model/amca_user.dart';
import 'package:amca/domain/model/app_exception.dart';
import 'package:amca/ui/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductionCityApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final UsersApi _usersApi = UsersApiAdapter();

  static const int _firestoreInLimit = 10;

  /// Return all user uids that have state==department and town==city.
  Future<List<String>> getUserUidsByCity(String department, String city) async {
    try {
    final List<AmcaUser> users = await _usersApi.getAllUsers();
    final uids = users
      .where((u) => u.state.trim() == department.trim() && u.town.trim() == city.trim())
      .map((u) => u.uid ?? '')
      .where((uid) => uid.isNotEmpty)
      .toList();
      return uids;
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  List<List<T>> _chunkList<T>(List<T> list, int chunkSize) {
    if (chunkSize <= 0) return [list];
    final chunks = <List<T>>[];
    for (var i = 0; i < list.length; i += chunkSize) {
      chunks.add(list.sublist(i, min(i + chunkSize, list.length)));
    }
    return chunks;
  }

  double _parseDoubleSafe(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    try {
      final s = value.toString().replaceAll(',', '').trim();
      return double.tryParse(s) ?? 0.0;
    } catch (_) {
      return 0.0;
    }
  }

  int _parseIntSafe(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is num) return value.toInt();
    try {
      final s = value.toString().replaceAll(',', '').trim();
      return int.tryParse(s) ?? double.tryParse(s)?.toInt() ?? 0;
    } catch (_) {
      return 0;
    }
  }

  /// Aggregate sown area (hectares) for a given city.
  ///
  /// This implementation searches both transitory (`farming`) and permanent
  /// (`farmingPermanent`) farming collections and sums the `sownArea` field.
  /// The model stores areas as strings (m²) so this function parses them and
  /// returns the total in hectares (ha).
  Future<double> getTotalSownAreaHectaresByCity(String department, String city) async {
    try {
      final uids = await getUserUidsByCity(department, city);
      if (uids.isEmpty) return 0.0;

      double totalM2 = 0.0;

      final collectionsToQuery = [FirebaseCollections.farming, FirebaseCollections.farmingPermanent];

      for (final collectionName in collectionsToQuery) {
        final chunks = _chunkList<String>(uids, _firestoreInLimit);
        for (final chunk in chunks) {
          final querySnapshot = await _db
              .collection(collectionName)
              .where('uidOwner', whereIn: chunk)
              .get();
          for (final doc in querySnapshot.docs) {
            final data = doc.data();
            // field name is sownArea in farming models
            final sownArea = data['sownArea'];
            totalM2 += _parseDoubleSafe(sownArea);
          }
        }
      }

      // convert m² to hectares
      final totalHa = totalM2 / 10000.0;
      return totalHa;
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  /// Devuelve un mapa { cropName: areaHa } para el departamento/ciudad.
  /// Recorre las colecciones de cultivos transitorios y permanentes y suma
  /// el campo `sownArea` por cultivo (`crop`).
  Future<Map<String, double>> getSownAreaByCropByCity(String department, String city) async {
    try {
      final uids = await getUserUidsByCity(department, city);
      if (uids.isEmpty) return {};

      final Map<String, double> areaByCropM2 = {};
      final collectionsToQuery = [FirebaseCollections.farming, FirebaseCollections.farmingPermanent];

      for (final collectionName in collectionsToQuery) {
        final chunks = _chunkList<String>(uids, _firestoreInLimit);
        for (final chunk in chunks) {
          final querySnapshot = await _db
              .collection(collectionName)
              .where('uidOwner', whereIn: chunk)
              .get();
          for (final doc in querySnapshot.docs) {
            final data = doc.data();
            final cropRaw = (data['crop'] ?? data['cropType'] ?? 'Sin especificar').toString().trim();
            final crop = cropRaw.isEmpty ? 'Sin especificar' : cropRaw;
            final sownArea = _parseDoubleSafe(data['sownArea'] ?? data['sown_area'] ?? data['area'] ?? 0);
            areaByCropM2[crop] = (areaByCropM2[crop] ?? 0.0) + sownArea;
          }
        }
      }

      // convertir m² -> hectáreas y devolver
      final Map<String, double> areaByCropHa = {};
      areaByCropM2.forEach((crop, m2) {
        areaByCropHa[crop] = m2 / 10000.0;
      });
      return areaByCropHa;
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  /// Generic aggregator for livestock collections that produce `numberAnimals` and optional `area`.
  ///
  /// Returns a map: { 'numberAnimals': int, 'areaHectares': double }
  Future<Map<String, dynamic>> _aggregateLivestockCollectionByCity(
      String collectionName, String department, String city) async {
    try {
      final uids = await getUserUidsByCity(department, city);
      if (uids.isEmpty) return {'numberAnimals': 0, 'areaHectares': 0.0};

      int totalAnimals = 0;
      double totalAreaM2 = 0.0;

      final chunks = _chunkList<String>(uids, _firestoreInLimit);
      for (final chunk in chunks) {
        final querySnapshot = await _db
            .collection(collectionName)
            .where('uidOwner', whereIn: chunk)
            .get();
        for (final doc in querySnapshot.docs) {
          final data = doc.data();
          totalAnimals += _parseIntSafe(data['numberAnimals']);
          // some livestock documents may store area in different fields; common field is 'area'
          totalAreaM2 += _parseDoubleSafe(data['area']);
        }
      }

      return {'numberAnimals': totalAnimals, 'areaHectares': totalAreaM2 / 10000.0};
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  /// Pig (porcicultura) metrics by city.
  Future<Map<String, dynamic>> getPigMetricsByCity(String department, String city) async {
    return _aggregateLivestockCollectionByCity(FirebaseCollections.pigFarming, department, city);
  }

  /// Milk (lechera) metrics by city.
  Future<Map<String, dynamic>> getMilkMetricsByCity(String department, String city) async {
    return _aggregateLivestockCollectionByCity(FirebaseCollections.milkAnimalHusbandry, department, city);
  }

  /// Meat (cárnicos) metrics by city.
  Future<Map<String, dynamic>> getMeatMetricsByCity(String department, String city) async {
    return _aggregateLivestockCollectionByCity(FirebaseCollections.meatAnimalHusbandry, department, city);
  }

  /// Fish (piscicultura) metrics by city.
  Future<Map<String, dynamic>> getFishMetricsByCity(String department, String city) async {
    return _aggregateFishCollectionByCity(FirebaseCollections.fishFarming, department, city);
  }

  /// Aggregator específico para piscicultura.
  /// Intenta sumar:
  /// - campos de área (campo 'area' interpretado como m² -> se convierte a ha)
  /// - campos de volumen/producción en m³ (busca waterVolume, volume, productionVolume, pondVolume, totalProduction)
  /// Devuelve: { 'numberAnimals': int, 'areaHectares': double, 'volumeCubicMeters': double }
  Future<Map<String, dynamic>> _aggregateFishCollectionByCity(
      String collectionName, String department, String city) async {
    try {
      final uids = await getUserUidsByCity(department, city);
      if (uids.isEmpty) return {'numberAnimals': 0, 'areaHectares': 0.0, 'volumeCubicMeters': 0.0};

      int totalUnits = 0;
      double totalAreaM2 = 0.0;
      double totalVolumeM3 = 0.0;

      final chunks = _chunkList<String>(uids, _firestoreInLimit);
      for (final chunk in chunks) {
        final querySnapshot = await _db
            .collection(collectionName)
            .where('uidOwner', whereIn: chunk)
            .get();
        for (final doc in querySnapshot.docs) {
          final data = doc.data();
          // número de ejemplares/longitud si existe
          totalUnits += _parseIntSafe(data['numberAnimals'] ?? data['numberUnits'] ?? data['numPonds']);
          // área (m²) -> a hectáreas después
          totalAreaM2 += _parseDoubleSafe(data['area'] ?? data['areaM2']);
          // posibles campos que representan volumen en m³ o que permitan calcularlo
          totalVolumeM3 += _computeFishVolumeFromDoc(data);
        }
      }

      return {
        'numberAnimals': totalUnits,
        'areaHectares': totalAreaM2 / 10000.0,
        'volumeCubicMeters': totalVolumeM3,
      };
    } catch (e) {
      throw AppException(codeError: Constants.generalError);
    }
  }

  /// Intenta obtener/estimar el volumen (m³) de un registro de piscicultura.
  /// Prioriza campos explícitos de volumen; si no existen, intenta calcular
  /// a partir de dimensiones comunes: depth, length, width, diameter, radius o area*depth.
  double _computeFishVolumeFromDoc(Map<String, dynamic> data) {
    // 1) campos explícitos de volumen
    final explicit = _parseDoubleSafe(data['waterVolume'] ??
        data['volume'] ??
        data['productionVolume'] ??
        data['pondVolume'] ??
        data['totalProduction'] ??
        data['volumeM3']);
    if (explicit > 0) return explicit;

    // 2) intentar calcular desde dimensiones
    final depth = _parseDoubleSafe(data['depth'] ?? data['pondDepth'] ?? data['averageDepth']);
    final length = _parseDoubleSafe(data['length'] ?? data['pondLength']);
    final width = _parseDoubleSafe(data['width'] ?? data['pondWidth']);
    final area = _parseDoubleSafe(data['area'] ?? data['areaM2']);
    final diameter = _parseDoubleSafe(data['diameter'] ?? data['pondDiameter']);
    final radius = _parseDoubleSafe(data['radius'] ?? data['pondRadius']);

    double vol = 0.0;
    if (length > 0 && width > 0 && depth > 0) {
      vol = length * width * depth; // m * m * m = m3
    } else if (area > 0 && depth > 0) {
      vol = area * depth; // m2 * m = m3
    } else if (diameter > 0 && depth > 0) {
      final r = diameter / 2.0;
      vol = pi * r * r * depth; // circular pond
    } else if (radius > 0 && depth > 0) {
      vol = pi * radius * radius * depth;
    }

    return vol;
  }
}
