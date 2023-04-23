import 'dart:convert';

import '../domain/stadium_event.dart';

class EventLocationResponse {
  final List<StadiumEvent> events;

  const EventLocationResponse({required this.events});

  factory EventLocationResponse.fromJson(String json) {
    List<StadiumEvent> events = [];
    List<dynamic> list = jsonDecode(json)["stadiumEvents"] as List;

    for (var element in list) {
      var stadiumId = element["stadiumId"];
      List<int> eventIds = element["eventIds"].cast<int>();

      events.add(StadiumEvent(stadiumId: stadiumId, eventIds: eventIds));
    }

    return EventLocationResponse(events: events);
  }
}
