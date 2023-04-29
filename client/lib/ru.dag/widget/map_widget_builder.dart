import 'package:flutter/cupertino.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapMarkerBuilder {
  static UserLocationMaker playerMarker() {
    var marker = MarkerIcon(
        assetMarker: AssetMarker(
            image: const AssetImage("assets/images/player_marker.png"),
            scaleAssetImage: 4));

    return UserLocationMaker(
        personMarker: marker, directionArrowMarker: marker);
  }

  static MarkerIcon stadiumMarker() {
    return MarkerIcon(
        assetMarker: AssetMarker(
            // image: const AssetImage("assets/images/stadium_marker.png"),
            image: const AssetImage("assets/images/stadium_marker.png"),
            scaleAssetImage: 4));
  }

  static MarkerIcon eventMarker() {
    return MarkerIcon(
        assetMarker: AssetMarker(
            image: const AssetImage("assets/images/event_marker.png"),
            scaleAssetImage: 4));
  }
}
