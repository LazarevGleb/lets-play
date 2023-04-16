import 'package:client/ru.dag/domain/stadium_OLD.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class LetsPlayHttpClient {

  List<Stadium_OLD> stadiums = [
    Stadium_OLD(
        description: "Описание стадиона 1",
        address: "Адрес стадиона 1",
        location: GeoPoint(latitude: 59.990628, longitude: 30.309782),
        capacity: "Вместимость стадиона 1"),
    Stadium_OLD(
        description: "Описание стадиона 2",
        address: "Адрес стадиона 2",
        location: GeoPoint(latitude: 59.98903, longitude: 30.30577),
        capacity: "Вместимость стадиона 2"),
    Stadium_OLD(
        description: "",
        address: "Посадский, Петроградский район, Санкт-Петербург",
        location: GeoPoint(latitude: 59.958403, longitude: 30.327332),
        capacity: ""),
    Stadium_OLD(
        description: "",
        address: "Финляндский, Калининский район, Санкт-Петербурга",
        location: GeoPoint(latitude: 59.955705, longitude: 30.359055),
        capacity: ""),
    Stadium_OLD(
        description: "",
        address: "Сампсониевское, Выборгский район, Санкт-Петербург",
        location: GeoPoint(latitude: 59.963948, longitude: 30.347534),
        capacity: ""),
    Stadium_OLD(
        description: "",
        address: "Ланское, Приморский район, Санкт-Петербург",
        location: GeoPoint(latitude: 59.982151, longitude: 30.315591),
        capacity: ""),
    Stadium_OLD(
        description: "",
        address: "Светлановское, Выборгский район, Санкт-Петербург",
        location: GeoPoint(latitude: 59.995214, longitude: 30.358557),
        capacity: ""),
    Stadium_OLD(
        description: "",
        address: "Ланское, Приморский район, Санкт-Петербург",
        location: GeoPoint(latitude: 59.986579, longitude: 30.263894),
        capacity: ""),
  ];

  List<Stadium_OLD> getStadiums() {
    return stadiums;
  }
}
