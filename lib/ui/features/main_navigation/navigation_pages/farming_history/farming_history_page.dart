/// {@category Menu Farmin}
import 'package:amca/ui/features/farming/create/manage_transitory_farming_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
                    Navigator.push(
                      context,
                      MaterialPageRoute<bool>(
                        builder: (BuildContext context) =>
                            ManageTransitoryFarming.create(
                          transitoryFarming: farmingItem,
                        ),
                      ),
                    ).then((value) async {
                      if (value != null && value) {
                        await vm.init();
                      }
                    });
                  },
                );
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
}
