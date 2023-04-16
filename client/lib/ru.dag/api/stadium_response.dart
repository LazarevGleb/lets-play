import 'dart:convert';

import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../domain/stadium_location.dart';

class StadiumsResponse {
  final List<StadiumLocation> stadiums;

  const StadiumsResponse({required this.stadiums});

  factory StadiumsResponse.fromJson(String json) {
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

    return StadiumsResponse(stadiums: stadiums);
  }
}
