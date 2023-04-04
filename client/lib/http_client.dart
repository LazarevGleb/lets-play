import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class LetsPlayHttpClient {
  List<GeoPoint> stadiums = [
    GeoPoint(latitude: 59.990628, longitude: 30.309782),
    GeoPoint(latitude: 59.98903, longitude: 30.30577),
  ];

  List<GeoPoint> getStadiums() {
    return stadiums;
  }
}
