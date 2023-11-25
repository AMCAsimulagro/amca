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

  TransitoryFarming? transitoryFarming;

  bool get isEditMode => transitoryFarming != null;

  void init({
    TransitoryFarming? transitoryFarming,
  }) async {
    try {
      if (transitoryFarming != null) {
        this.transitoryFarming = transitoryFarming;
      }
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
      this.transitoryFarming = transitoryFarming;
      return await farmingRepository.createTransitoryFarming(transitoryFarming);
    } catch (e) {
      return null;
    }
  }

  Future<TransitoryFarming?> getTransitoryFarming() async {
    try {
      transitoryFarming = await farmingRepository.getTransitoryFarmingById(transitoryFarming!.id!);
      return transitoryFarming;
    } catch (e) {
      return null;
    }
  }

  void onCropType(String cropSelected) {
    crop =
        cropTypes.firstWhere((element) => element.tipo == cropSelected).cultivo;
    notifyListeners();
  }

  Future<void> deleteTransitoryFarming() async {
    try {
      return await farmingRepository.deleteTransitoryFarming(transitoryFarming!.id!);
    } catch (e) {
      return;
    }
  }
}
