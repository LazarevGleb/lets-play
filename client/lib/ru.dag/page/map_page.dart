import 'dart:async';

import 'package:client/ru.dag/api/event_location_response.dart';
import 'package:client/ru.dag/api/stadium_events_response.dart';
import 'package:client/ru.dag/api/stadium_location_response.dart';
import 'package:client/ru.dag/app/client_notifier.dart';
import 'package:client/ru.dag/app/global_state.dart';
import 'package:client/ru.dag/util/text_constant.dart';
import 'package:client/ru.dag/widget/event_picker_widget.dart';
import 'package:client/ru.dag/widget/stadium_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:permission_handler/permission_handler.dart';

import '../api/http_client.dart';
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

  LetsPlayHttpClient client = LetsPlayHttpClient();

  bool locationGranted = false;

  Map<int, StadiumData> stadiumData = {};

  MapController mapController = MapController(
    initMapWithUserPosition: true,
    areaLimit: const BoundingBox.world(),
  );

  Future<void> loadMarkers() async {
    bool isError = false;

    final result = await Future.wait([
      client.findStadiums().catchError((error) {
        isError = true;
        return const StadiumLocationResponse(stadiums: []);
      }),
      client.findEvents().catchError((error) {
        isError = true;
        return const EventLocationResponse(events: []);
      }),
    ]);

    if (isError) {
      if (mounted) {
        ClientNotifier.showError(context, commonErrorText, stadiumSearchError);
      }
      return;
    }

    setState(() {
      // Стадионы
      StadiumLocationResponse stadiumResponse =
          result[0] as StadiumLocationResponse;
      for (var s in stadiumResponse.stadiums) {
        stadiumData.putIfAbsent(
            s.id, () => StadiumData(stadiumId: s.id, location: s.location));
      }

      // События
      EventLocationResponse eventResponse = result[1] as EventLocationResponse;
      for (var e in eventResponse.events) {
        stadiumData.update(
            e.stadiumId,
            (v) => StadiumData.withEvents(
                stadiumId: v.stadiumId,
                location: v.location,
                eventIds: e.eventIds));
      }

      // Рисуем маркеры
      setupMarkers();
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
          onGeoPointClicked: onPointClicked,
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

  onPointClicked(GeoPoint point) async {
    mapController.goToLocation(point);

    StadiumData? data;

    for (var s in stadiumData.values) {
      if (s.location != point) {
        continue;
      }
      data = s;
    }

    if (data == null) {
      ClientNotifier.showError(context, commonErrorText, geoPointError);
      return;
    }

    StadiumEventResponse? response;

    response = await client
        .findStadiumEvents(data.stadiumId, data.eventIds)
        .catchError((error) {
      response = null;
    });

    if (response == null) {
      if (mounted) {
        ClientNotifier.showError(context, commonErrorText, geoPointError);
      }
      return;
    }

    if (!mounted) {
      return;
    }

    //todo
    List<Widget> events = [];
    for (var event in response!.events) {
      events.add(const EventPickerWidget(
          header: "Кол-во игроков: 5/10",
          text: "В этой игре будут ебашить по ногам",
          color: Colors.blue));
      events.add(const SizedBox(
        height: 5,
      ));
    }

    events = [];

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
                  builder: (_, controller) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20))),
                      padding: const EdgeInsets.all(15),
                      child: ListView(controller: controller, children: [
                        StadiumWidget(
                          header: response!.stadium.description,
                          text: response!.stadium.address,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 15),
                        events.isEmpty
                            ? const Center(child: Text(noEventsByCriteriaFound))
                            : ListView(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                children: events,
                              ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(addNewEventButton),
                        )
                      ]),
                    );
                  },
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

  void onLocationChanged(GeoPoint location) {
    GlobalState.setLocation(location);
  }
}
