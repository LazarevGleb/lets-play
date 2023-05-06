import 'package:client/ru.dag/api/event_location_request.dart';
import 'package:client/ru.dag/api/stadium_events_request.dart';
import 'package:client/ru.dag/api/stadium_events_response.dart';
import 'package:client/ru.dag/api/stadium_location_request.dart';
import 'package:client/ru.dag/api/stadium_location_response.dart';
import 'package:client/ru.dag/app/global_state.dart';
import 'package:flutter/services.dart';

import 'event_location_response.dart';

class LetsPlayHttpClient {
  Future<StadiumLocationResponse> findStadiums() async {
    StadiumLocationRequest request = StadiumLocationRequest(
        location: GlobalState.getLocation()!,
        distance: GlobalState.getDistance());

    var path = "assets/config/stadium_location_response.json";
    var input = await rootBundle.loadString(path);
    return StadiumLocationResponse.fromJson(input);
  }

  Future<EventLocationResponse> findEvents() async {
    EventLocationRequest request = EventLocationRequest(
        location: GlobalState.getLocation()!,
        distance: GlobalState.getDistance(),
        dateFrom: GlobalState.getDateFrom(),
        dateTill: GlobalState.getDateTill(),
        age: GlobalState.getAge(),
        rank: GlobalState.getRank());

    var path = "assets/config/event_location_response.json";
    var input = await rootBundle.loadString(path);
    return EventLocationResponse.fromJson(input);
  }

  Future<StadiumEventResponse> findStadiumEvents(
      int stadiumId, List<int> eventIds) async {
    StadiumEventsRequest request = StadiumEventsRequest(stadiumId, eventIds);

    var path = "assets/config/stadium_events_response.json";
    var input = await rootBundle.loadString(path);
    return StadiumEventResponse.fromJson(input);
  }
}
