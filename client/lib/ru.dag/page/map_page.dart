import 'dart:async';

import 'package:client/ru.dag/app/global_state.dart';
import 'package:client/ru.dag/util/text_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

import '../api/http_client.dart';
import '../domain/stadium_data.dart';
import '../exception/client_exception.dart';
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

  LetsPlayHttpClient client = LetsPlayHttpClient();

  bool locationGranted = false;

  Map<int, StadiumData> stadiumData = {};

  MapController mapController = MapController(
    initMapWithUserPosition: true,
    areaLimit: const BoundingBox.world(),
  );

  void loadMarkers() {
    setState(() {
      // var stadiumRequest = StadiumLocationRequest(
      //     location: GeoPoint(latitude: 12, longitude: 12), distance: 12);

      // var eventRequest = EventLocationRequest(
      //     location: GeoPoint(latitude: 12, longitude: 12),
      //     distance: 12,
      //     dateFrom: '',
      //     dateTill: '',
      //     age: 1,
      //     rank: 1);

      try {
        client
            .findStadiums()
            // .catchError((error) => handleException(stadiumSearchError))
            .catchError((error) {
          throw const ClientException(message: stadiumSearchError);
        }).then(
          (value) => {
            for (var s in value.stadiums)
              {
                stadiumData.putIfAbsent(s.id,
                    () => StadiumData(stadiumId: s.id, location: s.location))
              },
            client
                .findEvents()
                .catchError((error) =>
                    throw const ClientException(message: eventSearchError))
                .then(
                  (value) => {
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
                  },
                )
          },
        );
      } on Exception catch (e) {
        handleException('$e');
      }
    });
  }

  Future<void> onMapReady(bool isReady) async {
    setState(() {
      locationGranted = isReady;
    });

    if (locationGranted) {
      GlobalState.setLocation(await mapController.myLocation());

      loadMarkers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OSMFlutter(
          userLocationMarker: MapMarkerBuilder.playerMarker(),
          onGeoPointClicked: openStadiumEventsPanel,
          onMapIsReady: onMapReady,
          onLocationChanged: onLocationChanged,
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
                backgroundColor: theme.secondColor(),
                child: const Icon(CupertinoIcons.slider_horizontal_3),
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              FloatingActionButton(
                backgroundColor: theme.firstColor(),
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

  openStadiumEventsPanel(GeoPoint point) {
    mapController.goToLocation(point);

    for (var s in stadiumData.values) {
      if (s.location != point) {
        continue;
      }

      //todo
      // Загрузим информацию о стадионе и событиях
      client.findStadiumEvents(s.stadiumId, s.eventIds);
    }

    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: GestureDetector(
                onTap: () {},
                child: DraggableScrollableSheet(
                  initialChildSize: 0.4,
                  minChildSize: 0.4,
                  maxChildSize: 0.6,
                  builder: (_, controller) => Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    padding: const EdgeInsets.all(15),
                    child: ListView(controller: controller, children: [
                      Text(
                        "Football is a family of team sports that involve, to varying degrees, Football is a family of team "
                        "sports that involve, to varying degrees, kickingFootball is a family of team sports that involve, "
                        "to varying degrees, kickingFootball is a family of team sports that involve, to varying degrees,"
                        " kickingFootball is a family of team sports that involve, to varying degrees, kickingFootball is "
                        "a family of team sports that involve, to varying degrees, kickingFootball is a family of "
                        "team sports that involve, to varying degrees, kickingFootball is a family of team sports that "
                        "involve, to varying degrees, kickingFootball is a family of team sports that involve, to varying"
                        " degrees, kickingFootball is a family of team sports that involve, to varying degrees,"
                        " kickingFootball is a family of team sports that involve, to varying degrees, kickingkicking a "
                        "ball to score a goal. Unqualified, the word football normally means the form of football that "
                        "is the most popular where the word is used. Sports commonly called football include association "
                        "football (known as soccer in North America, Ireland and Australia); gridiron football "
                        "(specifically American football or Canadian football); Australian rules football; rugby union "
                        "and rugby league; and Gaelic football.[1] These various forms of football share to varying "
                        "extents common origins and are known as.There are a number of references to traditional, "
                        "ancient, or prehistoric ball games played in many different parts of the world.[2][3][4] "
                        "Contemporary codes of football can be traced back to the codification of these games at "
                        "English public schools during the 19th century.[5][6] The expansion and cultural influence "
                        "of the British Empire allowed these rules of football to spread to areas of British influence "
                        "outside the directly controlled Empire.[7] By the end of the 19th century, distinct regional "
                        "codes were already developing: Gaelic football, for example, deliberately incorporated the rules"
                        " of local traditional football games in order to maintain their heritage.[8] In 1888, The "
                        "Football League was founded in England, becoming the first of many professional football "
                        "associations. During the 20th century, several of the various kinds of football grew to "
                        "become some of the most popular team sports in the world.[9]",
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // вот тут мы можем вызвать метод отображения работы с событием
                          Navigator.of(context).pop();
                        },
                        child: Text("eventCreation"),
                      )
                    ]),
                  ),
                ),
              ),
            ));
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
          return SizedBox(
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

  void handleException(String message) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(child: Text(message)),
                  ElevatedButton(
                    child: const Text(confirmButtonText),
                    onPressed: () => {Navigator.pop(context)},
                  ),
                ],
              ),
            ),
          );
        });
  }

  void onLocationChanged(GeoPoint location) {
    GlobalState.setLocation(location);
  }
}
