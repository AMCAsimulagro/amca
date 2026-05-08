/// {@category Features Poultry Laying}
/// Form widget for daily records, split by sections.
library;

import 'package:amca/domain/model/livestock/poultry_laying/laying_daily_record.dart';
import 'dart:math' as math;

import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';

class LayingDailyRecordForm extends StatefulWidget {
  const LayingDailyRecordForm({
    super.key,
    required this.onSaved,
    required this.galponId,
    required this.recordDate,
    this.initialRecord,
  });

  final LayingDailyRecord? initialRecord;
  final ValueChanged<LayingDailyRecord> onSaved;
  final String galponId;
  final DateTime recordDate;

  @override
  State<LayingDailyRecordForm> createState() => _LayingDailyRecordFormState();
}

class _LayingDailyRecordFormState extends State<LayingDailyRecordForm> {
  late final TextEditingController _eggsAAA;
  late final TextEditingController _eggsAA;
  late final TextEditingController _eggsA;
  late final TextEditingController _eggsB;
  late final TextEditingController _eggsC;
  late final TextEditingController _broken;
  late final TextEditingController _dirty;
  late final TextEditingController _food;
  late final TextEditingController _mortality;

  @override
  void initState() {
    super.initState();
    final record = widget.initialRecord;
    _eggsAAA = TextEditingController(text: record?.eggsAAA.toString() ?? '0');
    _eggsAA = TextEditingController(text: record?.eggsAA.toString() ?? '0');
    _eggsA = TextEditingController(text: record?.eggsA.toString() ?? '0');
    _eggsB = TextEditingController(text: record?.eggsB.toString() ?? '0');
    _eggsC = TextEditingController(text: record?.eggsC.toString() ?? '0');
    _broken = TextEditingController(text: record?.brokenEggs.toString() ?? '0');
    _dirty = TextEditingController(text: record?.dirtyEggs.toString() ?? '0');
    _food = TextEditingController(text: record?.foodConsumedKg.toString() ?? '0');
    _mortality = TextEditingController(text: record?.mortality.toString() ?? '0');
  }

  @override
  void dispose() {
    _eggsAAA.dispose();
    _eggsAA.dispose();
    _eggsA.dispose();
    _eggsB.dispose();
    _eggsC.dispose();
    _broken.dispose();
    _dirty.dispose();
    _food.dispose();
    _mortality.dispose();
    super.dispose();
  }

  void _save() {
    final record = widget.initialRecord;
    final newRecord = (record == null
        ? LayingDailyRecord(
            id: null,
            galponId: widget.galponId,
            date: widget.recordDate,
          )
        : record.copyWith())
      ..eggsAAA = int.tryParse(_eggsAAA.text) ?? 0
      ..eggsAA = int.tryParse(_eggsAA.text) ?? 0
      ..eggsA = int.tryParse(_eggsA.text) ?? 0
      ..eggsB = int.tryParse(_eggsB.text) ?? 0
      ..eggsC = int.tryParse(_eggsC.text) ?? 0
      ..brokenEggs = int.tryParse(_broken.text) ?? 0
      ..dirtyEggs = int.tryParse(_dirty.text) ?? 0
      ..foodConsumedKg = double.tryParse(_food.text) ?? 0
      ..mortality = int.tryParse(_mortality.text) ?? 0;
    widget.onSaved(newRecord);
    if (widget.initialRecord == null) {
      _resetFields();
    }
  }

  Widget _buildNumberField(String label, TextEditingController controller,
      {String? suffix, Key? fieldKey}) {
    return AmcaTextFormField(
      key: fieldKey,
      labelText: label,
      textEditingController: controller,
      textInputType: TextInputType.number,
      prefixText: suffix ?? '',
    );
  }

  Widget _buildFieldWrap({
    required int columns,
    required double spacing,
    required List<Widget> children,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = math.max(
          (constraints.maxWidth - spacing * (columns - 1)) / columns,
          120,
        ).toDouble();
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: children
              .map((child) => SizedBox(width: width, child: child))
              .toList(),
        );
      },
    );
  }

  void _resetFields() {
    setState(() {
      _eggsAAA.text = '0';
      _eggsAA.text = '0';
      _eggsA.text = '0';
      _eggsB.text = '0';
      _eggsC.text = '0';
      _broken.text = '0';
      _dirty.text = '0';
      _food.text = '0';
      _mortality.text = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _sectionHeader(AmcaWords.layingProductionBlock, Icons.egg),
        const SizedBox(height: 8),
        _buildFieldWrap(columns: 3, spacing: 12, children: [
          _buildNumberField('AAA', _eggsAAA, fieldKey: const Key('aaa')),
          _buildNumberField('AA', _eggsAA, fieldKey: const Key('aa')),
          _buildNumberField('A', _eggsA, fieldKey: const Key('a')),
          _buildNumberField('B', _eggsB, fieldKey: const Key('b')),
          _buildNumberField('C', _eggsC, fieldKey: const Key('c')),
          _buildNumberField(AmcaWords.layingBrokenEggs, _broken,
              fieldKey: const Key('broken-production')),
        ]),
        const SizedBox(height: 16),
        _sectionHeader(AmcaWords.layingQualityBlock, Icons.shield),
        const SizedBox(height: 8),
        _buildFieldWrap(columns: 2, spacing: 12, children: [
          _buildNumberField(AmcaWords.layingBrokenEggs, _broken,
              fieldKey: const Key('broken-quality')),
          _buildNumberField(AmcaWords.layingDirtyEggs, _dirty,
              fieldKey: const Key('dirty-quality')),
        ]),
        const SizedBox(height: 16),
        _sectionHeader(AmcaWords.layingCostsBlock, Icons.monetization_on),
        const SizedBox(height: 8),
        _buildFieldWrap(columns: 2, spacing: 12, children: [
          _buildNumberField(AmcaWords.layingFoodConsumed, _food,
              suffix: 'Kg', fieldKey: const Key('food-consumed')),
          _buildNumberField(AmcaWords.layingDailyMortality, _mortality,
              fieldKey: const Key('daily-mortality')),
        ]),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AmcaPalette.lightGreen),
          onPressed: _save,
          child: Text(AmcaWords.layingRecordSave),
        ),
      ],
    );
  }

  Widget _sectionHeader(String label, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AmcaPalette.lightGreen),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
