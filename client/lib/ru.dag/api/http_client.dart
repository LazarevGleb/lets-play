import 'package:client/ru.dag/api/stadium_location_request.dart';
import 'package:client/ru.dag/api/stadium_location_response.dart';
import 'package:flutter/services.dart';

import 'event_location_request.dart';
import 'event_location_response.dart';

class LetsPlayHttpClient {
  Future<StadiumLocationResponse> findStadiums(StadiumLocationRequest request) async {
    var path = "assets/config/stadium_location_response.json";
    var input = await rootBundle.loadString(path);
    return StadiumLocationResponse.fromJson(input);
  }

  Future<EventLocationResponse> findEvents(EventLocationRequest request) async {
    var path = "assets/config/event_location_response.json";
    var input = await rootBundle.loadString(path);
    return EventLocationResponse.fromJson(input);
  }
}
