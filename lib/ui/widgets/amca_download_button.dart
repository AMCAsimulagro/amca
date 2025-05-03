import 'dart:async';
import 'dart:io';

import 'package:amca/ui/utils/generate_excel_report.dart';
import 'package:amca/ui/utils/generate_pdf_report.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/amca_words.dart';

class AmcaDownloadButton extends StatelessWidget {
  final Map<String, dynamic> data;

  const AmcaDownloadButton({
    Key? key,
    required this.data,
  }) : super(key: key);

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
          content: Text(AmcaWords.noPermission),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
    return permissionGranted;
  }

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
          title: const Text(AmcaWords.noFileOpen),
          content: const Text(AmcaWords.noAppToFileOpen),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AmcaWords.accept),
            ),
          ],
        ),
      );
    }
  }

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
