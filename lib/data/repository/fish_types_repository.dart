/// {@category Repository}
library;

import 'package:amca/data/api/fish_types_api.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/livestock/fish_husbandry/fish_type.dart';

abstract class FishTypesRepository {
  Future<List<FishType>> getFishTypes();
  Future<FishType?> createFishType(FishType fishType);
  Future<FishType?> deleteFishType(FishType fishType);
}

class FishTypesRepositoryAdapter extends FishTypesRepository {
  final FishTypesApi _api = locator<FishTypesApi>();

  @override
  Future<List<FishType>> getFishTypes() => _api.getFishTypes();

  @override
  Future<FishType?> createFishType(FishType fishType) => _api.createFishType(fishType);

  @override
  Future<FishType?> deleteFishType(FishType fishType) => _api.deleteFishType(fishType);
}
