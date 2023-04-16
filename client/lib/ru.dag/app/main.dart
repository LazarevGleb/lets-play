import 'package:client/ru.dag/app/navigation.dart';
import 'package:flutter/material.dart';

import '../page/map_page.dart';
import '../page/menu_page.dart';

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
