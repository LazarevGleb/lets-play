import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class StadiumEventsRequest {
  final GeoPoint location;
  final double distance;
  final String dateFrom;
  final String dateTill;
  final int age;
  final double rank;

  const StadiumEventsRequest({
    required this.location,
    required this.distance,
    required this.dateFrom,
    required this.dateTill,
    required this.age,
    required this.rank,
  });
}
