import 'package:amca/ui/widgets/amca_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AmcaDatePickerField extends StatefulWidget {
  const AmcaDatePickerField({
    super.key,
    this.onChanged,
    this.labelText,
    this.validator,
    this.initialDate,
  });

  final ValueChanged<String>? onChanged;
  final String? labelText;
  final FormFieldValidator<String>? validator;
  final String? initialDate;

  @override
  State<AmcaDatePickerField> createState() => _AmcaDatePickerFieldState();
}

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
