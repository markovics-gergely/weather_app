abstract class WeatherRepository<T> {
  Future<void> init();

  Future<List<T>> getAllWeather();

  Future<T?> getWeather(int id);

  Future<void> upsertWeather(T weather);

  Future<void> deleteWeather(T weather);

  Future<void> deleteAllWeather();
}