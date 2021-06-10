// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ow_json_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OWCitiesFindResponse _$OWCitiesFindResponseFromJson(Map<String, dynamic> json) {
  return OWCitiesFindResponse(
    json['message'] as String,
    json['cod'] as String,
    json['count'] as num,
    (json['list'] as List<dynamic>)
        .map(
            (e) => OWCityWeatherInformation.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OWCitiesFindResponseToJson(
        OWCitiesFindResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'cod': instance.cod,
      'count': instance.count,
      'list': instance.list,
    };

OWCityWeatherInformation _$OWCityWeatherInformationFromJson(
    Map<String, dynamic> json) {
  return OWCityWeatherInformation(
    json['id'] as int,
    json['name'] as String,
    OWCoordinate.fromJson(json['coord'] as Map<String, dynamic>),
    OWMainWeatherData.fromJson(json['main'] as Map<String, dynamic>),
    json['dt'] as num,
    OWWindWeatherData.fromJson(json['wind'] as Map<String, dynamic>),
    (json['weather'] as List<dynamic>)
        .map(
            (e) => OWWeatherDescriptionData.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OWCityWeatherInformationToJson(
        OWCityWeatherInformation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coord': instance.coordinate,
      'main': instance.main,
      'dt': instance.dt,
      'wind': instance.wind,
      'weather': instance.weather,
    };

OWDetailedCityWeatherInformation _$OWDetailedCityWeatherInformationFromJson(
    Map<String, dynamic> json) {
  return OWDetailedCityWeatherInformation(
    (json['lat'] as num).toDouble(),
    (json['lon'] as num).toDouble(),
    (json['hourly'] as List<dynamic>)
        .map((e) =>
            OWHourlyForecastInformation.fromJson(e as Map<String, dynamic>))
        .toList(),
    (json['daily'] as List<dynamic>)
        .map((e) =>
            OWDailyForecastInformation.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OWDetailedCityWeatherInformationToJson(
        OWDetailedCityWeatherInformation instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'hourly': instance.hourly,
      'daily': instance.daily,
    };

OWHourlyForecastInformation _$OWHourlyForecastInformationFromJson(
    Map<String, dynamic> json) {
  return OWHourlyForecastInformation(
    json['temp'] as num,
    json['feels_like'] as num,
    json['humidity'] as num,
    (json['weather'] as List<dynamic>)
        .map(
            (e) => OWWeatherDescriptionData.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['pressure'] as num,
    json['wind_deg'] as num,
    json['wind_speed'] as num,
    json['dt'] as num,
  );
}

Map<String, dynamic> _$OWHourlyForecastInformationToJson(
        OWHourlyForecastInformation instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'wind_deg': instance.wind_deg,
      'wind_speed': instance.wind_speed,
      'dt': instance.dt,
      'weather': instance.weather,
    };

OWDailyForecastInformation _$OWDailyForecastInformationFromJson(
    Map<String, dynamic> json) {
  return OWDailyForecastInformation(
    json['humidity'] as num,
    json['pressure'] as num,
    json['wind_deg'] as num,
    json['wind_speed'] as num,
    (json['weather'] as List<dynamic>)
        .map(
            (e) => OWWeatherDescriptionData.fromJson(e as Map<String, dynamic>))
        .toList(),
    OWDailyTemp.fromJson(json['temp'] as Map<String, dynamic>),
    json['dt'] as num,
  );
}

Map<String, dynamic> _$OWDailyForecastInformationToJson(
        OWDailyForecastInformation instance) =>
    <String, dynamic>{
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'wind_deg': instance.wind_deg,
      'wind_speed': instance.wind_speed,
      'weather': instance.weather,
      'temp': instance.temp,
      'dt': instance.dt,
    };

OWDailyTemp _$OWDailyTempFromJson(Map<String, dynamic> json) {
  return OWDailyTemp(
    (json['day'] as num).toDouble(),
    (json['night'] as num).toDouble(),
    (json['min'] as num).toDouble(),
    (json['max'] as num).toDouble(),
  );
}

Map<String, dynamic> _$OWDailyTempToJson(OWDailyTemp instance) =>
    <String, dynamic>{
      'day': instance.day,
      'night': instance.night,
      'min': instance.min,
      'max': instance.max,
    };

OWCoordinate _$OWCoordinateFromJson(Map<String, dynamic> json) {
  return OWCoordinate(
    (json['lat'] as num).toDouble(),
    (json['lon'] as num).toDouble(),
  );
}

Map<String, dynamic> _$OWCoordinateToJson(OWCoordinate instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };

OWMainWeatherData _$OWMainWeatherDataFromJson(Map<String, dynamic> json) {
  return OWMainWeatherData(
    json['temp'] as num,
    json['pressure'] as num,
    json['humidity'] as num,
    json['temp_min'] as num,
    json['temp_max'] as num,
    json['feels_like'] as num,
  );
}

Map<String, dynamic> _$OWMainWeatherDataToJson(OWMainWeatherData instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feels_like,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'temp_min': instance.temp_min,
      'temp_max': instance.temp_max,
    };

OWWindWeatherData _$OWWindWeatherDataFromJson(Map<String, dynamic> json) {
  return OWWindWeatherData(
    json['speed'] as num,
    json['deg'] as num,
  );
}

Map<String, dynamic> _$OWWindWeatherDataToJson(OWWindWeatherData instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };

OWWeatherDescriptionData _$OWWeatherDescriptionDataFromJson(
    Map<String, dynamic> json) {
  return OWWeatherDescriptionData(
    json['id'] as int,
    json['main'] as String,
    json['description'] as String,
    json['icon'] as String,
  );
}

Map<String, dynamic> _$OWWeatherDescriptionDataToJson(
        OWWeatherDescriptionData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };
