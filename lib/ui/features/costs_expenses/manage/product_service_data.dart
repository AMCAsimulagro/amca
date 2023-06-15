import 'package:amca/domain/model/description.dart';
import 'package:amca/domain/model/product_or_service.dart';
import 'package:amca/ui/utils/amca_words.dart';

class ProductServiceData {

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
        costOrExpense: AmcaWords.cost,
        type: AmcaWords.variable,
      ),
    ],
  );

  static final product = ProductOrService(
    productOrServiceName: AmcaWords.product,
    description: [
      Description(
        description: 'Insecticidas',
        costOrExpense: AmcaWords.cost,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Abono Orgánico',
        costOrExpense: AmcaWords.cost,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Abono Químico',
        costOrExpense: AmcaWords.cost,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Materia Vegetal',
        costOrExpense: AmcaWords.cost,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Herramientas',
        costOrExpense: AmcaWords.cost,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Concentrado',
        costOrExpense: AmcaWords.cost,
        type: AmcaWords.variable,
      ),
      Description(
        description: 'Sal Mineralizada',
        costOrExpense: AmcaWords.cost,
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
        costOrExpense: AmcaWords.cost,
        type: AmcaWords.permanent,
      ),
      Description(
        description: 'Mantenimiento Correctivo',
        costOrExpense: AmcaWords.cost,
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
        costOrExpense: AmcaWords.cost,
        type: AmcaWords.permanent,
      ),
      Description(
        description: 'Jornales',
        costOrExpense: AmcaWords.cost,
        type: AmcaWords.variable,
      ),
    ],
  );
}
