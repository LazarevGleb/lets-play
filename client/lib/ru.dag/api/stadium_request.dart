import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class StadiumRequest {
  final GeoPoint location;
  final double distance;

  const StadiumRequest({required this.location, required this.distance});
}
