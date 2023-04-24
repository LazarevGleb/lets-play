import 'package:flutter/cupertino.dart';
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
      selectedFontSize: 14,
      unselectedFontSize: 14,
      iconSize: 20,
      items: const [
        BottomNavigationBarItem(
            label: "Карта", icon: Icon(CupertinoIcons.map_pin_ellipse)),
        BottomNavigationBarItem(label: "Меню", icon: Icon(CupertinoIcons.gear_alt)),
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
