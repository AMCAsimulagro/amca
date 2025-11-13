import 'package:amca/ui/features/frequent_questions/frequent_questions_page.dart';
import 'package:amca/ui/features/login/login_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_area_productions/all_area_productions_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_farming/all_farming_history_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_farming_info/all_farming_info_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_users/all_users_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/fishes_admin/fishes_admin.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/profile_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/dialogs.dart';
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

  const ProfilePage._();

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
                if (vm.currentUser?.isAdmin ?? false) const _AdminOptions(),
                if (vm.currentUser?.isAdmin ?? false)
                  const Divider(
                    height: 1,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
                    bottom: 50,
                  ),
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
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 1,
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.question_mark_outlined,
                          color: Colors.black,
                        ),
                        title: const Text(
                          AmcaWords.frequentQuestions,
                        ),
                        onTap: () async {
                          NavigationHelper.push(
                            FrequentQuestionsPage.create(
                              isAdmin: vm.currentUser?.isAdmin ?? false,
                            ),
                            context,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text(
              AmcaWords.deleteAccount,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            onTap: () async {
              final vm = Provider.of<ProfileVM>(context, listen: false);

              Dialogs.showSuccessDialogWithOptions(context,
                  'Tu información personal sera eliminado permanentemente junto a tu acceso. ¿Estas seguro de eliminar tu cuenta?, ',
                  onTap: () async {
                Dialogs.showLoading(context);
                await vm.deleteAccount();
                NavigationHelper.pushAndRemoveUntil(
                  LoginPage.create(),
                  context,
                );
              });
            },
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

class _AdminOptions extends StatelessWidget {
  const _AdminOptions();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
          child: Text(
            '${AmcaWords.adminOptions}: ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        ListTile(
          leading: const Icon(
            Icons.list,
            color: Colors.black,
          ),
          title: const Text(
            AmcaWords.seeAllFarms,
          ),
          onTap: () async {
            NavigationHelper.push(
              AllFarmingHistoryPage.create(),
              context,
            );
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.people,
            color: Colors.black,
          ),
          title: const Text(
            AmcaWords.seeAllUsers,
          ),
          onTap: () async {
            NavigationHelper.push(
              AllUsersPage.create(),
              context,
            );
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.local_fire_department_sharp,
            color: Colors.black,
          ),
          title: const Text(
            AmcaWords.addInformation,
          ),
          onTap: () async {
            NavigationHelper.push(
              AllFarmingInfoPage.create(),
              context,
            );
          },
        ),
        ListTile(
          leading: const Icon(
            Icons.area_chart,
            color: Colors.black,
          ),
          title: const Text(
            "Tipos de pez",
          ),
          onTap: () async {
            NavigationHelper.push(
              FishesAdminPage.create(),
              context,
            );
          },
        )
        ,
        ListTile(
          leading: const Icon(
            Icons.analytics,
            color: Colors.black,
          ),
          title: const Text(
            'Reporte de área de producción por municipio',
          ),
          onTap: () async {
            NavigationHelper.push(
              AllAreaProductionsPage.create(
                ownerId: 'admin',
              ),
              context,
            );
          },
        )
      ],
    );
  }
}
