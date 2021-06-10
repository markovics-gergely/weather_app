import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:weather_app/domain/model/forecast.dart';
import 'package:weather_app/domain/model/weather_city_item.dart';
import 'package:weather_app/service/ow_service.dart';

import 'domain/model/weather_header.dart';

class ListRepository {
  var owService = OWService();

  Future<List<WeatherCityItem>> getCitiesByName(Future<List<Weather_Header>> headers) async {
    var h = await headers;
    List<String> names = h.map((e) => e.name).toList();
    var response = await owService.getCityList(names);
    return response;
  }

  Future<WeatherCityItem?> getCityByName(String name) async {
    var resp = await owService.getCity(name);
    return resp;
  }

  Future<Forecast?> getForecast(String lat, String lon) async {
    var response = await owService.getForecast(lat, lon);
    if(response == null) return null;
    List<daily_forecast> dailyList = [];
    List<hourly_forecast> hourlyList = [];
    response.daily.forEach((e) => dailyList.add(
        new daily_forecast(
            dayTemp: e.temp.day,
            nightTemp: e.temp.night,
            minTemp: e.temp.min,
            maxTemp: e.temp.max,
            humidity: e.humidity,
            pressure: e.pressure,
            wind_deg: e.wind_deg,
            wind_speed: e.wind_speed,
            iconImage: NetworkImage("https://openweathermap.org/img/wn/${e.weather[0].icon}.png"),
            dt: e.dt
        )
    ));
    response.hourly.forEach((e) {
      hourlyList.add(
          hourly_forecast(
              humidity: e.humidity,
              pressure: e.pressure,
              wind_deg: e.wind_deg,
              wind_speed: e.wind_speed,
              iconImage: NetworkImage("https://openweathermap.org/img/wn/${e.weather[0].icon}.png"),
              feels_like: e.feels_like,
              temp: e.temp,
              dt: e.dt
          )
      );
    });
    return Forecast(
        lat: response.lat,
        lon: response.lon,
        hourly: hourlyList,
        daily: dailyList
    );
  }
}