import 'package:flutter/material.dart';

import '../app/navigation.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Меню')),
      bottomNavigationBar:
          LetsPlayNavigation.of(LetsPlayNavigation.menuIndex, context),
    );
  }
}
