/// {@category Widget}
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:flutter/material.dart';

/// Enumeración que define los tipos de botón Amca.
enum AmcaButtonType {
  /// Tipo de botón primario.
  primary,

  /// Tipo de botón de destrucción.
  destroy,
}

/// Widget personalizado que representa un botón Amca.
class AmcaButton extends StatelessWidget {
  /// Constructor para crear un nuevo AmcaButton.
  const AmcaButton({
    super.key,
    this.text,
    this.onPressed,
    this.type = AmcaButtonType.primary,
  });

  /// Texto que se muestra en el botón.
  final String? text;

  /// Función de devolución de llamada que se ejecuta cuando se presiona el botón.
  final VoidCallback? onPressed;

  /// Tipo de botón Amca.
  final AmcaButtonType type;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          text ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  /// Obtiene el estilo del botón según el tipo especificado.
  ButtonStyle? _getButtonStyle() {
    final styles = {
      AmcaButtonType.primary: ElevatedButton.styleFrom(
        backgroundColor: AmcaPalette.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      AmcaButtonType.destroy: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    };
    return styles[type];
  }
}
