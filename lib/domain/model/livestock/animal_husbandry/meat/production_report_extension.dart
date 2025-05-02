import 'package:intl/intl.dart';
import 'production.dart'; // Importa tu modelo base

extension ProductionReportExtension on Production {
  @override
  Map<String, dynamic> toReportData() {
    return {
      'Fecha': DateFormat('dd/MM/yyyy').format(createDate),
      'Cantidad': quantity,
      'Unidad de medida': unitOfMeasurement,
      if (average != null) 'Promedio': average,
      if (totalValue != null) 'Valor total': totalValue,
    };
  }
}
