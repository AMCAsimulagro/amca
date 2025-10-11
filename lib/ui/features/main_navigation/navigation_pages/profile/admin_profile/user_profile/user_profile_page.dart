/// {@category Menu userProfile}
library;
import 'package:amca/domain/model/amca_user.dart';
// import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/all_users/all_users_vm.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/admin_profile/user_profile/user_profile_vm.dart';
import 'package:amca/ui/utils/amca_palette.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:amca/ui/utils/calls_with_dialog.dart';
import 'package:amca/ui/utils/dialogs.dart';
import 'package:amca/ui/widgets/amca_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  static ChangeNotifierProvider<UserProfileVM> create(
          {Key? key, required AmcaUser user}) =>
      ChangeNotifierProvider(
        lazy: false,
        create: (context) => UserProfileVM()..init(user),
        child: UserProfilePage._(key: key),
      );

  const UserProfilePage._({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AmcaWords.userInfo),
        backgroundColor: AmcaPalette.lightGreen,
      ),
      body: Consumer<UserProfileVM>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (vm.userSelected != null) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  '${AmcaWords.name}:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  '${vm.userSelected?.names} ${vm.userSelected?.firstLastName} ${vm.userSelected?.secondLastName}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${AmcaWords.state}:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  vm.userSelected?.state ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${AmcaWords.town}:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  ' ${vm.userSelected?.town ?? ''}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${AmcaWords.email}:',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  vm.userSelected?.email ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  (vm.userSelected?.isAdmin ?? false)
                      ? 'Es Administrador'
                      : 'Usuario de amca - No es administrador',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: (vm.userSelected?.isAdmin ?? false)
                            ? AmcaPalette.lightGreen
                            : null,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AmcaButton(
                  text: (vm.userSelected?.isAdmin ?? false)
                      ? 'Remover administador'
                      : 'Convertir en administador',
                  onPressed: () {
                    showOptionDialog(vm.userSelected!, context);
                  },
                ),
              ],
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
    await Dialogs.showSuccessDialogWithOptions(context, getMessage,
        onTap: () async {
      await manageAdminUser(user, context);
    });
  }

  Future<void> manageAdminUser(AmcaUser user, BuildContext context) async {
    final userProfileVm = Provider.of<UserProfileVM>(
      context,
      listen: false,
    );
    try {
      await CallsWithDialogs.call(context, () async {
        await userProfileVm.manageAdminUser(user);
        await Dialogs.showSuccessDialogWithMessage(
            context, AmcaWords.theUserHasBeenUpdated);
      }).then((value) => Navigator.pop(context,true));
    } catch (_) {}
  }
}
