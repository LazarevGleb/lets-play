import 'dart:convert';

import '../domain/event.dart';
import '../domain/stadium.dart';

class StadiumEventResponse {
  final Stadium stadium;
  final List<Event> events;

  StadiumEventResponse(this.stadium, this.events);

  factory StadiumEventResponse.fromJson(String json) {
    Map map = jsonDecode(json) as Map;

    var stadium = Stadium.fromJson(map["stadium"]);
    List<Event> events = [];

    for (var element in map["events"]) {
      var event = Event.fromJson(element);
      events.add(event);
    }

    return StadiumEventResponse(stadium, events);
  }
}
