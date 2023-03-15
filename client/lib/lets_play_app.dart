import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';

class LetsPlayApp extends StatelessWidget {
  const LetsPlayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const playersNavItem = BottomNavigationBarItem(
        label: "Игроки",
        icon: Icon(Icons.accessibility_sharp, color: navBarColor));

    const settingsNavItem = BottomNavigationBarItem(
        label: "Стадионы",
        icon: Icon(Icons.account_tree_outlined, color: navBarColor));

    var playersButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => navBarColor),
      ),
      onPressed: () {
        getPlayers();
      },
      child: Text("Получить игроков"),
    );

    var navIndex = 0;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: playersButton,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              playersNavItem,
              settingsNavItem,
            ],
            currentIndex: navIndex,
            selectedItemColor: navBarColor,
            onTap: (index) {
              navIndex = index;
            },
          ),
        ));
  }

  Future<List<Player>> getPlayers() async {
    try {
      final response =
          await http.get(Uri.parse('http://172.29.18.112:8082/api/players/'));
      if (response.statusCode == 200) {
        List<Player> players = [];
        List<dynamic> json = jsonDecode(response.body) as List;
        for (var element in json) {
          var player = Player.fromJson(element);
          players.add(player);
        }
        return players;
      }
      throw Exception("Something is wrong");
    } catch (e) {
      print(e);
      return Future(() => Future(() => []));
    }
  }
}

class Player {
  final String name;

  const Player({required this.name});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(name: json['name']);
  }
}
