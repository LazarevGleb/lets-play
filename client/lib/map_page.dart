import 'package:client/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'marker_with_tooltip.dart';
import 'http_client.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LetsPlayHttpClient client = LetsPlayHttpClient();
  List<Marker> markers = [];

  void loadMarkers() {
    List<Marker> result = [];

    client.getStadiums().forEach((point) {
      result.add(Marker(
          point: point,
          anchorPos: AnchorPos.align(AnchorAlign.center),
          builder: (ctx) => MarkerWithTooltip(
              tooltip: "the tooltip text", onTap: () => print("sfdasdfasdf"),
              child: const Icon(CupertinoIcons.location_solid),
          )));
    });
    markers = result;
  }

  @override
  void initState() {
    super.initState();
    loadMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(59.990628, 30.309782),
                  zoom: 14,
                  minZoom: 10,
                  maxZoom: 18,
                  interactiveFlags:
                      InteractiveFlag.all & ~InteractiveFlag.rotate,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.dag.lets_play',
                  ),
                  MarkerLayer(
                    markers: markers,
                  )
                ],
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar:
          LetsPlayNavigation.of(LetsPlayNavigation.mapIndex, context),
    );
  }
}
