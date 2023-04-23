import 'dart:convert';

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../domain/stadium_location.dart';

class StadiumLocationResponse {
  final List<StadiumLocation> stadiums;

  const StadiumLocationResponse({required this.stadiums});

  factory StadiumLocationResponse.fromJson(String json) {
    List<StadiumLocation> stadiums = [];
    List<dynamic> list = jsonDecode(json)["stadiums"] as List;

    for (var element in list) {
      var stadium = StadiumLocation(
          id: element['id'],
          location: GeoPoint(
              latitude: element["location"]["latitude"],
              longitude: element["location"]["longitude"]));

      stadiums.add(stadium);
    }

    return StadiumLocationResponse(stadiums: stadiums);
  }
}
