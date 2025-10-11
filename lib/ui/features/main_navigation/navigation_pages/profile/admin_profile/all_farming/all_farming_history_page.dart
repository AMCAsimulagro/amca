/// {@category Menu farming info}
library;

import 'package:amca/domain/model/livestock/animal_husbandry/meat/meat_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/animal_husbandry/milk/milk_animal_husbandry.dart';
import 'package:amca/domain/model/livestock/pig_farming/pig_farming.dart';
import 'package:amca/domain/model/permanent_farming.dart';
import 'package:amca/domain/model/transitory_farming.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_farming/all_farming_history_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../../widgets/amca_download_button.dart';

class AllFarmingHistoryPage extends StatelessWidget {
  static ChangeNotifierProvider<AllFarmingHistoryVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => AllFarmingHistoryVM()..init(),
        child: AllFarmingHistoryPage._(key: key),
      );

  const AllFarmingHistoryPage._({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.allFarms),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<AllFarmingHistoryVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Widget> farmingItems = [];

          if (vm.farmingHistory.isNotEmpty) {
            farmingItems.addAll(_buildFarmingList(
                context, vm.farmingHistory, AmcaWords.transitory));
          }

          if (vm.farmingHistoryPermanent.isNotEmpty) {
            farmingItems.addAll(_buildFarmingList(
                context, vm.farmingHistoryPermanent, AmcaWords.permanent));
          }

          if (vm.meatAnimalHusbandry.isNotEmpty) {
            farmingItems.addAll(_buildFarmingList(
                context, vm.meatAnimalHusbandry, AmcaWords.meat));
          }

          if (vm.milkAnimalHusbandry.isNotEmpty) {
            farmingItems.addAll(_buildFarmingList(
                context, vm.milkAnimalHusbandry, AmcaWords.milk));
          }

          if (vm.pigFarming.isNotEmpty) {
            farmingItems.addAll(_buildFarmingList(
                context, vm.pigFarming, AmcaWords.pigFarming));
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
            child: Text(AmcaWords.cropsHaveNotBeenCreatedYet),
          );
        },
      ),
    );
  }

  List<Widget> _buildFarmingList(
      BuildContext context, List<dynamic> farmingHistory, String type) {
    List<Widget> farmingList = [];

    for (var farmingItem in farmingHistory) {
      final name = switch (farmingItem) {
        MilkAnimalHusbandry() => farmingItem.farmName,
        MeatAnimalHusbandry() => farmingItem.farmName,
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
            showDialog(
              context: context,
              builder: (_) =>
                  AmcaDownloadButton(data: farmingItem!.toReportData()),
            );
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
