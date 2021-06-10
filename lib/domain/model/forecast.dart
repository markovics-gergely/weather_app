import 'package:flutter/cupertino.dart';

class Forecast {
  double lat;
  double lon;
  List<hourly_forecast> hourly;
  List<daily_forecast> daily;

  Forecast({
    required this.lat,
    required this.lon,
    required this.hourly,
    required this.daily,
  });
}

class hourly_forecast {
  final num temp;
  final num feels_like;
  final num humidity;
  final num pressure;
  final num wind_deg;
  final num wind_speed;
  final ImageProvider iconImage;
  final num dt;

  hourly_forecast({
    required this.temp,
    required this.feels_like,
    required this.humidity,
    required this.pressure,
    required this.wind_deg,
    required this.wind_speed,
    required this.iconImage,
    required this.dt
  });
}
class daily_forecast {
  final ImageProvider iconImage;
  final num humidity;
  final num pressure;
  final num wind_deg;
  final num wind_speed;
  final double dayTemp;
  final double nightTemp;
  final double minTemp;
  final double maxTemp;
  final num dt;

  daily_forecast({
    required this.dayTemp,
    required this.nightTemp,
    required this.minTemp,
    required this.maxTemp,
    required this.humidity,
    required this.pressure,
    required this.wind_deg,
    required this.wind_speed,
    required this.iconImage,
    required this.dt
  });
}