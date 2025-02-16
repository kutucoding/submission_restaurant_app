import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/src/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/src/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/src/screen/home/home_screen.dart';
import 'package:restaurant_app/src/screen/search/search_screen.dart';
import 'package:restaurant_app/src/screen/setting/setting_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(builder: (contex, value, child) {
        return switch (value.indexBottomNavBar) {
          3 => const SettingScreen(),
          2 => const FavoriteScreen(),
          1 => const SearchScreen(),
          _ => const HomeScreen(),
        };
      }),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
          onTap: (index) {
            context.read<IndexNavProvider>().setIndexBottomNavBar = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              tooltip: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: "Search", tooltip: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "Favorite",
                tooltip: "Favorite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Setting",
                tooltip: "Setting"),
          ]),
    );
  }
}
