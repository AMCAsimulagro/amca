/// {@category Menu farming info}
library;

import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/data/repository/livestock/animal_husbandry_repository.dart';
import 'package:amca/data/repository/livestock/pig_farming_repository.dart';
import 'package:amca/data/repository/livestock/fish_husbandry_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/meat/meat_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/fish_husbandry/fish_husbandry.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/pig_farming/pig_farming.dart';
import 'package:amca/domain/model/permanent_farming.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:flutter/cupertino.dart';

class AllFarmingHistoryVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();
  final AnimalHusbandryRepository animalHusbandryRepository =
      locator<AnimalHusbandryRepository>();
  final PigFarmingRepository pigFarmingRepository =
      locator<PigFarmingRepository>();
  final FishHusbandryRepository fishHusbandryRepository =
      locator<FishHusbandryRepository>();

  List<TransitoryFarming> farmingHistory = [];
  List<PermanentFarming> farmingHistoryPermanent = [];
  List<MilkAnimalHusbandry> milkAnimalHusbandry = [];
  List<MeatAnimalHusbandry> meatAnimalHusbandry = [];
  List<FishHusbandry> fishHusbandry = [];
  List<PigFarming> pigFarming = [];

  bool isLoading = true;

  Future<void> init() async {
    isLoading = true;
    try {
      farmingHistory = await farmingRepository.getAllFarmingHistoryByAdmin();
      farmingHistoryPermanent =
          await farmingRepository.getAllFarmingPermanentHistoryByAdmin();
      milkAnimalHusbandry =
          await animalHusbandryRepository.getAllMilkHistoryByAdmin();
      meatAnimalHusbandry =
          await animalHusbandryRepository.getAllMeatHistoryByAdmin();
      fishHusbandry = await fishHusbandryRepository.getAllFishHistoryByAdmin();
      pigFarming = await pigFarmingRepository.getAllPigFarmingHistoryByAdmin();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
