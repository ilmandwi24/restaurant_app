import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/screen/favorite/favorite_screen.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/settings/settings_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // todo-01-main-09: remove _indexBottomNavBar state
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // todo-01-main-08: use Consumer to build the screen
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            1 => const FavoriteScreen(),
            _ => const SettingsScreen(),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        // todo-01-main-07: grab the value using watch  provider
        currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
        onTap: (index) {
          // todo-01-main-06: change the set value using provider
          context.read<IndexNavProvider>().setIndextBottomNavBar = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            tooltip: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
            tooltip: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
            tooltip: "Settings",
          ),
        ],
      ),
    );
  }
}
