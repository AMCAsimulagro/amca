/// {@category Domain}
/// This file contains the definition of the ProductOrService class.
/// The ProductOrService class represents a product or service with properties for its name and description.
/// It includes a list of Description objects to provide details about the product or service.
library;

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/description.dart';

/// Represents a product or service.
class ProductOrService {
  String productOrServiceName;// Name of the product or service.
  List<Description> description;// List of descriptions providing details about the product or service.


  /// Constructor for ProductOrService.
  /// Takes the productOrServiceName and a list of descriptions.
  ProductOrService({
    required this.productOrServiceName,
    required this.description,
  });
}
