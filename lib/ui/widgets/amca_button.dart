/// {@category Widgets}
///
/// This file contains the `AmcaButton` widget, which is a custom button
/// for the Amca application.
///
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:flutter/material.dart';

/// Enum representing the type of `AmcaButton`.
enum AmcaButtonType {
  /// Primary button type.
  primary,
  
  /// Destroy button type.
  destroy,
}

class AmcaButton extends StatelessWidget {
  const AmcaButton({
    super.key,
    this.text,
    this.onPressed,
    this.type = AmcaButtonType.primary,
  });

  /// Text displayed on the button.
  final String? text;

  /// Callback function called when the button is pressed.
  final VoidCallback? onPressed;

  /// Type of the button (primary or destroy).
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

  /// Returns the button style based on the button type.
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
