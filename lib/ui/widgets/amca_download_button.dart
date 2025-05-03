import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

/// Widget que muestra un botón para descargar datos en Excel o PDF,
/// utilizando SnackBar para las notificaciones.
class AmcaDownloadButton extends StatelessWidget {
  /// data contiene los datos a exportar
  final Map<String, dynamic> data;

  const AmcaDownloadButton({
    Key? key,
    required this.data,
  }) : super(key: key);

  Future<pw.Document> buildReportPdf(BuildContext context) async {
    final pdf = pw.Document();
    final formattedNowDate =
        DateFormat("d 'de' MMMM 'de' y", 'es_ES').format(DateTime.now());
    final finca = data['Nombre'];

    // Sección de costos y gastos
    final costData = data['Costos y gastos'] as List<Map<String, dynamic>>?;
    final costTable = costData != null && costData.isNotEmpty
        ? buildTableSection('Costos y Gastos', costData)
        : null;

    // Sección de producciones
    final prodData =
        normalizeToList(data['Producciones'] ?? data['Producción']);
    final prodTable = prodData.isNotEmpty
        ? buildTableSection(
            prodData.length == 1 ? 'Producción' : 'Producciones', prodData)
        : null;

    data.remove('Nombre');
    data.remove('Costos y gastos');
    data.remove('Producción');
    data.remove('Producciones');

    // Sección encabezado
    final generalInfo = data.entries
        .where((e) => e.value is! List)
        .where((e) => e.value is! Map)
        .map((e) => pw.Text(
              '${e.key}: ${e.value}',
              style: const pw.TextStyle(fontSize: 16),
            ))
        .toList();

    final logo = await loadLogoBytes();
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
                  'Reporte finca $finca',
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

  List<Map<String, dynamic>> normalizeToList(dynamic data) {
    if (data == null) return [];
    if (data is List) return List<Map<String, dynamic>>.from(data);
    if (data is Map<String, dynamic>) return [data];
    throw Exception('Formato de producción no válido');
  }

  Future<Uint8List> loadLogoBytes() async {
    final bytes = await rootBundle.load('assets/images/logo.png');
    return bytes.buffer.asUint8List();
  }

  pw.Widget buildTableSection(String title, List<Map<String, dynamic>> rows) {
    print('rows -> $rows');
    final headers = rows.first.keys.toList();

    // Calcular el valor total
    double total = 0;
    for (final row in rows) {
      final precio = double.tryParse(
              row['Precio']?.toString().replaceAll(',', '') ?? '0') ??
          0;
      final cantidad = double.tryParse(
              row['Cantidad']?.toString().replaceAll(',', '') ?? '0') ??
          0;
      total += precio * cantidad;
    }

    // Formatear a pesos con comas
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
              'Valor Total: $valorTotal',
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  /// Solicita permiso de almacenamiento en Android.
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final sdkInt = (await DeviceInfoPlugin().androidInfo).version.sdkInt;

      if (sdkInt >= 33) {
        final status = await Permission.mediaLibrary.request();
        return status.isGranted;
      } else {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
    }
    return true;
  }

  /// Genera el archivo Excel y lo guarda en Descargas.
  Future<void> _generateAndSaveExcel(BuildContext context) async {
    if (!await _requestStoragePermission()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permiso de almacenamiento denegado'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      ); // SnackBar nativo :contentReference[oaicite:1]{index=1}
      return;
    }
    final bytes = await exportToExcelWithCharts();

    final now = DateTime.now();
    final formattedDate = DateFormat('yyyyMMdd').format(now);
    final path =
        '/storage/emulated/0/Download/reporte_${data['Nombre']}_$formattedDate.xlsx';
    await File(path).writeAsBytes(bytes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Excel guardado en $path'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    ); // uso de ScaffoldMessenger :contentReference[oaicite:3]{index=3}
    await _openFileWithFeedback(context, path);
  }

  Future<List<int>> exportToExcelWithCharts() async {
    final workbook = xcel.Workbook();
    final sheet = workbook.worksheets[0];
    // Insertar imagen
    final Uint8List imageBytes =
        await loadLogoBytes(); // Carga desde assets o red
    final xcel.Picture picture = sheet.pictures.addStream(1, 1, imageBytes);
    picture.height = 100;
    picture.width = 100;
    sheet
        .getRangeByIndex(3, 3)
        .setText('Fecha de Generación');
    sheet
        .getRangeByIndex(4, 3)
        .setText(DateFormat('dd/MM/yyyy').format(DateTime.now()));
    int currentRow = 6;

    // 1. Datos simples
    for (final entry
        in data.entries.where((e) => (e.value is! List && e.value is! Map))) {
      sheet.getRangeByIndex(currentRow, 1).setText(entry.key);
      sheet.getRangeByIndex(currentRow, 2).setText(entry.value.toString());
      currentRow++;
    }

    currentRow += 2;

    // 2. Tablas y gráficos
    for (final entry
        in data.entries.where((e) => (e.value is List || e.value is Map))) {
      final title = entry.key;
      final rows = normalizeToList(entry.value);
      if (rows.isEmpty) continue;

      // Título
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

      // Datos
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

    // 4. Guardar
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    return bytes;
  }

  /// Genera el archivo PDF y lo guarda en Descargas.
  Future<void> _generateAndSavePDF(BuildContext context) async {
    if (!await _requestStoragePermission()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permiso de almacenamiento denegado'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final finca = data['Nombre'];
    final doc = await buildReportPdf(context);
    final bytes = await doc.save();
    final now = DateTime.now();
    final formattedDate = DateFormat('yyyy_MM_dd').format(now);
    final path =
        '/storage/emulated/0/Download/Reporte_${finca}_$formattedDate.pdf';
    await File(path).writeAsBytes(bytes);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('PDF guardado en Descargas'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
    await _openFileWithFeedback(context, path);
  }

  Future<void> _openFileWithFeedback(
      BuildContext context, String filePath) async {
    final result = await OpenFilex.open(filePath);

    if (result.type != ResultType.done) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('No se pudo abrir el archivo'),
          content: Text(
              'No encontramos una aplicación instalada que pueda abrir este tipo de archivo.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Aceptar'),
            ),
          ],
        ),
      );
    } else {
      print('Archivo abierto exitosamente.');
    }
  }

  /// Muestra diálogo para elegir formato de descarga.
  void _showDownloadOptions(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Opciones de descarga'),
        content: const Text('¿Deseas descargar como Excel o PDF?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _generateAndSaveExcel(context);
            },
            child: const Text('Excel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _generateAndSavePDF(context);
            },
            child: const Text('PDF'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.download, color: Colors.white),
      tooltip: 'Descargar',
      onPressed: () => _showDownloadOptions(context),
    );
  }
}
