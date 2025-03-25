/// {@category Features Farming Option}
/// This file contains the implementation of the [OptionFarmingPage] class, which provides options for managing
/// transitory farming activities. It includes a button to create new transitory farming activities. Users can
/// navigate to the [ManageTransitoryFarming] page to create new transitory farming activities by tapping on the button.
library;

/// Imports of Bookstores and Resources
import 'package:amca/ui/features/farming/create/manage_transitory_farming_page.dart';
import 'package:amca/ui/features/livestock/option/poultry/eggs/option_livestock_poultry_eggs_page.dart';
import 'package:amca/ui/features/livestock/option/poultry/fatten/option_livestock_poultry_fatten_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:amca/ui/widgets/amca_container_button.dart';
import 'package:flutter/material.dart';

/// StatelessWidget for managing transitory farming activities.
class OptionLivestockPoultryPage extends StatelessWidget {
  /// Constructs an [OptionLivestockPoultryPage] widget.
  const OptionLivestockPoultryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.poultry),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              Expanded(
                child: AmcaContainerButton(
                  text: AmcaWords.eggs,
                  onTap: () {
                    NavigationHelper.push(
                      const OptionLivestockPoultryEggsPage(),
                      context,
                    );
                  },
                ),
              ),
              Expanded(
                child: AmcaContainerButton(
                  text: AmcaWords.fatten,
                  onTap: () {
                    NavigationHelper.push(
                      const OptionLivestockPoultryFattenPage(),
                      context,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
