/// {@category Features Poultry Laying}
/// ViewModel for the detail screen of a laying galpón.
library;

import 'package:amca/data/repository/livestock/poultry_laying_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/poultry_laying/laying_daily_record.dart';
import 'package:amca/domain/model/livestock/poultry_laying/laying_galpon.dart';
import 'package:flutter/foundation.dart';

class LayingGalponDetailVM extends ChangeNotifier {
  LayingGalponDetailVM(LayingGalpon galpon) {
    this.galpon = galpon;
    _loadRecords();
  }

  late LayingGalpon galpon;
  final PoultryLayingRepository _repository =
      locator<PoultryLayingRepository>();
  final List<LayingDailyRecord> _records = [];
  bool isLoading = false;
  String? error;
  LayingDailyRecord? editingRecord;

  List<LayingDailyRecord> get records => List.unmodifiable(_records);

  Future<void> _loadRecords() async {
    if (galpon.id == null) return;
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final fetched = await _repository.listDailyRecords(galpon.id!);
      _records
        ..clear()
        ..addAll(fetched);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveRecord(LayingDailyRecord record) async {
    if (galpon.id == null) return;
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final saved = await _repository.createOrUpdateDailyRecord(
        record.copyWith(galponId: galpon.id ?? ''),
      );
      final index = _records.indexWhere((element) => element.id == saved.id);
      if (index >= 0) {
        _records[index] = saved;
      } else {
        _records.insert(0, saved);
      }
      editingRecord = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void selectRecord(LayingDailyRecord record) {
    editingRecord = record;
    notifyListeners();
  }

  void clearEditing() {
    editingRecord = null;
    notifyListeners();
  }

  Future<void> finalizeGalpon() async {
    if (galpon.id == null) return;
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await _repository.finalizeGalpon(galpon);
      await _refreshGalpon();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> reactivateGalpon() async {
    if (galpon.id == null) return;
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      await _repository.reactivateGalpon(galpon.id!);
      await _refreshGalpon();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  int get totalProductionToday =>
      records.isEmpty ? 0 : records.first.totalProduction;

  int get cumulativeMortality =>
      records.fold(0, (prev, element) => prev + element.mortality);

  int get currentCensus {
    final current = galpon.populationInitial - cumulativeMortality;
    return current < 0 ? 0 : current;
  }

  double get posturePercentage {
    final census = currentCensus;
    if (census <= 0) return 0;
    return (totalProductionToday / census) * 100;
  }

  Future<void> _refreshGalpon() async {
    if (galpon.id == null) return;
    final refreshed = await _repository.refreshGalpon(galpon.id!);
    if (refreshed != null) {
      galpon = refreshed;
      notifyListeners();
    }
  }
}
