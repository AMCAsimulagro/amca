import 'package:amca/data/repository/farming_repository.dart';
import 'package:amca/dependecy_injection.dart';
import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:amca/ui/features/costs_expenses/manage/product_service_data.dart';
import 'package:flutter/cupertino.dart';

class ManageCostExpenseVM extends ChangeNotifier {
  ManageCostExpenseVM(this.farmingId);

  final FarmingRepository farmingRepository = locator<FarmingRepository>();

  TransitoryFarming? transitoryFarming;

  ProductOrService? productOrServiceSelected;

  Description? descriptionSelected;

  bool isLoading = true;
  String farmingId;

  Future<void> init() async {
    isLoading = true;
    try {
      transitoryFarming =
          await farmingRepository.getTransitoryFarmingById(farmingId);
    } catch (e) {
    } finally {
      notifyListeners();
      isLoading = false;
    }
  }

  void setProductOrServiceSelected(String name) {
    productOrServiceSelected = ProductServiceData.productServiceList
        .firstWhere((element) => name == element.productOrServiceName);
    notifyListeners();
  }

  void setDescriptionSelected(String name) {
    descriptionSelected = productOrServiceSelected?.description
        .firstWhere((element) => name == element.description);
    notifyListeners();
  }
}
