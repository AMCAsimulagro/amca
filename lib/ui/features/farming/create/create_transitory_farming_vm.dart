import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:flutter/cupertino.dart';

class CreateTransitoryFarmingVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();

  List<String> crop = [];
  List<CropTypes> cropTypes = [];
  List<String> sownTypes = [];

  void init() async {
    try {
      cropTypes = await farmingRepository.getCropTypes();
      sownTypes = await farmingRepository.getSown();
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }

  Future<TransitoryFarming?> createTransitoryFarming(
      TransitoryFarming transitoryFarming) async {
    try {
      return await farmingRepository.createTransitoryFarming(transitoryFarming);
    } catch (e) {
      return null;
    }
  }

  void onCropType(String cropSelected) {
    crop =
        cropTypes.firstWhere((element) => element.tipo == cropSelected).cultivo;
    notifyListeners();
  }
}
