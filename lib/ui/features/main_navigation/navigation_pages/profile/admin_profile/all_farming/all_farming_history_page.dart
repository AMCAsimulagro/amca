/// {@category Menu farming info}
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_farming/all_farming_history_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
          if (vm.farmingHistory.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await vm.init();
              },
              child: ListView.separated(
                itemCount: vm.farmingHistory.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  final farmingItem = vm.farmingHistory[index];
                  return ListTile(
                    title: Text(farmingItem.partName ?? ''),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd').format(farmingItem.createDate),
                    ),
                    onTap: () {
                      /*Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              ManageTransitoryFarming.create(
                                transitoryFarming: farmingItem,
                              ),
                        ),
                      );*/
                    },
                  );
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
}
