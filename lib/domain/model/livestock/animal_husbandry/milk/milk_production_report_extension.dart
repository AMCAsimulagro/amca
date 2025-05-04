import 'package:intl/intl.dart';

import '../../../../../ui/utils/amca_words.dart';
import 'milk_production.dart';

extension ProductionReportExtension on Production {
  Map<String, dynamic> toReportData() {
    return {
      AmcaWords.date: DateFormat('dd/MM/yyyy').format(createDate),
      AmcaWords.quantity: quantity,
      AmcaWords.unitOfMeasurement: unitOfMeasurement,
      AmcaWords.price: price,
    };
  }
}
