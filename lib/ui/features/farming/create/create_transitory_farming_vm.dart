/// {@category Features Farming Create}
/// This file contains the implementation of the [CreateTransitoryFarmingVM] class, which serves as the ViewModel
/// for creating and managing transitory farming activities. It interacts with the data layer through the [FarmingRepository]
/// to perform CRUD operations on transitory farming data. The ViewModel provides functionality to initialize data,
/// create, retrieve, update, and delete transitory farming activities. Dependencies include the [FarmingRepository],
/// [CropTypes], [TransitoryFarming], and Flutter's [ChangeNotifier].
library;

/// Imports of Bookstores and Resources
import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:flutter/cupertino.dart';

/// ViewModel for creating and managing transitory farming activities.
class CreateTransitoryFarmingVM extends ChangeNotifier {

  /// Instance of [FarmingRepository] for performing CRUD operations on transitory farming data.
  final FarmingRepository farmingRepository = locator<FarmingRepository>();

  List<String> crop = [];/// List of crops.
  List<CropTypes> cropTypes = [];/// List of crop types.
  List<String> sownTypes = [];/// List of sown types.

  TransitoryFarming? transitoryFarming; /// The transitory farming activity.

  bool get isEditMode => transitoryFarming != null;/// Indicates whether the ViewModel is in edit mode.

/// Initializes the ViewModel with optional transitory farming data.
  void init({
    TransitoryFarming? transitoryFarming,
  }) async {
    try {
      if (transitoryFarming != null) {
        this.transitoryFarming = transitoryFarming;
      }
      cropTypes = await farmingRepository.getCropTypes();
      sownTypes = await farmingRepository.getSown();
    } finally {
      notifyListeners();
    }
  }

/// Creates a transitory farming activity.
  Future<TransitoryFarming?> createTransitoryFarming(
      TransitoryFarming transitoryFarming) async {
    try {
      this.transitoryFarming = transitoryFarming;
      return await farmingRepository.createTransitoryFarming(transitoryFarming);
    } catch (e) {
      return null;
    }
  }

/// Retrieves a transitory farming activity.
  Future<TransitoryFarming?> getTransitoryFarming() async {
    try {
      transitoryFarming = await farmingRepository.getTransitoryFarmingById(transitoryFarming!.id!);
      return transitoryFarming;
    } catch (e) {
      return null;
    }
  }

/// Handles the selection of a crop type.
  void onCropType(String cropSelected) {
    crop =
        cropTypes.firstWhere((element) => element.tipo == cropSelected).cultivo;
    notifyListeners();
  }
  
/// Deletes a transitory farming activity.
  Future<void> deleteTransitoryFarming() async {
    try {
      return await farmingRepository.deleteTransitoryFarming(transitoryFarming!.id!);
    } catch (e) {
      return;
    }
  }
}
