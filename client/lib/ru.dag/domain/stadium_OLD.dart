import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class Stadium_OLD {
  //    val address: String,
  //     val location: Location,
  //     val capacity: Capacity,
  //     val description: String?,
  //     val data: Map<String, Any>?,
  //     val createdAt: LocalDateTime?,
  //     val removedAt: LocalDateTime?

  final String description;
  final String address;
  final GeoPoint location;
  final String capacity;

  const Stadium_OLD(
      {required this.description,
      required this.address,
      required this.location,
      required this.capacity});

  factory Stadium_OLD.fromJson(Map<String, dynamic> json) {
    return Stadium_OLD(
        description: json['description'],
        address: json['address'],
        location:
            GeoPoint(latitude: json["location"], longitude: json["location"]),
        capacity: json['capacity']);
  }

  @override
  String toString() {
    return "Стадион $description, $address, $capacity, $location";
  }
}
