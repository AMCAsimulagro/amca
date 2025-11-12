/// {@category Widgets}
/// This file contains the implementation of the `AmcaTextFormField` widget,
/// which is a custom extension of the `TextFormField` widget in Flutter.
///
/// `AmcaTextFormField` provides additional functionality and custom styles for text fields
/// in the Amca application.
///
library;

import 'package:amca/ui/widgets/amca_text_field_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A custom text field for the Amca application.
///
/// Provides additional functionality and custom styles for text fields.
///
///
/// Example of Use:
/// ```dart
/// AmcaTextFormField(
///   labelText: 'Nombre',
///   textEditingController: _nameController,
///   textInputType: TextInputType.text,
///   validator: (value) {
///     if (value.isEmpty) {
///       return 'Please enter your name';
///     }
///     return null;
///   },
/// ),
/// ```
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

  /// Label for the text field.
  final String? labelText;

  /// Indicates whether the text should be hidden.
  final bool obscureText;

  /// Indicates whether the text field is enabled.
  final bool? enabled;

  /// Indicates whether the text field is read-only.
  final bool readOnly;

  /// Controller for the text field.
  final TextEditingController? textEditingController;

  /// Validation function for the text field.
  final FormFieldValidator<String>? validator;

  /// Text input type.
  final TextInputType? textInputType;

  /// Maximum text length allowed.
  final int? maxLength;

  /// Function called when the text changes.
  final ValueChanged<String>? onChanged;

  /// List of text input formatters.
  final List<TextInputFormatter>? inputFormatters;

  /// Function called when the text field is pressed.
  final GestureTapCallback? onTap;

  /// Text displayed before the text field.
  final String? prefixText;

  @override
  State<AmcaTextFormField> createState() => _AmcaTextFormFieldState();
}

/// Status of the `AmcaTextFormField` widget.
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
