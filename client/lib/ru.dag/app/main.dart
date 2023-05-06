import 'package:client/ru.dag/app/navigation.dart';
import 'package:flutter/material.dart';

import '../page/main_page.dart';
import '../page/welcome_page.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'LetsPlayFont',
      ),
      initialRoute: LetsPlayNavigation.welcomeRoute,
      routes: {
        LetsPlayNavigation.welcomeRoute: (context) => const WelcomePage(),
        LetsPlayNavigation.mainRoute: (context) => const MainPage(),
      },
    ));
