/// {@category Widget}

import 'package:flutter/material.dart';

/// Widget que muestra un botón de retroceso personalizado.
class AmcaBackButton extends StatelessWidget {
  /// Constructor para crear un nuevo AmcaBackButton.
  const AmcaBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 50,
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context); // Navega hacia atrás cuando se presiona el botón
        },
      ),
    );
  }
}