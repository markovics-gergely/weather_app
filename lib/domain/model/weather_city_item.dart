import 'package:flutter/cupertino.dart';

class WeatherCityItem{
  final int id;
  final String name;
  final ImageProvider iconImage;
  final num minTemp;
  final num currentTemp;
  final num maxTemp;
  final num windDegree;
  final num windMagnitude;
  final double lat;
  final double lon;
  final num feels_like;
  final num humidity;
  final num pressure;

  WeatherCityItem(
      this.id,
      this.name,
      this.iconImage,
      this.minTemp,
      this.currentTemp,
      this.maxTemp,
      this.windDegree,
      this.windMagnitude,
      this.lat,
      this.lon,
      this.feels_like,
      this.humidity,
      this.pressure
      );
}