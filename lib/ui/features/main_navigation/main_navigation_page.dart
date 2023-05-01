import 'package:amca/ui/features/main_navigation/models/navigation_selection.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/farming_history/farming_history_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/home/home_page.dart';
import 'package:amca/ui/features/main_navigation/navigation_pages/profile/profile_page.dart';
import 'package:amca/ui/utils/amca_words.dart';
import 'package:flutter/material.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({Key? key}) : super(key: key);

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late List<Widget> _pages;
  late int _selectedPage;
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
    _selectedPage = 0;

    _pages = [
      const HomePage(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
      const SizedBox.shrink(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle ?? AmcaWords.typeOfExploitation),
      ),
      body: IndexedStack(
        index: _selectedPage,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        destinations: _items,
        selectedIndex: _selectedPage,
        onDestinationSelected: (index) {
          setState(
            () {
              if (_pages[index] is SizedBox) {
                _pages[index] = pagesToBuild[index]!.page;
              }
              _selectedPage = index;
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
      title: AmcaWords.typeOfExploitation,
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
