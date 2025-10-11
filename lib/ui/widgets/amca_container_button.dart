/// {@category Widgets}
///
/// This file contains the `AmcaContainerButton` widget, which is a custom container
/// button for the Amca application.
///
library;
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:flutter/material.dart';

class AmcaContainerButton extends StatelessWidget {
  const AmcaContainerButton({
    super.key,
    required this.text,
    this.onTap,
  });

  /// Text displayed on the button.
  final String text;

  /// Callback function called when the button is tapped.
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(8),
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green, // Cambia el color de fondo a verde
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white, // Cambia el color del texto a blanco
              fontSize: 24, // Ajusta el tamaño de la fuente según lo desees
              fontWeight:
                  FontWeight.bold, // Opcional: ajusta el peso de la fuente
            ),
          ),
        ),
      ),
    );
  }
}
