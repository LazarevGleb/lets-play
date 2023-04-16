import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class StadiumData {
  final int stadiumId;
  final GeoPoint location;
  List<int> eventIds = [];

  StadiumData({required this.stadiumId, required this.location});

  StadiumData.withEvents(
      {required this.stadiumId,
      required this.location,
      required this.eventIds});
}
