import 'package:intl/intl.dart';

import 'cost_expense.dart';

extension CostAndExpenseExtension on CostAndExpense {
  Map<String, dynamic> toReportData() => {
        'Fecha': DateFormat('dd/MM/yyyy').format(createDate),
        'Nombre': productOrService,
        'Costo/Gasto': description.costOrExpense,
        'Tipo': description.type,
        'Descripción': description.description,
        'Cantidad': quantity,
        'Precio': price,
      };
}
