/// {@category Features Poultry Laying}
/// Form to create or edit laying galpon records.
library;

import 'package:amca/domain/model/livestock/poultry_laying/laying_galpon.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/widgets/amca_date_picker_field.dart';
import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';

class LayingGalponFormPage extends StatefulWidget {
  const LayingGalponFormPage({super.key, this.initialGalpon});

  final LayingGalpon? initialGalpon;

  static MaterialPageRoute<LayingGalpon?> create({
    LayingGalpon? galpon,
  }) {
    return MaterialPageRoute<LayingGalpon?> (
      builder: (context) => LayingGalponFormPage(initialGalpon: galpon),
    );
  }

  @override
  State<LayingGalponFormPage> createState() => _LayingGalponFormPageState();
}

class _LayingGalponFormPageState extends State<LayingGalponFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _populationController;
  String? _startDate;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialGalpon?.name);
    _populationController = TextEditingController(
      text: widget.initialGalpon?.populationInitial.toString(),
    );
    if (widget.initialGalpon != null) {
      _startDate = widget.initialGalpon?.startDate.toIso8601String();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _populationController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final galpon = LayingGalpon(
      id: widget.initialGalpon?.id,
      name: _nameController.text.trim(),
      startDate: DateTime.parse(_startDate ?? DateTime.now().toIso8601String()),
      populationInitial: int.parse(_populationController.text.trim()),
      state: widget.initialGalpon?.state ?? LayingGalponState.active,
    );
    Navigator.pop(context, galpon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialGalpon == null
            ? AmcaWords.create
            : AmcaWords.editGalpon),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AmcaTextFormField(
                labelText: AmcaWords.layingGalpon,
                textEditingController: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AmcaWords.pleaseAddValidName;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AmcaDatePickerField(
                labelText: AmcaWords.startDate,
                initialDate: widget.initialGalpon?.startDate.toIso8601String(),
                onChanged: (value) => _startDate = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AmcaWords.pleaseSelectDate;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              AmcaTextFormField(
                labelText: AmcaWords.populationInitial,
                textInputType: TextInputType.number,
                textEditingController: _populationController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return AmcaWords.pleaseAddQuantity;
                  }
                  final number = int.tryParse(value.trim());
                  if (number == null || number <= 0) {
                    return AmcaWords.pleaseAddQuantity;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AmcaPalette.lightGreen,
                ),
                onPressed: _onSubmit,
                child: Text(
                  AmcaWords.saveGalpon,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
