import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class GlobalState {
  static GeoPoint? _cameraLocation;
  static double _distance = 10;
  static String _dateFrom = "123";
  static String _dateTill = "123";
  static int _age = 12;
  static double _rank = 5;

  static void setLocation(GeoPoint point) {
    _cameraLocation = point;
  }

  static GeoPoint? getLocation() {
    return _cameraLocation;
  }

  static void setDistance(double distance) {
    _distance = distance;
  }

  static double getDistance() {
    return _distance;
  }

  static void setDateFrom(String dateFrom) {
    _dateFrom = dateFrom;
  }

  static String getDateFrom() {
    return _dateFrom;
  }

  static void setDateTill(String dateTill) {
    _dateTill = dateTill;
  }

  static String getDateTill() {
    return _dateTill;
  }

  static void setAge(int age) {
    _age = age;
  }

  static int getAge() {
    return _age;
  }

  static void setRank(double rank) {
    _rank = rank;
  }

  static double getRank() {
    return _rank;
  }
}
