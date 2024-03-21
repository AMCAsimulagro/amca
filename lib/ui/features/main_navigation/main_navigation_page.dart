import 'package:amca/ui/features/main_navigation/main_navigation_vm.dart';
import 'package:amca/ui/features/main_navigation/models/navigation_selection.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/home/home_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/profile_page.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();

}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late List<Widget> _pages;
  String? pageTitle;

  final List<NavigationDestination> _items = [
    const NavigationDestination(
      icon: Icon(Icons.home),
      label: AmcaWords.home,
    ),
    const NavigationDestination(
      icon: Icon(Icons.agriculture_outlined),
      label: AmcaWords.farming,
    ),
    const NavigationDestination(
      icon: Icon(Icons.manage_accounts_rounded),
      label: AmcaWords.profile,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pages = [
      const HomePage(),
      const FarmingHistoryPage(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MainNavigationVM>();
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle ?? AmcaWords.typesOfproduction),
      ),
      body: IndexedStack(
        index: vm.currentPage,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: _items,
        selectedIndex: vm.currentPage,
        onDestinationSelected: (index) {
          setState(
            () {
              if (_pages[index] is SizedBox) {
                _pages[index] = pagesToBuild[index]!.page;
              }
              vm.currentPage = index;
              pageTitle = pagesToBuild[index]!.title;
            },
          );
        },
      ),
    );
  }

  final Map<int, NavigationOption> pagesToBuild = {
    0: NavigationOption(
      page: const HomePage(),
      title: AmcaWords.typesOfproduction,
    ),
    1: NavigationOption(
      page: const FarmingHistoryPage(),
      title: AmcaWords.myFarming,
    ),
    2: NavigationOption(
      page: ProfilePage.create(),
      title: AmcaWords.profile,
    ),
  };
}
