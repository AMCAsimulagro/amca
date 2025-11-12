/// {@category Features AnimalHusbandry Create}
/// This file contains the implementation of the [CreateMeetAnimalHusbandryVM] class, which serves as the ViewModel
/// for creating and managing pig farming activities. It interacts with the data layer through the [AnimalHusbandryRepository]
/// to perform CRUD operations on pig farming data. The ViewModel provides functionality to initialize data,
/// create, retrieve, update, and delete pig farming activities. Dependencies include the [AnimalHusbandryRepository],
/// [MeatAnimalHusbandry], and Flutter's [ChangeNotifier].
library;

import 'package:amca/data/repository/livestock/animal_husbandry_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/meat/meat_animal_husbandry.dart';
import 'package:flutter/cupertino.dart';

/// ViewModel for creating and managing pig farming activities.
class CreateMeetAnimalHusbandryVM extends ChangeNotifier {
  /// Instance of [AnimalHusbandryRepository] for performing CRUD operations
  final AnimalHusbandryRepository _animalHusbandryRepository =
      locator<AnimalHusbandryRepository>();

  MeatAnimalHusbandry? _currentAnimalHusbandry;

  MeatAnimalHusbandry? get currentAnimalHusbandry => _currentAnimalHusbandry;

  bool get isEditMode => _currentAnimalHusbandry != null;

  /// Initializes the ViewModel with optional pig farming data
  void init({MeatAnimalHusbandry? animalHusbandry}) async {
    try {
      if (animalHusbandry != null) {
        _currentAnimalHusbandry = animalHusbandry;
      }
    } finally {
      notifyListeners();
    }
  }

  /// Crea o actualiza un registro de ganaderia
  Future<MeatAnimalHusbandry?> createAnimalHusbandry(
      MeatAnimalHusbandry animalHusbandry) async {
    try {
      _currentAnimalHusbandry = animalHusbandry;
      final result = await _animalHusbandryRepository
          .createMeatAnimalHusbandry(animalHusbandry);
      _currentAnimalHusbandry = result;
      notifyListeners();
      return result;
    } catch (e) {
      return null;
    }
  }

  /// Obtiene un registro específico de ganaderia
  Future<MeatAnimalHusbandry?> getAnimalHusbandry() async {
    try {
      if (_currentAnimalHusbandry?.id != null) {
        _currentAnimalHusbandry = await _animalHusbandryRepository
            .getMeatById(_currentAnimalHusbandry!.id!);
        notifyListeners();
      }
      return _currentAnimalHusbandry;
    } catch (e) {
      return null;
    }
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
}
