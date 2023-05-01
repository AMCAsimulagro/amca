import 'package:amca/ui/features/login/login_page.dart';
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
        create: (context) => ProfileVM(),
        child: const ProfilePage._(),
      );

  const ProfilePage._({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Expanded(
          child: Center(
            child: Text(AmcaWords.profile),
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
            final vm = Provider.of<ProfileVM>(context,listen: false);
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
  }
}
