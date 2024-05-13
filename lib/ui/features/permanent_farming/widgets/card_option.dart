/// {@category Features Farming Widgets}
/// This file contains the implementation of the [CardOption] class, which represents a card with an image and text.
/// Users can tap on the card to perform a specific action defined by the [onTap] callback.

/// Imports of Bookstores and Resources
import 'package:flutter/material.dart';

/// StatelessWidget representing a card with an image and text.
class CardOption extends StatelessWidget {

  /// Constructs a [CardOption] widget.
  const CardOption({
    super.key,
    required this.imagePath,
    required this.text,
    this.onTap,
  });

  final String imagePath;/// Path to the image asset.
  final String text; /// Text displayed below the image.
  final GestureTapCallback? onTap;/// Callback function invoked when the card is tapped.

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
