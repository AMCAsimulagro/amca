import 'package:flutter/material.dart';

class AmcaBackButton extends StatelessWidget {
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
          Navigator.pop(context);
        },
      ),
    );
  }
}