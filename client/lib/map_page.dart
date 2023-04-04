import 'package:client/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import 'http_client.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GeoPoint home = GeoPoint(latitude: 59.990628, longitude: 30.309782);

  LetsPlayHttpClient client = LetsPlayHttpClient();

  MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 59.990628, longitude: 30.309782),
    areaLimit: const BoundingBox.world(),
  );

  void loadMarkers() {
    client.getStadiums().forEach((point) {
      mapController.addMarker(point,
          markerIcon: const MarkerIcon(
            iconWidget: Icon(
              CupertinoIcons.location_solid,
              size: 100,
            ),
          ));
    });
  }

  void onMapReady(bool isReady) {
    if (!isReady) {
      return;
    }
    loadMarkers();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Column(
          children: [
            Flexible(
              child: OSMFlutter(
                onGeoPointClicked: onTap,
                onMapIsReady: onMapReady,
                controller: mapController,
                trackMyPosition: false,
                initZoom: 15,
                stepZoom: 10.0,
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar:
          LetsPlayNavigation.of(LetsPlayNavigation.mapIndex, context),
    );
  }

  onTap(GeoPoint point) {
    print("onTap $point");
    mapController.goToLocation(point);
    mapController.setZoom(zoomLevel: 15);
    mapController.zoomIn();
  }
}
