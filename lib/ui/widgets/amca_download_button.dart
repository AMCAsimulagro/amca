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
import 'amca_select_form_field.dart';

class AmcaDownloadButton extends StatefulWidget {
  final Map<String, dynamic> data;

  const AmcaDownloadButton({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<AmcaDownloadButton> createState() => _AmcaDownloadButtonState();
}

class _AmcaDownloadButtonState extends State<AmcaDownloadButton> {
  static const downloadPath = '/storage/emulated/0/Download';
  static const optionSelectAll = 'Todos';
  static const excelFileName = 'Excel';
  static const excelExtension = 'xlsx';
  static const pdfFileName = 'PDF';
  static const pdfExtension = 'pdf';
  static const Map<String, String> _formats = {
    excelFileName: excelExtension,
    pdfFileName: pdfExtension,
  };
  bool _includeGeneralInfo = true;
  bool _includeCosts = true;
  final _productOrServiceController =
      TextEditingController(text: optionSelectAll);
  bool _includeProductions = true;
  String _selectedFormat = _formats.keys.first;

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
    if (!permissionGranted && mounted) {
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

  Future<void> _generateAndSaveReport(BuildContext context) async {
    if (!await _requestStoragePermission(context)) {
      return;
    }
    final formattedDate = DateFormat('dd_MM_yyyy').format(DateTime.now());
    final farmName = widget.data[AmcaWords.name];
    final fileFormat = _formats[_selectedFormat];

    _adjustDataToUserRequirements();

    var bytes = await GenerateExcelReport()
        .exportToExcelWithCharts(context, widget.data);
    switch (fileFormat) {
      case pdfExtension:
        final doc =
            await GeneratePdfReport().buildReportPdf(context, widget.data);
        bytes = await doc.save();
        break;
      default:
        bytes = await GenerateExcelReport()
            .exportToExcelWithCharts(context, widget.data);
        break;
    }

    final path =
        '$downloadPath/${AmcaWords.farmReport} ${farmName}_$formattedDate.$fileFormat';
    await File(path).writeAsBytes(bytes);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AmcaWords.reportSavedInDownloads),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    }
    await _openFileWithFeedback(context, path);
  }

  void _adjustDataToUserRequirements() {
    if (!_includeGeneralInfo) {
      List<String> keysToRemove = widget.data.entries
          .where((e) => e.value is! List)
          .where((e) => e.value is! Map)
          .where((e) => e.value == AmcaWords.name)
          .map((e) => e.key)
          .toList();
      widget.data.removeWhere((key, value) => keysToRemove.contains(key));
    }
    if (!_includeCosts) {
      widget.data.remove(AmcaWords.costsAndExpenses);
    }
    if (_includeCosts && _productOrServiceController.text != optionSelectAll) {
      final productOrService = _productOrServiceController.text;
      final costData = widget.data[AmcaWords.costsAndExpenses] as List<Map<String, dynamic>>;
      costData.removeWhere((data) => data[AmcaWords.name] != productOrService);
    }
    if (!_includeProductions) {
      widget.data.remove(AmcaWords.production);
      widget.data.remove(AmcaWords.productions);
    }
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

  List<String> _getListsOptionsSelect() {
    if (widget.data.containsKey(AmcaWords.costsAndExpenses)) {
      final costData =
          widget.data[AmcaWords.costsAndExpenses] as List<Map<String, dynamic>>;
      final existValues =
          costData.map((data) => data[AmcaWords.name]).cast<String>().toSet();
      if (existValues.length > 1) {
        return [optionSelectAll, ...existValues.toList()];
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final listOptionsSelect = _getListsOptionsSelect();
    return AlertDialog(
      title: const Text(AmcaWords.reportGenerate),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text(AmcaWords.basicData),
              value: _includeGeneralInfo,
              onChanged: (value) {
                setState(() {
                  _includeGeneralInfo = value!;
                });
              },
            ),
            if (widget.data.containsKey(AmcaWords.costsAndExpenses))
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                CheckboxListTile(
                  title: const Text(AmcaWords.costsAndExpenses),
                  value: _includeCosts,
                  onChanged: (value) {
                    setState(() {
                      _includeCosts = value!;
                    });
                  },
                ),
                if (_includeCosts && listOptionsSelect.isNotEmpty)
                  AmcaSelectFormField(
                    labelText: AmcaWords.productOrService.toUpperCase(),
                    textEditingController: _productOrServiceController,
                    enabled: _includeCosts,
                    options: listOptionsSelect,
                    validator: (optionSelected) {
                      if (optionSelected != null && optionSelected.isEmpty) {
                        return AmcaWords.pleaseSelectProductOrService;
                      }
                      return null;
                    },
                    optionSelected: (String optionSelected) {},
                  ),
              ]),
            if (widget.data.containsKey(AmcaWords.production) ||
                widget.data.containsKey(AmcaWords.productions))
              CheckboxListTile(
                title: const Text(AmcaWords.production),
                value: _includeProductions,
                onChanged: (value) {
                  setState(() {
                    _includeProductions = value!;
                  });
                },
              ),
            ListTile(
              title: const Text(AmcaWords.format),
              trailing: DropdownButton<String>(
                value: _selectedFormat,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedFormat = newValue!;
                  });
                },
                items:
                    _formats.keys.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(AmcaWords.cancel),
        ),
        TextButton(
          onPressed: () {
            _generateAndSaveReport(context);
            Navigator.of(context).pop();
          },
          child: const Text(AmcaWords.download),
        ),
      ],
    );
  }
}
