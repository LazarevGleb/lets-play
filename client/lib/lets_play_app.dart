import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'colors.dart';

class LetsPlayApp extends StatefulWidget {
  const LetsPlayApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LetsPlayState();
  }
}

class LetsPlayState extends State<LetsPlayApp> {
  static const playersNavItem = BottomNavigationBarItem(
      label: "Игроки",
      icon: Icon(Icons.accessibility_sharp, color: navBarColor));

  static const settingsNavItem = BottomNavigationBarItem(
      label: "Стадионы",
      icon: Icon(Icons.account_tree_outlined, color: navBarColor));

  var navIndex = 0;
  List<Player> players = [];

  @override
  Widget build(BuildContext context) {
    var playersButton = ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => navBarColor),
      ),
      onPressed: () {
        reloadPlayers().then((value) => setState(() {
              players = value;
            }));
      },
      child: Text("Получить игроков"),
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'LetsPlayFont2',
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 72.0),
            titleLarge: TextStyle(fontSize: 40.0),
            bodyMedium: TextStyle(fontSize: 30.0),
            labelSmall: TextStyle(fontSize: 25.0)
          ),),
        home: Scaffold(
          body: Center(
            child: Stack(
              children: [
                Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(getPlayersReport())),
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: playersButton,
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              playersNavItem,
              settingsNavItem,
            ],
            currentIndex: navIndex,
            selectedItemColor: navBarColor,
            onTap: (index) {
              setState(() {
                navIndex = index;
              });
            },
          ),
        ));
  }

  String getPlayersReport() {
    String result = "Игроки: ";
    players.forEach((p) {
      result += p.name + " ";
    });
    return result;
  }
}

Future<List<Player>> reloadPlayers() async {
  try {
    final response = await http.get(
        Uri.parse('http://172.29.18.112:8082/api/players/'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
    if (response.statusCode == 200) {
      List<Player> players = [];
      List<dynamic> json = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      print(response.body);
      for (var element in json) {
        var player = Player.fromJson(element);
        players.add(player);
      }
      print(players);
      return players;
    }
    throw Exception("Something is wrong");
  } catch (e) {
    print(e);
    return Future(() => Future(() => []));
  }
}

class Player {
  final String name;

  const Player({required this.name});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(name: json['name']);
  }
}
