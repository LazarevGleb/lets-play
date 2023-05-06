import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class StadiumLocationRequest {
  final GeoPoint location;
  final double distance;

  const StadiumLocationRequest({required this.location, required this.distance});
}
