import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'package:movie_app/screens/search_screen.dart';
import 'package:movie_app/screens/settings_screen.dart';
import 'package:movie_app/screens/start_screen.dart';
import 'package:movie_app/screens/watchlist_screen.dart';
import 'package:movie_app/style/my_colors.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget activePage = const SearchScreen();

  @override
  Widget build(BuildContext context) {
    if (_selectedPageIndex == 0) {
      activePage = const StartScreen();
    }

    if (_selectedPageIndex == 1) {
      activePage = const SearchScreen();
    }

    if (_selectedPageIndex == 2) {
      activePage = const WatchlistScreen();
    }

    if (_selectedPageIndex == 3) {
      activePage = const SettingsScreen();
    }

    return Scaffold(
      backgroundColor: MyColors.darkBluishGrey,
      body: activePage,
      bottomNavigationBar: Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.fixed,
          enableFeedback: false,
          backgroundColor: MyColors.darkBluishGrey,
          selectedItemColor: MyColors.lightBlue,
          unselectedItemColor: MyColors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Symbols.home_rounded),
              activeIcon: Icon(Symbols.home_rounded, fill: 1),
              label: 'Start',
            ),
            BottomNavigationBarItem(
              icon: Icon(Symbols.search_rounded),
              activeIcon: Icon(Symbols.search_rounded, fill: 1),
              label: 'Suche',
            ),
            BottomNavigationBarItem(
              icon: Icon(Symbols.movie_rounded),
              activeIcon: Icon(Symbols.movie_rounded, fill: 1),
              label: 'Watchlist',
            ),
            BottomNavigationBarItem(
              icon: Icon(Symbols.settings_rounded),
              activeIcon: Icon(Symbols.settings_rounded, fill: 1),
              label: 'Einstellungen',
            ),
          ],
        ),
      ),
    );
  }
}
