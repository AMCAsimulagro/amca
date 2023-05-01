import 'package:amca/ui/utils/amca_palette.dart';
import 'package:flutter/material.dart';


enum AmcaButtonType{
  primary,
  destroy,
}

class AmcaButton extends StatelessWidget {
  const AmcaButton({
    super.key,
    this.text,
    this.onPressed,
    this.type = AmcaButtonType.primary,
  });

  final String? text;
  final VoidCallback? onPressed;
  final AmcaButtonType type;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(),
      child: Text(
        text ?? '',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  ButtonStyle? _getButtonStyle(){
    final styles = {
      AmcaButtonType.primary: ElevatedButton.styleFrom(
        backgroundColor: AmcaPalette.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      AmcaButtonType.destroy : ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    };
    return styles[type];
  }
}
