/// {@category Menu allUser}
library;

// import 'package:amca/domain/model/amca_user.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_users/all_users_vm.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/user_profile/user_profile_page.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
// import 'package:amca/ui/utils/calls_with_dialog.dart';
// import 'package:amca/ui/utils/dialogs.dart';
// import 'package:amca/ui/utils/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllUsersPage extends StatelessWidget {
  static ChangeNotifierProvider<AllUsersVM> create({Key? key}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => AllUsersVM()..init(),
        child: AllUsersPage._(key: key),
      );

  const AllUsersPage._({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.allUsers),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<AllUsersVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (vm.amcaUsers.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await vm.init();
              },
              child: ListView.separated(
                itemCount: vm.amcaUsers.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  final user = vm.amcaUsers[index];
                  return ListTile(
                    title: Text(user.names),
                    subtitle: Text(
                      (user.isAdmin ?? false)
                          ? 'Es Administrador'
                          : 'Usuario de amca',
                      style: TextStyle(
                        color: (user.isAdmin ?? false)
                            ? AmcaPalette.lightGreen
                            : null,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<bool>(
                          builder: (BuildContext context) =>
                              UserProfilePage.create(
                            user: user,
                          ),
                        ),
                      ).then((value) async{
                        if(value != null){
                          await vm.init();
                        }
                      });
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
