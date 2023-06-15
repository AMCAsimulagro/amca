import 'package:amca/domain/model/description.dart';

class ProductOrService {
  String productOrServiceName;
  List<Description> description;

  ProductOrService({
    required this.productOrServiceName,
    required this.description,
  });
}
