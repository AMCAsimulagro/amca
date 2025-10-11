/// {@category Menu Farmin}
library;

import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/data/repository/livestock/animal_husbandry_repository.dart';
import 'package:amca/data/repository/livestock/pig_farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/pig_farming/pig_farming.dart';
import 'package:amca/domain/model/permanent_farming.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../domain/model/livestock/animal_husbandry/meat/meat_animal_husbandry.dart';

class FarmingHistoryVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();
  final AnimalHusbandryRepository animalHusbandryRepository =
      locator<AnimalHusbandryRepository>();
  final PigFarmingRepository pigFarmingRepository =
      locator<PigFarmingRepository>();
  List<TransitoryFarming> farmingHistory = [];
  List<PermanentFarming> farmingHistoryPermanent = [];
  List<MilkAnimalHusbandry> milkAnimalHusbandry = [];
  List<MeatAnimalHusbandry> meatAnimalHusbandry = [];
  List<PigFarming> pigFarming = [];
  bool isLoading = true;

  Future<void> init() async {
    isLoading = true;
    try {
      farmingHistory = await farmingRepository.getFarmingHistoryByUid(null);
      farmingHistoryPermanent =
          await farmingRepository.getPermanentFarmingHistoryByUid(null);
      milkAnimalHusbandry = await animalHusbandryRepository
          .getMilkAnimalHusbandryHistoryByUid(null);
      meatAnimalHusbandry = await animalHusbandryRepository.getMeatAnimalHusbandryHistoryByUid(null);
      pigFarming = await pigFarmingRepository.getPigFarmingHistoryByUid(null);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
