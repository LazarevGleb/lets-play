import 'dart:io';

import 'package:client/ru.dag/api/stadium_location_request.dart';
import 'package:client/ru.dag/api/stadium_location_response.dart';

import 'event_location_request.dart';
import 'event_location_response.dart';

class LetsPlayHttpClient {
  Future<StadiumLocationResponse> findStadiums(StadiumLocationRequest request) async {
    var path = "/storage/1421-390B/Android/data/com.dag.lets_play.client/files/mock_response/stadium_location_response.json";
    var input = await File(path).readAsString();
    return StadiumLocationResponse.fromJson(input);
  }

  Future<EventLocationResponse> findEvents(EventLocationRequest request) async {
    var path = "/storage/1421-390B/Android/data/com.dag.lets_play.client/files/mock_response/event_location_response.json";
    var input = await File(path).readAsString();
    return EventLocationResponse.fromJson(input);
  }
}
