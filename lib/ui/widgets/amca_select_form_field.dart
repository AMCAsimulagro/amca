/// {@category Widget}
import 'package:amca/ui/widgets/amca_text_field_styles.dart';
import 'package:flutter/material.dart';

/// Campo de formulario de selección con lista de opciones.
class AmcaSelectFormField extends StatefulWidget {
  /// Constructor para crear un nuevo AmcaSelectFormField.
  const AmcaSelectFormField({
    super.key,
    this.labelText,
    this.textEditingController,
    this.validator,
    this.options = const [],
    required this.optionSelected,
    this.enabled = true,
  });

  /// Etiqueta que se muestra en el campo de entrada.
  final String? labelText;

  /// Controlador de texto para controlar el contenido del campo de entrada.
  final TextEditingController? textEditingController;

  /// Validador que se ejecuta en el campo de entrada.
  final FormFieldValidator<String>? validator;

  /// Lista de opciones que se muestran en el diálogo de selección.
  final List<String> options;

  /// Función de devolución de llamada que se llama cuando se selecciona una opción.
  final Function(String optionSelected) optionSelected;

  /// Determina si el campo de entrada está habilitado o deshabilitado.
  final bool enabled;

  @override
  State<AmcaSelectFormField> createState() => _AmcaSelectFormFieldState();
}

class _AmcaSelectFormFieldState extends State<AmcaSelectFormField> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController =
        widget.textEditingController ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      readOnly: true,
      enabled: widget.enabled,
      onTap: _showOptionsDialog,
      decoration: AmcaTextFieldStyles.textFieldDecoration.copyWith(
        labelText: widget.labelText,
        suffixIcon: const Icon(Icons.arrow_drop_down_outlined),
      ),
      validator: widget.validator,
    );
  }

  /// Función para mostrar el diálogo de opciones.
  void _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Selecciona una opción'),
          children: widget.options
              .map(
                (option) => SimpleDialogOption(
                  child: Text(option),
                  onPressed: () {
                    setState(() {
                      widget.optionSelected(option);
                      _textEditingController.text = option;
                    });
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }
}
