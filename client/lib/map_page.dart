import 'package:client/navigation.dart';
import 'package:client/stadium.dart';
import 'package:client/text_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'http_client.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GeoPoint home = GeoPoint(latitude: 59.990628, longitude: 30.309782);

  LetsPlayHttpClient client = LetsPlayHttpClient();

  Stadium? selectedStadium;
  List<Stadium> stadiums = [];

  MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 59.990628, longitude: 30.309782),
    areaLimit: const BoundingBox.world(),
  );

  PanelController panelController = PanelController();

  void loadMarkers() {
    setState(() {
      stadiums = client.getStadiums();
    });
    for (var s in stadiums) {
      mapController.addMarker(s.location,
          markerIcon: const MarkerIcon(
            iconWidget: Icon(
              CupertinoIcons.location_solid,
              size: 100,
            ),
          ));
    }
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
      body: SlidingUpPanel(
        backdropEnabled: true,
        minHeight: 50,
        maxHeight: 300,
        controller: panelController,
        isDraggable: false,
        onPanelClosed: onPanelClosed,
        panel: Center(child: Text("$selectedStadium")),
        collapsed: Container(
            color: Colors.blueGrey,
            child: const Center(
                child: Text(findStadiumAndLetsPlay,
                    style: TextStyle(fontSize: 20,color: Colors.white)))),
        body: OSMFlutter(
          onGeoPointClicked: onTap,
          onMapIsReady: onMapReady,
          controller: mapController,
          trackMyPosition: false,
          initZoom: 15,
          stepZoom: 10.0,
        ),
      ),
      bottomNavigationBar:
          LetsPlayNavigation.of(LetsPlayNavigation.mapIndex, context),
    );
  }

  onTap(GeoPoint point) {
    print("onTap $point");
    panelController.open();
    mapController.goToLocation(point);
    setState(() {
      selectedStadium = getStadiumByPoint(point);
    });
  }

  void onPanelClosed() {
    setState(() {
      selectedStadium = null;
    });
  }

  Stadium? getStadiumByPoint(GeoPoint point) {
    for (var s in stadiums) {
      if (s.location == point) {
        return s;
      }
    }
    return null;
  }
}
