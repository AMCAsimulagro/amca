import 'package:amca/ui/utils/report_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

import 'amca_words.dart';

class GenerateExcelReport {
  Future<List<int>> exportToExcelWithCharts(
      BuildContext context, Map<String, dynamic> data) async {
    final workbook = xcel.Workbook();
    final sheet = workbook.worksheets[0];
    final Uint8List imageBytes = await ReportUtils().loadLogoBytes();
    final xcel.Picture picture = sheet.pictures.addStream(1, 1, imageBytes);
    picture.height = 100;
    picture.width = 100;
    sheet.getRangeByIndex(3, 3).setText(AmcaWords.dateGeneration);
    sheet
        .getRangeByIndex(4, 3)
        .setText(DateFormat('dd/MM/yyyy').format(DateTime.now()));
    int currentRow = 6;

    for (final entry
        in data.entries.where((e) => (e.value is! List && e.value is! Map))) {
      sheet.getRangeByIndex(currentRow, 1).setText(entry.key);
      sheet.getRangeByIndex(currentRow, 2).setText(entry.value.toString());
      currentRow++;
    }

    currentRow += 2;

    for (final entry
        in data.entries.where((e) => (e.value is List || e.value is Map))) {
      final title = entry.key;
      final rows = ReportUtils().normalizeToList(entry.value);
      if (rows.isEmpty) continue;

      sheet.getRangeByIndex(currentRow, 1).setText(title);
      sheet
          .getRangeByIndex(currentRow, 1, currentRow, rows.first.keys.length)
          .merge();
      currentRow++;

      // Headers
      final headers = rows.first.keys.toList();
      for (int col = 0; col < headers.length; col++) {
        sheet.getRangeByIndex(currentRow, col + 1).setText(headers[col]);
      }
      currentRow++;

      for (final row in rows) {
        for (int col = 0; col < headers.length; col++) {
          sheet
              .getRangeByIndex(currentRow, col + 1)
              .setText(row[headers[col]]?.toString() ?? '');
        }
        currentRow++;
      }
      currentRow += 2;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    return bytes;
  }
}
