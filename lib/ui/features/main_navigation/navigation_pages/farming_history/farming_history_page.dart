/// {@category Menu Farmin}
library;

import 'package:amca/ui/features/farming/create/manage_permanent_farming_page.dart';
import 'package:amca/ui/features/farming/create/manage_transitory_farming_page.dart';
import 'package:amca/ui/features/livestock/create/animal_husbandry/meet/manage_meet_animal_husbandry_page.dart';
import 'package:amca/ui/features/livestock/create/animal_husbandry/milk/manage_milk_animal_husbandry_page.dart';
import 'package:amca/ui/features/livestock/create/pig_farming/manage_pig_farming_cost_and_expenses_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/model/livestock/animal_husbandry/meet/meet_animal_husbandry.dart';
import '../../../../../domain/model/livestock/animal_husbandry/milk/milk_animal_husbandry.dart';
import '../../../../../domain/model/livestock/pig_farming/pig_farming.dart';
import '../../../../../domain/model/permanent_farming.dart';
import '../../../../../domain/model/transitory_farming.dart';

/// ## FarmingHistoryPage widget
class FarmingHistoryPage extends StatefulWidget {
  const FarmingHistoryPage({
    super.key,
  });

  @override
  State<FarmingHistoryPage> createState() => _FarmingHistoryPageState();
}

class _FarmingHistoryPageState extends State<FarmingHistoryPage> {
  @override
  void initState() {
    Provider.of<FarmingHistoryVM>(
      context,
      listen: false,
    ).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FarmingHistoryVM>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Widget> farmingItems = [];

        if (vm.farmingHistory.isNotEmpty) {
          farmingItems.addAll(
            _buildFarmingList(
              vm.farmingHistory,
              (farmingItem) => ManageTransitoryFarming.create(
                transitoryFarming: farmingItem,
              ),
              AmcaWords.transitory, // Agrega un identificador para esta sección
            ),
          );
        }

        if (vm.farmingHistoryPermanent.isNotEmpty) {
          farmingItems.addAll(
            _buildFarmingList(
              vm.farmingHistoryPermanent,
              (farmingItem) => ManagePermanentFarming.create(
                permanentFarming: farmingItem,
              ),
              AmcaWords.permanent, // Agrega un identificador para esta sección
            ),
          );
        }

        if (vm.meetAnimalHusbandry.isNotEmpty) {
          farmingItems.addAll(
            _buildFarmingList(
              vm.meetAnimalHusbandry,
              (farmingItem) => ManageMeetAnimalHusbandry.create(
                animalHusbandry: farmingItem,
              ),
              AmcaWords.meat, // Agrega un identificador para esta sección
            ),
          );
        }

        if (vm.milkAnimalHusbandry.isNotEmpty) {
          farmingItems.addAll(
            _buildFarmingList(
              vm.milkAnimalHusbandry,
              (farmingItem) => ManageMilkAnimalHusbandry.create(
                animalHusbandry: farmingItem,
              ),
              AmcaWords.milk, // Agrega un identificador para esta sección
            ),
          );
        }

        if (vm.pigFarming.isNotEmpty) {
          farmingItems.addAll(
            _buildFarmingList(
              vm.pigFarming,
              (farmingItem) => ManagePigFarmingCostAndExpenses.create(
                pigFarming: farmingItem,
              ),
              AmcaWords.pigFarming, // Agrega un identificador para esta sección
            ),
          );
        }

        if (farmingItems.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              await vm.init();
            },
            child: ListView.separated(
              itemCount: farmingItems.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return farmingItems[index];
              },
            ),
          );
        }

        return const Center(
          child: Text(AmcaWords.youHaveNotCreatedFarmingYet),
        );
      },
    );
  }

  List<Widget> _buildFarmingList(List<dynamic> farmingHistory,
      Widget Function(dynamic) builder, String type) {
    List<Widget> farmingList = [];

    for (var farmingItem in farmingHistory) {
      final name = switch (farmingItem) {
        MilkAnimalHusbandry() => farmingItem.farmName,
        MeetAnimalHusbandry() => farmingItem.farmName,
        TransitoryFarming() => farmingItem.partName,
        PermanentFarming() => farmingItem.partName,
        PigFarming() => farmingItem.farmName,
        _ => '',
      };

      farmingList.add(
        ListTile(
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(farmingItem.createDate),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: getLightBrown(type),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<bool>(
                builder: (BuildContext context) => builder(farmingItem),
              ),
            ).then((value) async {
              if (value != null && value) {
                await Provider.of<FarmingHistoryVM>(context, listen: false)
                    .init();
              }
            });
          },
        ),
      );
    }

    return farmingList;
  }

  Color getLightBrown(String shade) {
    return switch (shade) {
      AmcaWords.transitory => AmcaPalette.transitoryColor,
      AmcaWords.permanent => AmcaPalette.permanentColor,
      AmcaWords.meat => AmcaPalette.meat,
      AmcaWords.milk => AmcaPalette.milk,
      AmcaWords.pigFarming => AmcaPalette.pigFarmingColor,
      _ => const Color.fromARGB(255, 210, 180, 140), // Default: Café claro
    };
  }
}
