import 'package:weather_app/data/database/floor/floor_weather.dart';
import 'package:weather_app/data/database/weather_repository.dart';

import '../../domain/model/weather_header.dart';

class DataSource {
  final WeatherRepository<FloorWeather> database;

  DataSource(this.database);

  Future<void> init() async {
    await database.init();
  }

  Future<List<Weather_Header>> getAllWeather() async {
    final weathers = await database.getAllWeather();
    return weathers.map(
            (floorWeather) => floorWeather.toWeather(),
          ).toList();
  }

  Future<Weather_Header?> getWeather(int id) async {
    final floorWeather = await database.getWeather(id);
    return floorWeather?.toWeather();
  }

  Future<void> upsertWeather(Weather_Header weather) async {
    return database.upsertWeather(weather.toFloorWeather());
  }

  Future<void> deleteWeather(Weather_Header weather) async {
    return database.deleteWeather(weather.toFloorWeather());
  }

  Future<void> setWeatherDone(Weather_Header weather, bool isDone) async {
    return database.upsertWeather(weather.toFloorWeather());
  }

  Future<void> deleteAllWeather() async {
    return database.deleteAllWeather();
  }
}

extension WeatherToFloorWeather on Weather_Header {
  FloorWeather toFloorWeather() {
    return FloorWeather(
        id: this.id,
        name: this.name,
        lat: this.lat,
        lon: this.lon);
  }
}

extension FloorWeatherToWeather on FloorWeather {
  Weather_Header toWeather() {
    return Weather_Header(
        id: this.id,
        name: this.name,
        lat: this.lat,
        lon: this.lon);
  }
}