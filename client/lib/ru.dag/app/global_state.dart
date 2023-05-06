import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class GlobalState {
  static GeoPoint? _cameraLocation;

  static void setLocation(GeoPoint point) {
    _cameraLocation = point;
  }

  static GeoPoint? getLocation() {
    return _cameraLocation;
  }
}
