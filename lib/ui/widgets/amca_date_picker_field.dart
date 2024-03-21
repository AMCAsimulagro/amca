/// {@category Widgets}
/// This file contains the `AmcaDatePickerField` widget, which is a custom date picker
/// form field for the Amca application.
///
///

import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Campo de entrada de fecha con selección de fecha.
class AmcaDatePickerField extends StatefulWidget {
  /// Constructor para crear un nuevo AmcaDatePickerField.
  const AmcaDatePickerField({
    super.key,
    this.onChanged,
    this.labelText,
    this.validator,
    this.initialDate,
  });

  /// Callback function called when the date changes.

  final ValueChanged<String>? onChanged;

  /// Label for the date picker form field.
  final String? labelText;
  /// Validation function for the date picker form field.
  final FormFieldValidator<String>? validator;

  /// Initial date for the date picker form field.

  final String? initialDate;

  @override
  State<AmcaDatePickerField> createState() => _AmcaDatePickerFieldState();
}
/// Status of the `AmcaDatePickerField` widget.
class _AmcaDatePickerFieldState extends State<AmcaDatePickerField> {
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void initState() {
    _dateController.text = widget.initialDate ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AmcaTextFormField(
      onTap: () {
        _selectDate(context);
      },
      textEditingController: _dateController,
      readOnly: true,
      labelText: widget.labelText,
      validator: widget.validator,
    );
  }
  /// Opens a date picker dialog to select a date.

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
        if (widget.onChanged != null) {
          widget.onChanged!(_dateController.text);
        }
      });
    }
  }
}
