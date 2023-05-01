import 'package:client/ru.dag/api/event_location_request.dart';
import 'package:client/ru.dag/util/text_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

import '../api/http_client.dart';
import '../api/stadium_location_request.dart';
import '../domain/stadium_data.dart';
import '../util/theme/lets_play_theme.dart';
import '../util/theme/theme_picker.dart';
import '../widget/map_widget_builder.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LetsPlayTheme theme = ThemePicker.getCurrentTheme();

  GeoPoint home = GeoPoint(latitude: 59.990628, longitude: 30.309782);

  LetsPlayHttpClient client = LetsPlayHttpClient();

  bool locationGranted = false;

  Map<int, StadiumData> stadiumData = {};

  MapController mapController = MapController(
    initMapWithUserPosition: true,
    areaLimit: const BoundingBox.world(),
  );

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
    setState(() {
      locationGranted = isReady;
    });

    if (locationGranted) {
      loadMarkers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OSMFlutter(
          userLocationMarker: MapMarkerBuilder.playerMarker(),
          onGeoPointClicked: onTap,
          onMapIsReady: onMapReady,
          controller: mapController,
          trackMyPosition: true,
          initZoom: 15,
          stepZoom: 10.0,
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: theme.filterBtnColor(),
                child: const Icon(CupertinoIcons.slider_horizontal_3),
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              FloatingActionButton(
                backgroundColor: theme.locationBtnColor(),
                child: const Icon(CupertinoIcons.location_north),
                onPressed: () {
                  onMyLocation();
                },
              ),
              const SizedBox(height: 60),

            ],
          ),
        ));
  }

  onTap(GeoPoint point) {
    print("onTap $point");
    Widget? widget;
    mapController.goToLocation(point);

    for (var s in stadiumData.values) {
      if (s.location != point) {
        continue;
      }
      if (s.eventIds.isNotEmpty) {
        // Загрузим информацию о событиях и отобразим их
        widget = Text(s.eventIds.toString());
      } else {
        // Загрузим информацию о стадионе и отобразим её
        widget = Text(s.stadiumId.toString());
      }
    }

    if (widget == null) {
      return;
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 500,
            child: widget,
          );
        });
  }

  onMyLocation() async {
    if (locationGranted) {
      mapController.currentLocation();
      return;
    }

    var isServiceEnabled = await Permission.location.serviceStatus.isEnabled;

    if (!isServiceEnabled) {
      return;
    }

    var status = await Permission.location.status;

    if (status.isGranted) {
      setState(() {
        locationGranted = true;
      });
      return;
    }

    Map<Permission, PermissionStatus> permission = await [
      Permission.location,
    ].request();

    var locationInUseGranted =
        permission[Permission.locationWhenInUse] == PermissionStatus.granted;
    var locationPermanentGranted =
        permission[Permission.location] == PermissionStatus.granted;

    if (locationInUseGranted || locationPermanentGranted) {
      setState(() {
        locationGranted = true;
      });
      mapController.currentLocation();
      return;
    }

    handleLocationSettings();
  }

  Future<void> setupMarkers() async {
    for (var s in stadiumData.values) {
      if (s.eventIds.isEmpty) {
        await mapController.addMarker(s.location,
            markerIcon: MapMarkerBuilder.stadiumMarker());
      } else {
        await mapController.addMarker(s.location,
            markerIcon: MapMarkerBuilder.eventMarker());
      }
    }
  }

  void handleLocationSettings() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Center(child: Text(locationTurnedOffErrorMessage)),
                  ElevatedButton(
                    child: const Text(locationSettingButton),
                    onPressed: () =>
                        {openAppSettings(), Navigator.pop(context)},
                  ),
                ],
              ),
            ),
          );
        });
  }
}
