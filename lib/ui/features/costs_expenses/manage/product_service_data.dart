/// {@category Features CostExpense Manage}
/// Data management class for product or service options.
/// This class provides static lists of product or service options along with their descriptions.
/// Each product or service has a name and a list of descriptions associated with it.
/// Each description includes details such as the description itself, whether it's a cost or expense, and its type.

/// Imports of Bookstores and Resources
import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:amca/ui/utils/amca_words.dart';

// Class to manage data for product or service selection.
class ProductServiceData {

// List of product or service options.
  static final List<ProductOrService> productServiceList = [
    service,
    product,
    other,
    salaries,
  ];

  static final service = ProductOrService(
    productOrServiceName: AmcaWords.service,
    description: [
      Description(
        description: 'Servicios Públicos',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.variable,
      ),
    ],
  );

  static final product = ProductOrService(
    productOrServiceName: AmcaWords.product,
    description: [
      Description(
        description: 'Insecticidas',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Abono Orgánico',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Abono Químico',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Materia Vegetal',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Herramientas',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Concentrado',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Sal Mineralizada',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.variable,
      ),
    ],
  );

  static final other = ProductOrService(
    productOrServiceName: AmcaWords.other,
    description: [
      Description(
        description: 'Servicios Públicos',
        costOrExpense: AmcaWords.expense,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Mantenimiento Preventivo',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.permanent,
      ),
      Description(
        description: 'Mantenimiento Correctivo',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Arrendamiento',
        costOrExpense: AmcaWords.expense,
        type: AmcaWords.permanent,
      ),
      Description(
        description: 'Impuestos',
        costOrExpense: AmcaWords.expense,
        type: AmcaWords.permanent,
      ),
      Description(
        description: 'Imprevistos',
        costOrExpense: AmcaWords.expense,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Transporte',
        costOrExpense: AmcaWords.expense,
        type: AmcaWords.variable,
      ),
    ],
  );

  static final salaries = ProductOrService(
    productOrServiceName: AmcaWords.salaries,
    description: [
      Description(
        description: 'Sueldo',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.permanent,
      ),
      Description(
        description: 'Jornales',
        costOrExpense: AmcaWords.costs,
        type: AmcaWords.variable,
      ),
    ],
  );
}
