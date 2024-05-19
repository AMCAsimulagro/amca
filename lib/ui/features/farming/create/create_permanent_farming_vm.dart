/// {@category Features Farming Create}
/// This file contains the implementation of the [CreatePermanentFarmingVM] class, which serves as the ViewModel
/// for creating and managing permanent farming activities. It interacts with the data layer through the [FarmingRepository]
/// to perform CRUD operations on permanent farming data. The ViewModel provides functionality to initialize data,
/// create, retrieve, update, and delete permanent farming activities. Dependencies include the [FarmingRepository],
/// [CropTypes], [PermanentFarming], and Flutter's [ChangeNotifier].

/// Imports of Bookstores and Resources
import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/crop_types.dart';
import 'package:amca/domain/model/permanent_farming.dart';
import 'package:flutter/cupertino.dart';

/// ViewModel for creating and managing permanent farming activities.
class CreatePermanentFarmingVM extends ChangeNotifier {

  /// Instance of [FarmingRepository] for performing CRUD operations on permanent farming data.
  final FarmingRepository farmingRepository = locator<FarmingRepository>();

  List<String> crop = [];/// List of crops.
  List<CropTypes> cropTypes = [];/// List of crop types.
  List<String> sownTypes = [];/// List of sown types.

  PermanentFarming? permanentFarming; /// The permanent farming activity.

  bool get isEditMode => permanentFarming != null;/// Indicates whether the ViewModel is in edit mode.

/// Initializes the ViewModel with optional permanent farming data.
  void init({
    PermanentFarming? permanentFarming,
  }) async {
    try {
      if (permanentFarming != null) {
        this.permanentFarming = permanentFarming;
      }
      cropTypes = await farmingRepository.getPermanentCropTypes();
      sownTypes = await farmingRepository.getSown();
    } catch (e) {
    } finally {
      notifyListeners();
    }
  }

/// Creates a permanent farming activity.
  Future<PermanentFarming?> createPermanentFarming(
      PermanentFarming permanentFarming) async {
    try {
      this.permanentFarming = permanentFarming;
      return await farmingRepository.createPermanentFarming(permanentFarming);
    } catch (e) {
      return null;
    }
  }

/// Retrieves a permanent farming activity.
  Future<PermanentFarming?> getPermanentFarming() async {
    try {
      permanentFarming = await farmingRepository.getPermanentFarmingById(permanentFarming!.id!);
      return permanentFarming;
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
  
/// Deletes a permanent farming activity.
  Future<void> deletePermanentFarming() async {
    try {
      return await farmingRepository.deletePermanentFarming(permanentFarming!.id!);
    } catch (e) {
      return;
    }
  }
}
