/// {@category Features Farming Type}
/// This file contains the implementation of the [FarmingTypePage] class, which presents options for different types
/// of farming activities: transitory and permanent. Users can navigate to the respective pages for managing each type
/// of farming activity by tapping on the buttons.
library;

import 'package:amca/ui/features/livestock/option/animal_husbandry/option_livestock_animal_husbandry_page.dart';
import 'package:amca/ui/features/livestock/option/poultry/option_livestock_poultry_page.dart';
import 'package:amca/ui/features/livestock/option/Fish/option_livestock_fish_type.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:amca/ui/widgets/amca_container_button.dart';
import 'package:amca/ui/features/livestock/create/pig_farming/manage_pig_farming_cost_and_expenses_page.dart';
import 'package:flutter/material.dart';

/// StatelessWidget for presenting options for different types of farming activities.
class LivestockTypePage extends StatelessWidget {
  /// Constructs a [LivestockTypePage] widget.
  const LivestockTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.livestockType),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  // Botón para Ganadería
                  Expanded(
                    child: AmcaContainerButton(
                      text: AmcaWords.animalHusbandry,
                      onTap: () {
                        NavigationHelper.push(
                          const OptionLivestockAnimalHusbrandryPage(),
                          context,
                        );
                      },
                    ),
                  ),
                  // Botón para Porcicultura
                  Expanded(
                    child: AmcaContainerButton(
                      text: AmcaWords.pigFarming,
                      onTap: () {
                        // Dialogs.showErrorDialogWithMessage(
                        //     context, AmcaWords.buildingThis);
                        Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            ManagePigFarmingCostAndExpenses.create(),
                      ),
                    );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  // Botón para Avicultura
                  Expanded(
                    child: AmcaContainerButton(
                      text: AmcaWords.poultry,
                      onTap: () {
                        NavigationHelper.push(
                          const OptionLivestockPoultryPage(),
                          context,
                        );
                      },
                    ),
                  ),
                  // Botón para Piscicultura
                  Expanded(
                    child: AmcaContainerButton(
                      text: AmcaWords.fishFarming,
                      onTap: () {
                        NavigationHelper.push(
                          const OptionLivestockFishType(),
                          context,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
