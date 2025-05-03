import 'package:intl/intl.dart';

import 'production.dart';

extension ProductionReportExtension on Production {
  Map<String, dynamic> toReportData() {
    return {
      'Fecha': DateFormat('dd/MM/yyyy').format(createDate),
      'Cantidad': quantity,
      'Unidad de medida': unitOfMeasurement,
      'Precio': price,
    };
  }
}
