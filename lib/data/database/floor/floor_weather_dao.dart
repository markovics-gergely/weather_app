import 'package:floor/floor.dart';

import 'floor_weather.dart';

@dao
abstract class FloorWeatherDao {
  @Query('SELECT * FROM weather')
  Future<List<FloorWeather>> getAllWeather();

  @Query('SELECT * FROM weather WHERE id = :id')
  Future<FloorWeather?> getWeather(int id);

  @Query("DELETE FROM weather WHERE id = :id")
  Future<void> deleteWeather(int id);

  @Query("DELETE FROM weather")
  Future<void> deleteAllWeather();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> upsertWeather(FloorWeather weather);
}