import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:flutter/cupertino.dart';

class ManageFarmingInfoVM extends ChangeNotifier {
  final FarmingRepository farmingRepository = locator<FarmingRepository>();
  List<String> crops = [];
  bool isLoading = false;

  void deleteCrop(String crop) {
    crops.remove(crop);
    notifyListeners();
  }

  void addCrop(String crop) {
    crops.add(crop);
    notifyListeners();
  }

  bool validateCrop(String value) {
    for (var crop in crops) {
      if (crop.toLowerCase().trim() == value.toLowerCase().trim()) {
        return true;
      }
    }
    return false;
  }

  bool cropAlreadyExist(
      List<CropTypes> allCropTypes, String value, CropTypes currentCropType) {
    final auxList = [...allCropTypes];
    auxList.removeWhere((element) => element.tipo == currentCropType.tipo);
    for (var crop in auxList) {
      if (crop.tipo.toLowerCase().trim() == value.toLowerCase().trim()) {
        return true;
      }
    }
    return false;
  }

  void replaceValue(String firstValue, String cultivo) {
    final index = crops.indexOf(firstValue);
    crops[index] = cultivo;
    notifyListeners();
  }

  Future<void> createCropType(CropTypes cropTypes) async {
    isLoading = true;
    try {
      await farmingRepository.createCropType(cropTypes);
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCropType(CropTypes? cropType) async {
    isLoading = true;
    try {
      await farmingRepository.deleteCropType(cropType!);
    } catch (e) {
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
