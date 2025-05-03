import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/report_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class GeneratePdfReport {
  Future<pw.Document> buildReportPdf(
      BuildContext context, Map<String, dynamic> data) async {
    final pdf = pw.Document();
    final formattedNowDate =
        DateFormat("d 'de' MMMM 'de' y", 'es_ES').format(DateTime.now());
    final farmName = data[AmcaWords.name];

    final costData =
        data[AmcaWords.costsAndExpenses] as List<Map<String, dynamic>>?;
    final costTable = costData != null && costData.isNotEmpty
        ? buildTableSection(AmcaWords.costsAndExpenses, costData)
        : null;

    final prodData = ReportUtils().normalizeToList(
        data[AmcaWords.productions] ?? data[AmcaWords.production]);
    final prodTable = prodData.isNotEmpty
        ? buildTableSection(
            prodData.length == 1 ? AmcaWords.production : AmcaWords.productions,
            prodData)
        : null;

    data.remove(AmcaWords.name);
    data.remove(AmcaWords.costsAndExpenses);
    data.remove(AmcaWords.production);
    data.remove(AmcaWords.productions);

    final generalInfo = data.entries
        .where((e) => e.value is! List)
        .where((e) => e.value is! Map)
        .map((e) => pw.Text(
              '${e.key}: ${e.value}',
              style: const pw.TextStyle(fontSize: 16),
            ))
        .toList();

    final logo = await ReportUtils().loadLogoBytes();
    final image = pw.MemoryImage(logo); // Tu logo como Uint8List

    final myPageTheme = pw.PageTheme(
      margin: const pw.EdgeInsets.all(30),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Center(
          child: pw.Opacity(
            opacity: 0.1,
            child: pw.Image(image, width: 800),
          ),
        ),
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        pageTheme: myPageTheme,
        build: (context) {
          return [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  '${AmcaWords.famrReport} $farmName',
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  formattedNowDate,
                  style: pw.TextStyle(
                      fontSize: 14, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
            pw.SizedBox(height: 14),
            ...generalInfo,
            if (costTable != null) ...[pw.SizedBox(height: 18), costTable],
            if (prodTable != null) ...[pw.SizedBox(height: 18), prodTable],
          ];
        },
      ),
    );
    return pdf;
  }

  pw.Widget buildTableSection(String title, List<Map<String, dynamic>> rows) {
    final headers = rows.first.keys.toList();

    double total = 0;
    for (final row in rows) {
      final price = double.tryParse(
              row[AmcaWords.price]?.toString().replaceAll(',', '') ?? '0') ??
          0;
      final amount = double.tryParse(
              row[AmcaWords.amount]?.toString().replaceAll(',', '') ?? '0') ??
          0;
      total += price * amount;
    }

    final valorTotal = NumberFormat('#,###', 'en').format(total);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title,
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.TableHelper.fromTextArray(
          headers: headers,
          data: rows
              .map((r) => headers.map((h) => r[h]?.toString() ?? '').toList())
              .toList(),
          headerStyle:
              pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold),
          border: pw.TableBorder.all(),
          cellStyle: const pw.TextStyle(fontSize: 10),
          cellAlignment: pw.Alignment.center,
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
        ),
        pw.SizedBox(height: 8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Text(
              '${AmcaWords.totalValue}: $valorTotal',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
