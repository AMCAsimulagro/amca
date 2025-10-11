/// {@category Features AnimalHusbandry Create}
/// This file contains the implementation of the [CreateAnimalHusbandryVM] class, which serves as the ViewModel
/// for creating and managing pig farming activities. It interacts with the data layer through the [AnimalHusbandryRepository]
/// to perform CRUD operations on pig farming data. The ViewModel provides functionality to initialize data,
/// create, retrieve, update, and delete pig farming activities. Dependencies include the [AnimalHusbandryRepository],
/// [MilkAnimalHusbandry], and Flutter's [ChangeNotifier].
library;

import 'package:amca/data/repository/livestock/animal_husbandry_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_animal_husbandry.dart';
import 'package:flutter/cupertino.dart';

/// ViewModel for creating and managing pig farming activities.
class CreateAnimalHusbandryVM extends ChangeNotifier {
  /// Instance of [AnimalHusbandryRepository] for performing CRUD operations
  final AnimalHusbandryRepository _animalHusbandryRepository =
      locator<AnimalHusbandryRepository>();

  MilkAnimalHusbandry? _currentAnimalHusbandry;

  MilkAnimalHusbandry? get currentAnimalHusbandry => _currentAnimalHusbandry;

  bool get isEditMode => _currentAnimalHusbandry != null;

  /// Initializes the ViewModel with optional pig farming data
  void init({MilkAnimalHusbandry? animalHusbandry}) async {
    try {
      if (animalHusbandry != null) {
        _currentAnimalHusbandry = animalHusbandry;
      }
    } finally {
      notifyListeners();
    }
  }

  /// Crea o actualiza un registro de ganaderia
  Future<MilkAnimalHusbandry?> createAnimalHusbandry(
      MilkAnimalHusbandry animalHusbandry) async {
    try {
      _currentAnimalHusbandry = animalHusbandry;
      final result = await _animalHusbandryRepository
          .createMilkAnimalHusbandry(animalHusbandry);
      _currentAnimalHusbandry = result;
      notifyListeners();
      return result;
    } catch (e) {
      return null;
    }
  }

  /// Obtiene un registro específico de ganaderia
  Future<MilkAnimalHusbandry?> getAnimalHusbandry() async {
    try {
      if (_currentAnimalHusbandry?.id != null) {
        _currentAnimalHusbandry = await _animalHusbandryRepository
            .getMilkById(_currentAnimalHusbandry!.id!);
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

  /// Actualiza los cálculos financieros
  void refreshFinancialCalculations() {
    notifyListeners();
  }

  /// Cálculo de beneficios
  int get netProfit {
    return (_currentAnimalHusbandry?.totalPrice() ?? 0) -
        (_currentAnimalHusbandry?.calculateTotalCostAndExpense() ?? 0);
  }
}
