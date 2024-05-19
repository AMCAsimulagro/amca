/// {@category Menu Farmin}
import 'package:amca/ui/features/farming/create/manage_transitory_farming_page.dart';
import 'package:amca/ui/features/farming/create/manage_permanent_farming_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_vm.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:amca/ui/utils/amca_palette.dart';

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

  // @override
  // Widget build(BuildContext context) {
  //   return Consumer<FarmingHistoryVM>(
  //     builder: (context, vm, _) {
  //       if (vm.isLoading) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }

  //       List<Widget> farmingItems = [];

  //       if (vm.farmingHistory.isNotEmpty) {
  //         farmingItems.addAll(
  //           _buildFarmingList(
  //             vm.farmingHistory,
  //             (farmingItem) => ManageTransitoryFarming.create(
  //               transitoryFarming: farmingItem,
  //             ),
  //             'Transitorio', // Agrega un título para esta sección
  //           ),
  //         );
  //       }

  //       if (vm.farmingHistoryPermanent.isNotEmpty) {
  //         farmingItems.addAll(
  //           _buildFarmingList(
  //             vm.farmingHistoryPermanent,
  //             (farmingItem) => ManagePermanentFarming.create(
  //               permanentFarming: farmingItem,
  //             ),
  //             'Permanente', // Agrega un título para esta sección
  //           ),
  //         );
  //       }

  //       if (farmingItems.isNotEmpty) {
  //         return RefreshIndicator(
  //           onRefresh: () async {
  //             await vm.init();
  //           },
  //           child: ListView.separated(
  //             itemCount: farmingItems.length,
  //             separatorBuilder: (BuildContext context, int index) {
  //               return const Divider();
  //             },
  //             itemBuilder: (BuildContext context, int index) {
  //               return farmingItems[index];
  //             },
  //           ),
  //         );
  //       }

  //       return const Center(
  //         child: Text(AmcaWords.youHaveNotCreatedFarmingYet),
  //       );
  //     },
  //   );
  // }

  // List<Widget> _buildFarmingList(List<dynamic> farmingHistory,
  //     Widget Function(dynamic) builder, String title) {
  //   List<Widget> farmingList = [];

  //   // Agrega un ListTile especial como encabezado para la sección
  //   farmingList.add(
  //     ListTile(
  //       title: Text(
  //         title,
  //         style: TextStyle(
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );

  //   // Agrega los elementos de la lista
  //   farmingHistory.forEach((farmingItem) {
  //     farmingList.add(
  //       ListTile(
  //         title: Text(farmingItem.partName ?? ''),
  //         subtitle: Text(
  //           DateFormat('yyyy-MM-dd').format(farmingItem.createDate),
  //         ),
  //         onTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute<bool>(
  //               builder: (BuildContext context) => builder(farmingItem),
  //             ),
  //           ).then((value) async {
  //             if (value != null && value) {
  //               await Provider.of<FarmingHistoryVM>(context, listen: false)
  //                   .init();
  //             }
  //           });
  //         },
  //       ),
  //     );
  //   });

  //   return farmingList;
  // }

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
              'Transitorio', // Agrega un identificador para esta sección
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
              'Permanente', // Agrega un identificador para esta sección
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

    farmingHistory.forEach((farmingItem) {
      farmingList.add(
        ListTile(
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      farmingItem.partName ?? '',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(farmingItem.createDate),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  color: type == 'Transitorio' ? AmcaPalette.TransitoryColor : AmcaPalette.permanentColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  type,
                  style: TextStyle(
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
    });

    return farmingList;
  }
}
