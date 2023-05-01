import 'package:client/ru.dag/page/map_page.dart';
import 'package:client/ru.dag/page/menu_page.dart';
import 'package:client/ru.dag/util/theme/theme_picker.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../util/theme/lets_play_theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget? _child;
  LetsPlayTheme theme = ThemePicker.getCurrentTheme();

  @override
  void initState() {
    super.initState();
    _child = const MapPage();
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: theme.navBarTransitionColor(),
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                svgPath: "assets/images/tab_1.svg",
                backgroundColor: theme.mapTabColor(),
                extras: {"label": "карта"}),
            FluidNavBarIcon(
                svgPath: "assets/images/tab_2.svg",
                backgroundColor: theme.menuTabColor(),
                extras: {"label": "меню"}),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(
            barBackgroundColor: theme.navBarColor(),
            iconSelectedForegroundColor: Colors.black,
            iconUnselectedForegroundColor: Colors.black,
          ),
          scaleFactor: 1.5,
          defaultIndex: 0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = const MapPage();
          break;
        case 1:
          _child = const MenuPage();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}
