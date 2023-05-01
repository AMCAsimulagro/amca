import 'package:amca/ui/widgets/amca_text_field_styles.dart';
import 'package:flutter/material.dart';

class AmcaTextField extends StatefulWidget {
  const AmcaTextField({
    super.key,
    this.labelText,
    this.textEditingController,
    this.obscureText = false,
  });

  final String? labelText;
  final bool obscureText;
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
