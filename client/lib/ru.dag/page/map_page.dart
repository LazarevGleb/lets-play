import 'package:client/ru.dag/api/event_location_request.dart';
import 'package:client/ru.dag/app/navigation.dart';
import 'package:client/ru.dag/util/text_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../api/http_client.dart';
import '../api/stadium_location_request.dart';
import '../domain/stadium_data.dart';
import '../domain/stadium_location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GeoPoint home = GeoPoint(latitude: 59.990628, longitude: 30.309782);

  LetsPlayHttpClient client = LetsPlayHttpClient();

  StadiumLocation? selectedStadium;

  Map<int, StadiumData> stadiumData = {};

  MapController mapController = MapController(
    initMapWithUserPosition: false,
    initPosition: GeoPoint(latitude: 59.990628, longitude: 30.309782),
    areaLimit: const BoundingBox.world(),
  );

  PanelController panelController = PanelController();

  void loadMarkers() {
    setState(() {
      var stadiumRequest = StadiumLocationRequest(
          location: GeoPoint(latitude: 12, longitude: 12), distance: 12);

      var eventRequest = EventLocationRequest(
          location: GeoPoint(latitude: 12, longitude: 12),
          distance: 12,
          dateFrom: '',
          dateTill: '',
          age: 1,
          rank: 1);

      client.findStadiums(stadiumRequest).then((value) => {
            for (var s in value.stadiums)
              {
                stadiumData.putIfAbsent(s.id,
                    () => StadiumData(stadiumId: s.id, location: s.location))
              },
            client.findEvents(eventRequest).then((value) => {
                  for (var e in value.events)
                    {
                      stadiumData.update(
                          e.stadiumId,
                          (v) => StadiumData.withEvents(
                              stadiumId: v.stadiumId,
                              location: v.location,
                              eventIds: e.eventIds))
                    },
              setupMarkers()
            }),
          });
    });
  }

  Future<void> onMapReady(bool isReady) async {
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
    var stadiumPanel = Center(child: Text("$selectedStadium"));

    return Scaffold(
      body: SlidingUpPanel(
        backdropEnabled: true,
        minHeight: 50,
        maxHeight: 300,
        controller: panelController,
        isDraggable: false,
        onPanelClosed: onPanelClosed,
        panel: stadiumPanel,
        collapsed: Container(
            color: Colors.blueGrey,
            child: const Center(
                child: Text(findStadiumAndLetsPlay,
                    style: TextStyle(fontSize: 20, color: Colors.white)))),
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

  StadiumLocation? getStadiumByPoint(GeoPoint point) {
    for (var s in stadiumData.keys) {
      if (s == point) {
        return null;
      }
    }
    return null;
  }

  void setupMarkers() {
    for (var s in stadiumData.values) {

      if (s.eventIds.isEmpty) {
        mapController.addMarker(s.location,
            markerIcon: const MarkerIcon(
              iconWidget: Icon(
                CupertinoIcons.sportscourt,
                size: 100,
              ),
            ));
      } else {
        mapController.addMarker(s.location,
            markerIcon: const MarkerIcon(
              iconWidget: Icon(
                CupertinoIcons.ant,
                size: 100,
              ),
            ));
      }
    }
  }
}
