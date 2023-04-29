import 'package:client/ru.dag/app/navigation.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            var routeName = LetsPlayNavigation.mapRoute;
            Navigator.of(context).pushReplacementNamed(routeName);
          },
          child: const Text("Перейти к карте"),
        ),
      ),
    );
  }


}
