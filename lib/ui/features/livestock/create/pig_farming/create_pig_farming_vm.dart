/// {@category Features PigFarming Create}
/// This file contains the implementation of the [CreatePigFarmingVM] class, which serves as the ViewModel
/// for creating and managing pig farming activities. It interacts with the data layer through the [PigFarmingRepository]
/// to perform CRUD operations on pig farming data. The ViewModel provides functionality to initialize data,
/// create, retrieve, update, and delete pig farming activities. Dependencies include the [PigFarmingRepository],
/// [PigFarming], and Flutter's [ChangeNotifier].
library;

import 'package:amca/data/repository/livestock/pig_farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/pig_farming/pig_farming.dart';
import 'package:flutter/cupertino.dart';

/// ViewModel for creating and managing pig farming activities.
class CreatePigFarmingVM extends ChangeNotifier {
  /// Instance of [PigFarmingRepository] for performing CRUD operations
  final PigFarmingRepository _pigFarmingRepository =
      locator<PigFarmingRepository>();

  List<String> _pigCategories = []; // Ej: Engorde, Reproducción
  List<String> _productionTypes = []; // Tipos de producción porcina
  List<String> _sownTypes = []; // Tipos de

  PigFarming? _currentPigFarming;

  // Getters públicos
  List<String> get pigCategories => _pigCategories;
  List<String> get productionTypes => _productionTypes;
  List<String> get sownTypes => _sownTypes;
  PigFarming? get currentPigFarming => _currentPigFarming;
  bool get isEditMode => _currentPigFarming != null;

  /// Initializes the ViewModel with optional pig farming data
  void init({PigFarming? pigFarming}) async {
    try {
      if (pigFarming != null) {
        _currentPigFarming = pigFarming;
      }
      // Cargar datos específicos de porcicultura
      _pigCategories = await _loadPigCategories();
      _productionTypes = await _loadProductionTypes();
      _sownTypes = await _loadSownTypes();
    } finally {
      notifyListeners();
    }
  }

  /// Crea o actualiza un registro de porcicultura
  Future<PigFarming?> createPigFarming(PigFarming pigFarming) async {
    try {
      _currentPigFarming = pigFarming;
      final result = await _pigFarmingRepository.createPigFarming(pigFarming);
      _currentPigFarming = result;
      notifyListeners();
      return result;
    } catch (e) {
      return null;
    }
  }

  /// Obtiene un registro específico de porcicultura
  Future<PigFarming?> getPigFarming() async {
    try {
      if (_currentPigFarming?.id != null) {
        _currentPigFarming = await _pigFarmingRepository
            .getPigFarmingById(_currentPigFarming!.id!);
        notifyListeners();
      }
      return _currentPigFarming;
    } catch (e) {
      return null;
    }
  }

  /// Maneja la selección de categoría porcina
  void onPigCategorySelected(String category) {
    //_categories = _pigCategories.firstWhere((element)=> element == category);
  }

  /// Elimina un registro de porcicultura
  Future<void> deletePigFarming() async {
    try {
      if (_currentPigFarming?.id != null) {
        await _pigFarmingRepository.deletePigFarming(_currentPigFarming!.id!);
        _currentPigFarming = null;
        notifyListeners();
      }
    } catch (e) {
      return;
    }
  }

  // Métodos auxiliares para carga de datos específicos
  Future<List<String>> _loadPigCategories() async {
    // TODO Implementar lógica para obtener categorías de la API
    return ['Engorde', 'Reproducción', 'Cría'];
  }

  Future<List<String>> _loadProductionTypes() async {
    // TODO Implementar lógica para obtener tipos de producción
    return ['Carne', 'Reproductores', 'Lechones'];
  }

  Future<List<String>> _loadSownTypes() async {
    // TODO Implementar lógica para obtener tipos de
    return [];
  }

  /// Actualiza los cálculos financieros
  void refreshFinancialCalculations() {
    notifyListeners();
  }

  /// Cálculo de beneficios
  // int get netProfit {
  //   return (_currentPigFarming?.totalPrice() ?? 0) -
  //          (_currentPigFarming?.calculateTotalCostAndExpense() ?? 0);
  // }

  void onCropType(String optionSelected) {}
}
