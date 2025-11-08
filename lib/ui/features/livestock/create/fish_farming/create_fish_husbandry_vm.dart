/// {@category Features FishHusbandry Create}
/// ViewModel para crear y manejar registros de piscicultura (FishHusbandry).
/// Contiene operaciones básicas: inicialización, creación/actualización, obtención y eliminación.
library;

import 'package:amca/data/repository/livestock/fish_husbandry_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/fish_husbandry/fish_husbandry.dart';
import 'package:flutter/cupertino.dart';

/// ViewModel para crear y administrar actividades de piscicultura.
class CreateFishHusbandryVM extends ChangeNotifier {
  /// Repositorio para realizar operaciones CRUD sobre piscicultura.
  final FishHusbandryRepository _fishHusbandryRepository =
      locator<FishHusbandryRepository>();

  FishHusbandry? _currentFishHusbandry;

  FishHusbandry? get currentFishHusbandry => _currentFishHusbandry;

  bool get isEditMode => _currentFishHusbandry != null;

  /// Inicializa el ViewModel con un registro opcional.
  Future<void> init({FishHusbandry? fishHusbandry}) async {
    try {
      if (fishHusbandry != null) {
        _currentFishHusbandry = fishHusbandry;
      }
    } finally {
      notifyListeners();
    }
  }

  /// Crea o actualiza un registro de piscicultura.
  Future<FishHusbandry?> createFishHusbandry(
      FishHusbandry fishHusbandry) async {
    try {
      _currentFishHusbandry = fishHusbandry;
      final result =
          await _fishHusbandryRepository.createFishHusbandry(fishHusbandry);
      _currentFishHusbandry = result;
      notifyListeners();
      return result;
    } catch (e) {
      // Aquí se podría loggear el error o convertirlo a AppException
      return null;
    }
  }

  /// Obtiene el registro actual desde el repositorio (si existe id).
  Future<FishHusbandry?> getFishHusbandry() async {
    try {
      if (_currentFishHusbandry?.id != null) {
        _currentFishHusbandry = await _fishHusbandryRepository
            .getFishById(_currentFishHusbandry!.id!);
        notifyListeners();
      }
      return _currentFishHusbandry;
    } catch (e) {
      return null;
    }
  }

  /// Maneja la selección de categoría (si aplica para piscicultura).
  void onFishCategorySelected(String category) {
    // Implementar si existen categorías específicas para piscicultura
  }

  /// Elimina el registro actual de piscicultura.
  Future<void> deleteFishHusbandry() async {
    try {
      if (_currentFishHusbandry?.id != null) {
        await _fishHusbandryRepository
            .deleteFishHusbandry(_currentFishHusbandry!.id!);
        _currentFishHusbandry = null;
        notifyListeners();
      }
    } catch (e) {
      // Manejo de error mínimo: simplemente retornar
      return;
    }
  }

  /// Refresca cálculos financieros o cualquier dato dependiente.
  void refreshFinancialCalculations() {
    notifyListeners();
  }
}
