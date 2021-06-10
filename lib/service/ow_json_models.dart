import 'package:json_annotation/json_annotation.dart';

part 'ow_json_models.g.dart';

@JsonSerializable()
class OWCitiesFindResponse{
  final String message;
  final String cod;
  final num count;
  final List<OWCityWeatherInformation> list;

  OWCitiesFindResponse(this.message, this.cod, this.count, this.list);

  factory OWCitiesFindResponse.fromJson(Map<String, dynamic> json) => _$OWCitiesFindResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OWCitiesFindResponseToJson(this);
}

@JsonSerializable()
class OWCityWeatherInformation{
  final int id;
  final String name;
  @JsonKey(name: "coord") final OWCoordinate coordinate;
  final OWMainWeatherData main;
  final num dt;
  final OWWindWeatherData wind;
  final List<OWWeatherDescriptionData> weather;

  OWCityWeatherInformation(this.id, this.name, this.coordinate, this.main, this.dt, this.wind, this.weather);

  factory OWCityWeatherInformation.fromJson(Map<String, dynamic> json) => _$OWCityWeatherInformationFromJson(json);
  Map<String, dynamic> toJson() => _$OWCityWeatherInformationToJson(this);
}

@JsonSerializable()
class OWDetailedCityWeatherInformation{
  final double lat;
  final double lon;

  final List<OWHourlyForecastInformation> hourly;
  final List<OWDailyForecastInformation> daily;

  OWDetailedCityWeatherInformation(this.lat, this.lon, this.hourly, this.daily);

  factory OWDetailedCityWeatherInformation.fromJson(Map<String, dynamic> json) => _$OWDetailedCityWeatherInformationFromJson(json);
  Map<String, dynamic> toJson() => _$OWDetailedCityWeatherInformationToJson(this);
}

@JsonSerializable()
class OWHourlyForecastInformation{
  final num temp;
  final num feels_like;
  final num humidity;
  final num pressure;
  final num wind_deg;
  final num wind_speed;
  final num dt;
  final List<OWWeatherDescriptionData> weather;

  OWHourlyForecastInformation(this.temp, this.feels_like, this.humidity, this.weather, this.pressure, this.wind_deg, this.wind_speed, this.dt);

  factory OWHourlyForecastInformation.fromJson(Map<String, dynamic> json) => _$OWHourlyForecastInformationFromJson(json);
  Map<String, dynamic> toJson() => _$OWHourlyForecastInformationToJson(this);
}

@JsonSerializable()
class OWDailyForecastInformation{
  final num humidity;
  final num pressure;
  final num wind_deg;
  final num wind_speed;
  final List<OWWeatherDescriptionData> weather;
  final OWDailyTemp temp;
  final num dt;

  OWDailyForecastInformation(this.humidity, this.pressure, this.wind_deg, this.wind_speed, this.weather, this.temp, this.dt);

  factory OWDailyForecastInformation.fromJson(Map<String, dynamic> json) => _$OWDailyForecastInformationFromJson(json);
  Map<String, dynamic> toJson() => _$OWDailyForecastInformationToJson(this);
}

@JsonSerializable()
class OWDailyTemp{
  final double day;
  final double night;
  final double min;
  final double max;

  OWDailyTemp(this.day, this.night, this.min, this.max);

  factory OWDailyTemp.fromJson(Map<String, dynamic> json) => _$OWDailyTempFromJson(json);
  Map<String, dynamic> toJson() => _$OWDailyTempToJson(this);
}

@JsonSerializable()
class OWCoordinate{
  final double lat;
  final double lon;

  OWCoordinate(this.lat, this.lon);

  factory OWCoordinate.fromJson(Map<String, dynamic> json) => _$OWCoordinateFromJson(json);
  Map<String, dynamic> toJson() => _$OWCoordinateToJson(this);
}

@JsonSerializable()
class OWMainWeatherData{
  final num temp;
  final num feels_like;
  final num pressure;
  final num humidity;
  final num temp_min;
  final num temp_max;

  OWMainWeatherData(this.temp, this.pressure, this.humidity, this.temp_min, this.temp_max, this.feels_like);

  factory OWMainWeatherData.fromJson(Map<String, dynamic> json) => _$OWMainWeatherDataFromJson(json);
  Map<String, dynamic> toJson() => _$OWMainWeatherDataToJson(this);
}

@JsonSerializable()
class OWWindWeatherData{
  final num speed;
  final num deg;

  OWWindWeatherData(this.speed, this.deg);

  factory OWWindWeatherData.fromJson(Map<String, dynamic> json) => _$OWWindWeatherDataFromJson(json);
  Map<String, dynamic> toJson() => _$OWWindWeatherDataToJson(this);
}

@JsonSerializable()
class OWWeatherDescriptionData{
  final int id;
  final String main;
  final String description;
  final String icon;

  OWWeatherDescriptionData(this.id, this.main, this.description, this.icon);

  factory OWWeatherDescriptionData.fromJson(Map<String, dynamic> json) => _$OWWeatherDescriptionDataFromJson(json);
  Map<String, dynamic> toJson() => _$OWWeatherDescriptionDataToJson(this);
}