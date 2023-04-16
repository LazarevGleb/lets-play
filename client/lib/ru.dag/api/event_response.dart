import 'dart:convert';

import '../domain/stadium_event.dart';

class EventResponse {
  final List<StadiumEvents> events;

  const EventResponse({required this.events});

  factory EventResponse.fromJson(String json) {
    List<StadiumEvents> events = [];
    List<dynamic> list = jsonDecode(json);

    for (var element in list) {
      var stadiumId = element["stadiumId"];
      var eventIds = element["eventIds"];

      events.add(StadiumEvents(stadiumId: stadiumId, eventIds: eventIds));
    }

    return EventResponse(events: events);
  }
}
