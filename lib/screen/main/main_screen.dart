import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/search/search_screen.dart';
import 'package:restaurant_app/screen/setting/setting_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (contex, value, child) {
          return switch (value.indexBottomNavBar) {
            2 => const SettingScreen(),
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
            BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",),
            BottomNavigationBarItem(icon: Icon(Icons.search),
            label: "Search",
            tooltip: "Search"),
            BottomNavigationBarItem(icon: Icon(Icons.settings),
            label: "Setting",
            tooltip: "Setting")
          ]),
    );
  }
}