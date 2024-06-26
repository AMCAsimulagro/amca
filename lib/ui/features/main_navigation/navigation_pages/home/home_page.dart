/// {@category Menu Home}

import 'package:amca/ui/features/farming/type/farming_type_page.dart';
import 'package:amca/ui/features/farming/widgets/card_option.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/assets.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: CardOption(
                imagePath: Assets.agricola,
                text: AmcaWords.agricultural,
                onTap: () {
                  NavigationHelper.push(
                    const FarmingTypePage(),
                    context,
                  );
                },
              ),
            ),
            const Expanded(
              child: CardOption(
                imagePath: Assets.pecuaria,
                text: AmcaWords.livestock,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
