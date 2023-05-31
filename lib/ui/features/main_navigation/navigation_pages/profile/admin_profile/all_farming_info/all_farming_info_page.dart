import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_farming_info/all_farming_info_vm.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_farming_info/farming_info_detail/manage_farming_info_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllFarmingInfoPage extends StatelessWidget {
  static ChangeNotifierProvider<AllFarmingInfoVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => AllFarmingInfoVM()..init(),
        child: AllFarmingInfoPage._(key: key),
      );

  const AllFarmingInfoPage._({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.cropTypes),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<AllFarmingInfoVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (vm.farmingInfo.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await vm.init();
              },
              child: ListView.separated(
                itemCount: vm.farmingInfo.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  final farmingInfo = vm.farmingInfo[index];
                  return ListTile(
                    title: Text(farmingInfo.tipo ?? ''),
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ManageFarmingInfoPage.create(
                            cropType: farmingInfo,
                            allCropTypes: vm.farmingInfo,
                          ),
                        ),
                      ).then(
                        (value) async {
                          if (value != null && (value as bool)) {
                            await vm.init();
                          }
                        },
                      );
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: AmcaWords.addCropType,
        onPressed: () {
          final allFarmingInfoVM = Provider.of<AllFarmingInfoVM>(
            context,
            listen: false,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ManageFarmingInfoPage.create(
                allCropTypes: allFarmingInfoVM.farmingInfo,
              ),
            ),
          ).then(
            (value) async {
              if (value != null && (value as bool)) {
                await allFarmingInfoVM.init();
              }
            },
          );
        },
        backgroundColor: AmcaPalette.lightGreen,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
