/// {@category Widgets}
///
/// This file contains the definition of the `AmcaTextFormField` widget, which is an extension
/// custom Flutter `TextFormField` widget.
///
/// `AmcaTextFormField` provides additional functionality and custom styles
/// for text fields in the Amca application.
///
import 'package:amca/ui/widgets/amca_text_field_styles.dart';
import 'package:flutter/material.dart';

/// A custom text field for the Amca application.
///
/// Provides custom styles for text fields.
///

class AmcaTextField extends StatefulWidget {
  const AmcaTextField({
    super.key,
    this.labelText,
    this.textEditingController,
    this.obscureText = false,
  });

  /// Label for the text field.
  final String? labelText;

  /// Indicates whether the text should be hidden.
  final bool obscureText;

  /// Controller for the text field.

  final TextEditingController? textEditingController;

  @override
  State<AmcaTextField> createState() => _AmcaTextFieldState();
}

/// Status of the `AmcaTextField` widget.
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
