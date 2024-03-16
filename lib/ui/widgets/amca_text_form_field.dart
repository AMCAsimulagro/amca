/// {@category Widgets}
import 'package:amca/ui/widgets/amca_text_field_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Un campo de formulario de texto personalizado para la aplicación Amca.
class AmcaTextFormField extends StatefulWidget {
  const AmcaTextFormField({
    super.key,
    this.labelText,
    this.textEditingController,
    this.obscureText = false,
    this.validator,
    this.textInputType,
    this.maxLength = 30,
    this.onChanged,
    this.inputFormatters,
    this.enabled,
    this.onTap,
    this.readOnly = false,
    this.prefixText,
  });

  /// Texto que se mostrará como etiqueta para el campo de formulario de texto.
  final String? labelText;

  /// Indica si el texto debe ser ocultado, útil para contraseñas u otros campos sensibles.
  final bool obscureText;

  /// Indica si el campo de formulario de texto está habilitado para interacción del usuario.
  final bool? enabled;

  /// Indica si el campo de formulario de texto es de solo lectura.
  final bool readOnly;

  /// Controlador para controlar el texto que se muestra en el campo de formulario de texto.
  final TextEditingController? textEditingController;

  /// Validador que se ejecutará para validar el contenido del campo de formulario de texto.
  final FormFieldValidator<String>? validator;

  /// Tipo de entrada del teclado que se utilizará para el campo de formulario de texto.
  final TextInputType? textInputType;

  /// Longitud máxima permitida para el texto ingresado en el campo de formulario de texto.
  final int? maxLength;

  /// Callback que se llama cuando el contenido del campo de formulario de texto cambia.
  final ValueChanged<String>? onChanged;

  /// Lista de formateadores de entrada que se aplicarán al texto ingresado en el campo de formulario de texto.
  final List<TextInputFormatter>? inputFormatters;

  /// Callback que se llama cuando se toca el campo de formulario de texto.
  final GestureTapCallback? onTap;

  /// Texto que se mostrará como prefijo dentro del campo de formulario de texto.
  final String? prefixText;

  @override
  State<AmcaTextFormField> createState() => _AmcaTextFormFieldState();
}

class _AmcaTextFormFieldState extends State<AmcaTextFormField> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController =
        widget.textEditingController ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      obscureText: widget.obscureText,
      maxLength: widget.maxLength,
      decoration: AmcaTextFieldStyles.textFieldDecoration.copyWith(
        labelText: widget.labelText,
        counterText: '',
        prefixText: widget.prefixText,
      ),
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      keyboardType: widget.textInputType,
      inputFormatters: widget.inputFormatters,
      validator: widget.validator,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
    );
  }
}
