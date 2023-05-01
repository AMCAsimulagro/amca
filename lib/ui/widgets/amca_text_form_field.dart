import 'package:amca/ui/widgets/amca_text_field_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final String? labelText;
  final bool obscureText;
  final bool? enabled;
  final bool readOnly;
  final TextEditingController? textEditingController;
  final FormFieldValidator<String>? validator;
  final TextInputType? textInputType;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final GestureTapCallback? onTap;
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
