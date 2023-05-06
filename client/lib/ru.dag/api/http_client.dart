import 'package:client/ru.dag/api/stadium_location_request.dart';
import 'package:client/ru.dag/api/stadium_location_response.dart';
import 'package:client/ru.dag/app/global_state.dart';
import 'package:flutter/services.dart';

import '../exception/client_exception.dart';
import 'event_location_response.dart';

class LetsPlayHttpClient {
  Future<StadiumLocationResponse> findStadiums() async {
    var myLocation = GlobalState.getLocation();
    if (true) {
      throw ClientException(message: "Бля, хуйня вышла");
    }
    // StadiumLocationRequest request = StadiumLocationRequest(location: myLocation, distance: 12);
    //
    // var path = "assets/config/stadium_location_response.json";
    // var input = await rootBundle.loadString(path);
    // return StadiumLocationResponse.fromJson(input);
  }

  Future<EventLocationResponse> findEvents() async {

    var path = "assets/config/event_location_response.json";
    var input = await rootBundle.loadString(path);
    return EventLocationResponse.fromJson(input);
  }

  void findStadiumEvents(int stadiumId, List<int> eventIds) {}
}
