/// {@category Widget}
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

  /// Función de devolución de llamada que se llama cuando cambia la fecha seleccionada.
  final ValueChanged<String>? onChanged;

  /// Etiqueta que se muestra en el campo de entrada.
  final String? labelText;

  /// Validador que se ejecuta en el campo de entrada.
  final FormFieldValidator<String>? validator;

  /// Fecha inicial que se muestra en el campo de entrada.
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

  /// Función para mostrar un selector de fecha.
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
