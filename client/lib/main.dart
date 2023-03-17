import 'package:client/navigation.dart';
import 'package:flutter/material.dart';

import 'map_page.dart';
import 'menu_page.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'LetsPlayFont2',
      ),
      initialRoute: LetsPlayNavigation.mapRoute,
      routes: {
        LetsPlayNavigation.mapRoute: (context) => MapPage(),
        LetsPlayNavigation.menuRoute: (context) => MenuPage(),
      },
    ));
