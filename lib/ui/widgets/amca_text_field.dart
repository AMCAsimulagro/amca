/// {@category Widgets}
import 'package:amca/ui/widgets/amca_text_field_styles.dart';
import 'package:flutter/material.dart';

/// Un campo de texto personalizado para la aplicación Amca.
class AmcaTextField extends StatefulWidget {
  const AmcaTextField({
    super.key,
    this.labelText,
    this.textEditingController,
    this.obscureText = false,
  });

  /// Texto que se mostrará como etiqueta para el campo de texto.
  final String? labelText;

  /// Indica si el texto debe ser ocultado, útil para contraseñas u otros campos sensibles.
  final bool obscureText;

  /// Controlador para controlar el texto que se muestra en el campo de texto.
  final TextEditingController? textEditingController;

  @override
  State<AmcaTextField> createState() => _AmcaTextFieldState();
}

class _AmcaTextFieldState extends State<AmcaTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      decoration: AmcaTextFieldStyles.textFieldDecoration.copyWith(
        labelText: widget.labelText,
      ),
    );
  }
}
