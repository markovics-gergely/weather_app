import 'dart:async';

import 'package:weather_app/data/database/floor/floor_weather.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'floor_weather_dao.dart';

part 'floor_weather_database.g.dart';

@Database(
  version: 1,
  entities: [
    FloorWeather,
  ],
)
abstract class FloorWeatherDatabase extends FloorDatabase {
  FloorWeatherDao get weatherDao;
}