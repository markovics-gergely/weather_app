import 'package:weather_app/data/database/floor/floor_weather_database.dart';
import 'package:weather_app/data/database/weather_repository.dart';

import 'floor_weather.dart';
import 'floor_weather_dao.dart';

class FloorWeatherRepository implements WeatherRepository<FloorWeather> {
  late FloorWeatherDao weatherDao;

  @override
  Future<void> init() async {
    final database = await $FloorFloorWeatherDatabase
        .databaseBuilder("floor_weather.db")
        .build();
    weatherDao = database.weatherDao;
  }

  @override
  Future<List<FloorWeather>> getAllWeather() {
    return weatherDao.getAllWeather();
  }

  @override
  Future<FloorWeather?> getWeather(int id) {
    return weatherDao.getWeather(id);
  }

  @override
  Future<void> deleteWeather(FloorWeather weather) {
    return weatherDao.deleteWeather(weather.id);
  }

  @override
  Future<void> deleteAllWeather() {
    return weatherDao.deleteAllWeather();
  }

  @override
  Future<void> upsertWeather(FloorWeather weather) {
    return weatherDao.upsertWeather(weather);
  }
}