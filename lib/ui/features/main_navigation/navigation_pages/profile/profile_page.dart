import 'package:amca/ui/features/login/login_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_farming_history_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/profile_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static ChangeNotifierProvider<ProfileVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => ProfileVM()..init(),
        child: const ProfilePage._(),
      );

  const ProfilePage._({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileVM>(builder: (context, vm, _) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  '${AmcaWords.welcome} ${vm.currentUser?.names ?? ' '}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (vm.currentUser?.isAdmin ?? false)
                  Text(
                    AmcaWords.youAreAdmin,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              children: [
                if (vm.currentUser?.isAdmin ?? false)
                  ListTile(
                    leading: const Icon(
                      Icons.list,
                      color: Colors.black,
                    ),
                    title: const Text(
                      AmcaWords.seeAllFarms,
                    ),
                    onTap: () async {
                      final vm = Provider.of<ProfileVM>(context, listen: false);
                      vm.signOut().then((value) {
                        NavigationHelper.push(
                          AllFarmingHistoryPage.create(),
                          context,
                        );
                      });
                    },
                  ),
                if(vm.currentUser?.isAdmin ?? false)
                  const Divider(
                    height: 1,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${AmcaWords.yourInformation}: ',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '${AmcaWords.identifier}:',
                      ),
                      Text(
                        vm.currentUser?.identification ?? '',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '${AmcaWords.email}:',
                      ),
                      Text(
                        vm.currentUser?.email ?? '',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '${AmcaWords.state}:',
                      ),
                      Text(
                        vm.currentUser?.state ?? '',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '${AmcaWords.town}:',
                      ),
                      Text(
                        vm.currentUser?.town ?? '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: AmcaPalette.lightGreen,
            ),
            title: const Text(
              AmcaWords.logOut,
              style: TextStyle(
                color: AmcaPalette.lightGreen,
              ),
            ),
            onTap: () async {
              final vm = Provider.of<ProfileVM>(context, listen: false);
              vm.signOut().then((value) {
                NavigationHelper.pushAndRemoveUntil(
                  LoginPage.create(),
                  context,
                );
              });
            },
          )
        ],
      );
    });
  }
}
