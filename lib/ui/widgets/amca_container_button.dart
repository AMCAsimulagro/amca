/// {@category Widgets}
///
/// This file contains the `AmcaContainerButton` widget, which is a custom container
/// button for the Amca application.
///

import 'package:amca/ui/utils/amca_palette.dart';
import 'package:flutter/material.dart';

/// Widget que representa un botón contenido Amca.
class AmcaContainerButton extends StatelessWidget {
  /// Constructor para crear un nuevo AmcaContainerButton.
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
      child: Container(
        margin: const EdgeInsets.all(8),
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: AmcaPalette.lightGreen,
            width: 1,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
