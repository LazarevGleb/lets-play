import 'package:flutter/material.dart';

class LetsPlayNavigation {
  static const int mapIndex = 0;
  static const int menuIndex = 1;

  static const String mapRoute = "/map";
  static const String menuRoute = "/menu";

  static const Map<int, String> navigationMap = {
    mapIndex: mapRoute,
    menuIndex: menuRoute,
  };

  static BottomNavigationBar of(int navIndex, BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            label: "Карта", icon: Icon(Icons.accessibility_sharp)),
        BottomNavigationBarItem(
            label: "Меню", icon: Icon(Icons.account_tree_outlined)),
      ],
      currentIndex: navIndex,
      selectedItemColor: Colors.blueGrey,
      onTap: (index) {
        if (index == navIndex || !navigationMap.containsKey(index)) {
          return;
        }
        var routeName = navigationMap[index]!;
        Navigator.of(context).pushReplacementNamed(routeName);
      },
    );
  }
}
