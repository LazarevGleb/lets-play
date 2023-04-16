import 'package:client/ru.dag/api/stadium_request.dart';
import 'package:client/ru.dag/api/stadium_response.dart';

import 'stadium_events_request.dart';
import 'stadium_events_response.dart';

class LetsPlayHttpClient {
  Future<StadiumsResponse> findStadiums(StadiumRequest request) async {
    var input =
        "{\"stadiums\": [{\"id\": 1,\"location\": {\"latitude\": 59.990628,\"longitude\": 30.309782}}]}";
    return StadiumsResponse.fromJson(input);
  }

  Future<EventResponse> findEvents(StadiumEventsRequest request) async {
    var input = "{\"stadiumEvents\": [{\"stadiumId\": 1,\"eventIds\": [1,2,3]}]}";
    return EventResponse.fromJson(input);
  }
}
