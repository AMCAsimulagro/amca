/// {@category Features AnimalHusbandry Create}
/// This file contains the implementation of the [CreateAnimalHusbandryVM] class, which serves as the ViewModel
/// for creating and managing pig farming activities. It interacts with the data layer through the [AnimalHusbandryRepository]
/// to perform CRUD operations on pig farming data. The ViewModel provides functionality to initialize data,
/// create, retrieve, update, and delete pig farming activities. Dependencies include the [AnimalHusbandryRepository],
/// [AnimalHusbandry], and Flutter's [ChangeNotifier].
library;

import 'package:amca/data/repository/livestock/animal_husbandry_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/animal_husbandry.dart';
import 'package:flutter/cupertino.dart';

/// ViewModel for creating and managing pig farming activities.
class CreateAnimalHusbandryVM extends ChangeNotifier {
  /// Instance of [AnimalHusbandryRepository] for performing CRUD operations
  final AnimalHusbandryRepository _animalHusbandryRepository =
      locator<AnimalHusbandryRepository>();

  List<String> _descriptionTypes = []; // Ej: Concentrado, Jornales, impuestos.
  List<String> _productionTypes = []; // Ej: Servicio, Producto, otro.
  List<String> _expensiveTypes = []; // Ej: Costo, Gasto.

  AnimalHusbandry? _currentAnimalHusbandry;

  // Getters públicos
  List<String> get descriptionTypes => _descriptionTypes;

  List<String> get productionTypes => _productionTypes;

  List<String> get expensiveTypes => _expensiveTypes;

  AnimalHusbandry? get currentAnimalHusbandry => _currentAnimalHusbandry;

  bool get isEditMode => _currentAnimalHusbandry != null;

  /// Initializes the ViewModel with optional pig farming data
  void init({AnimalHusbandry? animalHusbandry}) async {
    try {
      if (animalHusbandry != null) {
        _currentAnimalHusbandry = animalHusbandry;
      }
      // Cargar datos específicos de ganaderia
      _descriptionTypes = await _loadDescriptionTypes();
      _productionTypes = await _loadProductionTypes();
      _expensiveTypes = await _loadExpensiveTypes();
    } finally {
      notifyListeners();
    }
  }

  /// Crea o actualiza un registro de ganaderia
  Future<AnimalHusbandry?> createAnimalHusbandry(
      AnimalHusbandry animalHusbandry) async {
    try {
      _currentAnimalHusbandry = animalHusbandry;
      final result =
          await _animalHusbandryRepository.createAnimalHusbandry(animalHusbandry);
      _currentAnimalHusbandry = result;
      notifyListeners();
      return result;
    } catch (e) {
      return null;
    }
  }

  /// Obtiene un registro específico de ganaderia
  Future<AnimalHusbandry?> getAnimalHusbandry() async {
    try {
      if (_currentAnimalHusbandry?.id != null) {
        _currentAnimalHusbandry = await _animalHusbandryRepository
            .getAnimalHusbandryById(_currentAnimalHusbandry!.id!);
        notifyListeners();
      }
      return _currentAnimalHusbandry;
    } catch (e) {
      return null;
    }
  }

  /// Maneja la selección de categoría porcina
  void onPigCategorySelected(String category) {
    //_categories = _pigCategories.firstWhere((element)=> element == category);
  }

  /// Elimina un registro de ganaderia
  Future<void> deleteAnimalHusbandry() async {
    try {
      if (_currentAnimalHusbandry?.id != null) {
        await _animalHusbandryRepository
            .deleteAnimalHusbandry(_currentAnimalHusbandry!.id!);
        _currentAnimalHusbandry = null;
        notifyListeners();
      }
    } catch (e) {
      return;
    }
  }

  // Métodos auxiliares para carga de datos específicos
  Future<List<String>> _loadDescriptionTypes() async {
    // TODO Implementar lógica para obtener categorías de la API depende de lo seleccionado en ProductionType
    return ['Asistencia tecnica', 'Contratos'];
  }

  Future<List<String>> _loadProductionTypes() async {
    // TODO Implementar lógica para obtener tipos de producción
    return ['Servicio', 'Producto', 'Salarios', 'Otro'];
  }

  Future<List<String>> _loadExpensiveTypes() async {
    // TODO Implementar lógica para obtener tipos de
    return ['Costo', 'Gasto'];
  }

  /// Actualiza los cálculos financieros
  void refreshFinancialCalculations() {
    notifyListeners();
  }

  /// Cálculo de beneficios
  int get netProfit {
    return (_currentAnimalHusbandry?.totalPrice() ?? 0) -
        (_currentAnimalHusbandry?.calculateTotalCostAndExpense() ?? 0);
  }

  void onCropType(String optionSelected) {}
}
