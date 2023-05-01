import 'package:amca/ui/utils/amca_palette.dart';
import 'package:flutter/material.dart';

class AmcaContainerButton extends StatelessWidget {
  const AmcaContainerButton({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
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
