/// {@category Features Farming Option}
/// This file contains the implementation of the [OptionFarmingPage] class, which provides options for managing
/// transitory farming activities. It includes a button to create new transitory farming activities. Users can
/// navigate to the [ManageTransitoryFarming] page to create new transitory farming activities by tapping on the button.
library;

/// Imports of Bookstores and Resources
import 'package:amca/ui/features/farming/create/manage_transitory_farming_page.dart';
import 'package:amca/ui/features/livestock/option/animal_husbandry/meat/option_livestock_animal_husbandry_meat_page.dart';
import 'package:amca/ui/features/livestock/option/animal_husbandry/milk/option_livestock_animal_husbrandry_milk_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:amca/ui/widgets/amca_container_button.dart';
import 'package:flutter/material.dart';

/// StatelessWidget for managing transitory farming activities.
class OptionLivestockAnimalHusbrandryPage extends StatelessWidget {

   /// Constructs an [OptionLivestockAnimalHusbrandryPage] widget.
  const OptionLivestockAnimalHusbrandryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.animalHusbandry),
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
                  text: AmcaWords.meat,
                  onTap: () {
                    NavigationHelper.push(const OptionLivestockAnimalHusbandryMeatPage(), context,);
                  },
                ),
              ),
              Expanded(
                child: AmcaContainerButton(
                  text: AmcaWords.milk,
                  onTap: () {
                    NavigationHelper.push(const OptionLivestockAnimalHusbrandryMilkPage(), context,);
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
