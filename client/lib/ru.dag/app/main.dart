import 'package:client/ru.dag/app/navigation.dart';
import 'package:flutter/material.dart';

import '../page/map_page.dart';
import '../page/menu_page.dart';
import '../page/welcome_page.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'LetsPlayFont',
      ),
      initialRoute: LetsPlayNavigation.welcomeRoute,
      routes: {
        LetsPlayNavigation.welcomeRoute: (context) => const WelcomePage(),
        LetsPlayNavigation.mapRoute: (context) => const MapPage(),
        LetsPlayNavigation.menuRoute: (context) => const MenuPage(),
      },
    ));
