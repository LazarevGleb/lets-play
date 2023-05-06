import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class Stadium {
  final int id;
  final String address;
  final GeoPoint location;
  final String capacity;
  final String avatar;
  final String description;
  final Map<String, dynamic> data;
  final String createdAt;
  final String removedAt;

  Stadium(
      {required this.id,
      required this.address,
      required this.location,
      required this.capacity,
      required this.avatar,
      required this.description,
      required this.data,
      required this.createdAt,
      required this.removedAt});

  factory Stadium.fromJson(Map<String, dynamic> map) {
    return Stadium(
        id: map['id'],
        address: map['address'],
        location: GeoPoint(
            latitude: map["location"]["latitude"],
            longitude: map["location"]["longitude"]),
        capacity: map["capacity"],
        avatar: map["avatar"],
        description: map["description"],
        data: map["data"],
        createdAt: map["createdAt"],
        removedAt: map["removedAt"]);
  }
}
