import 'package:amca/domain/model/amca_user.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_users/all_users_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
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
                    title: Text(user.names ?? ''),
                    subtitle: Text(
                        (user.isAdmin ?? false)
                            ? 'Es Administrador'
                            : 'Usuario de amca',
                        style: TextStyle(
                          color: (user.isAdmin ?? false)
                              ? AmcaPalette.lightGreen
                              : null,
                        )),
                    onTap: () async {
                      await showOptionDialog(user, context);
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

  Future<void> showOptionDialog(AmcaUser user, BuildContext context) async {
    final getMessage = (user.isAdmin ?? false)
        ? '¿Desear quitarle los permisos de admin al usuario ${user.names}?'
        : '¿Desear convertir al usuario ${user.names} en admin?';
    await Dialogs.showSuccessDialogWithOptions(
        context, getMessage, onTap: () async {
      await manageAdminUser(user, context);
    });
  }

  Future<void> manageAdminUser(AmcaUser user, BuildContext context) async {
    final manageVM = Provider.of<AllUsersVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await manageVM.manageAdminUser(user);
        await Dialogs.showSuccessDialogWithMessage(
            context, AmcaWords.theUserHasBeenUpdated);
        await manageVM.init();
      });
    } catch (_) {}
  }
}
