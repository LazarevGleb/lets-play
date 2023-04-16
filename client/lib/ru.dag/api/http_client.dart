import 'package:client/ru.dag/api/stadium_request.dart';
import 'package:client/ru.dag/api/stadium_response.dart';

import 'event_request.dart';
import 'event_response.dart';

class LetsPlayHttpClient {
  Future<StadiumsResponse> findStadiums(StadiumRequest request) async {
    var input =
        "{\"stadiums\": [{\"id\": 1,\"location\": {\"latitude\": 59.990628,\"longitude\": 30.309782}}]}";
    return StadiumsResponse.fromJson(input);
  }

  Future<EventResponse> findEvents(EventRequest request) async {
    var input =
        "{\"stadiums\": [{\"id\": 1,\"location\": {\"latitude\": 59.990628,\"longitude\": 30.309782}}]}";
    return EventResponse.fromJson(input);
  }
}
