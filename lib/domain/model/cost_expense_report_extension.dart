import 'package:intl/intl.dart';

import '../../ui/utils/amca_words.dart';
import 'cost_expense.dart';

extension CostAndExpenseExtension on CostAndExpense {
  Map<String, dynamic> toReportData() => {
        AmcaWords.date: DateFormat('dd/MM/yyyy').format(createDate),
        AmcaWords.name: productOrService,
        AmcaWords.costOrExpense: description.costOrExpense,
        AmcaWords.type: description.type,
        AmcaWords.description: description.description,
        AmcaWords.quantity: quantity,
        AmcaWords.price: price,
      };
}
