import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

/// Widget que muestra un botón para descargar datos en Excel o PDF,
/// utilizando SnackBar para las notificaciones.
class AmcaDownloadButton extends StatelessWidget {
  /// Cada fila es una lista de celdas que irán en la hoja de cálculo.
  final List<List<String>> excelData;

  /// Función que construye y retorna el `pw.Document` con tu contenido PDF.
  final pw.Document Function() pdfDocumentBuilder;

  const AmcaDownloadButton({
    Key? key,
    required this.excelData,
    required this.pdfDocumentBuilder,
  }) : super(key: key);

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

    final xcel.Workbook workbook =
        xcel.Workbook(); // XlsIO :contentReference[oaicite:2]{index=2}
    final xcel.Worksheet sheet = workbook.worksheets[0];

    // Volcar cada celda de excelData en la hoja
    for (var i = 0; i < excelData.length; i++) {
      for (var j = 0; j < excelData[i].length; j++) {
        sheet.getRangeByIndex(i + 1, j + 1).setText(excelData[i][j]);
      }
    }

    final bytes = workbook.saveAsStream();
    workbook.dispose();

    final path = '/storage/emulated/0/Download/amca_data.xlsx';
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

    final doc =
        pdfDocumentBuilder(); // pdf/widgets :contentReference[oaicite:4]{index=4}
    final bytes = await doc.save();

    final path = '/storage/emulated/0/Download/amca_data.pdf';
    await File(path).writeAsBytes(bytes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF guardado en $path'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
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
