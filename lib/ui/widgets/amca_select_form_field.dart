import 'package:amca/ui/widgets/amca_text_field_styles.dart';
import 'package:flutter/material.dart';

class AmcaSelectFormField extends StatefulWidget {
  const AmcaSelectFormField({
    super.key,
    this.labelText,
    this.textEditingController,
    this.validator,
    this.options = const [],
    required this.optionSelected,
    this.enabled = true,
  });

  final String? labelText;
  final TextEditingController? textEditingController;
  final FormFieldValidator<String>? validator;
  final List<String> options;
  final Function(String optionSelected) optionSelected;
  final bool enabled;

  @override
  State<AmcaSelectFormField> createState() => _AmcaSelectFormFieldState();
}

class _AmcaSelectFormFieldState extends State<AmcaSelectFormField> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController =
        widget.textEditingController ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _textEditingController,
      readOnly: true,
      enabled: widget.enabled,
      onTap: _showOptionsDialog,
      decoration: AmcaTextFieldStyles.textFieldDecoration.copyWith(
        labelText: widget.labelText,
        suffixIcon: const Icon(Icons.arrow_drop_down_outlined),
      ),
      validator: widget.validator,
    );
  }

  void _showOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Selecciona una opción'),
          children: widget.options
              .map(
                (option) => SimpleDialogOption(
                  child: Text(option),
                  onPressed: () {
                    setState(() {
                      widget.optionSelected(option);
                      _textEditingController.text = option;
                    });
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        );
      },
    );
  }
}
