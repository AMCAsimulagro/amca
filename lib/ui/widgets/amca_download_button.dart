import 'dart:async';
import 'dart:io';

import 'package:amca/ui/utils/generate_excel_report.dart';
import 'package:amca/ui/utils/generate_pdf_report.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

/// Widget que muestra un botón para descargar datos en Excel o PDF,
/// utilizando SnackBar para las notificaciones.
class AmcaDownloadButton extends StatelessWidget {
  /// data contiene los datos a exportar
  final Map<String, dynamic> data;

  const AmcaDownloadButton({
    Key? key,
    required this.data,
  }) : super(key: key);

  /// Solicita permiso de almacenamiento en Android.
  Future<bool> _requestStoragePermission(BuildContext context) async {
    var permissionGranted = false;
    if (Platform.isAndroid) {
      final sdkInt = (await DeviceInfoPlugin().androidInfo).version.sdkInt;

      if (sdkInt >= 33) {
        final status = await Permission.mediaLibrary.request();
        permissionGranted = status.isGranted;
      } else {
        final status = await Permission.storage.request();
        permissionGranted = status.isGranted;
      }
    }
    if (!permissionGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permiso de almacenamiento denegado'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      ); // SnackBar nativo :contentReference[oaicite:1]{index=1}
    }
    return permissionGranted;
  }

  /// Genera el archivo Excel y lo guarda en Descargas.
  Future<void> _generateAndSaveExcel(BuildContext context) async {
    if (!await _requestStoragePermission(context)) {
      return;
    }
    final bytes =
        await GenerateExcelReport().exportToExcelWithCharts(context, data);

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

  /// Genera el archivo PDF y lo guarda en Descargas.
  Future<void> _generateAndSavePDF(BuildContext context) async {
    if (!await _requestStoragePermission(context)) {
      return;
    }

    final finca = data['Nombre'];
    final doc = await GeneratePdfReport().buildReportPdf(context, data);
    final bytes = await doc.save();
    final formattedDate = DateFormat('yyyy_MM_dd').format(DateTime.now());
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
