/// {@category Features Poultry Laying}
/// ViewModel for laying galpon list.
library;

import 'package:amca/data/repository/livestock/poultry_laying_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/poultry_laying/laying_galpon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class LayingGalponListVM extends ChangeNotifier {
  final PoultryLayingRepository _repository =
      locator<PoultryLayingRepository>();

  bool isLoading = false;
  String? error;
  final List<LayingGalpon> _galpons = [];

  List<LayingGalpon> get galpons => List.unmodifiable(_galpons);

  Future<void> init() async {
    isLoading = true;
    error = null;
    notifyListeners();

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      error = 'Usuario no autenticado';
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      final fetched = await _repository.listGalponsByUser(userId);
      _galpons
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveGalpon(LayingGalpon galpon) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw StateError('Usuario no autenticado');
      }
      final galponForSave = galpon.copyWith(userId: userId);
      final saved = await _repository.createOrUpdateGalpon(galponForSave);
      final index = _galpons.indexWhere((element) => element.id == saved.id);
      if (index >= 0) {
        _galpons[index] = saved;
      } else {
        _galpons.insert(0, saved);
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshGalpon(String? id) async {
    if (id == null) return;
    try {
      final refreshed = await _repository.refreshGalpon(id);
      if (refreshed != null) {
        final index = _galpons.indexWhere((element) => element.id == id);
        if (index >= 0) {
          _galpons[index] = refreshed;
        }
        notifyListeners();
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
