import 'package:flutter/material.dart';

class CardOption extends StatelessWidget {
  const CardOption({
    super.key,
    required this.imagePath,
    required this.text,
    this.onTap,
  });

  final String imagePath;
  final String text;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            surfaceTintColor: Colors.white,
            color: Colors.white,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                image: AssetImage(imagePath),
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
