import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/model/weather_city_item.dart';

import 'ow_json_models.dart';

const _openWeatherApiKey = "983b05595bc4791f7538b870118f604c";
const _baseUrl = "api.openweathermap.org";

OWCitiesFindResponse _parseCitiesFindResponse(String message){
  return OWCitiesFindResponse.fromJson(jsonDecode(message));
}

OWCityWeatherInformation _parseCityFindResponse(String message){
  return OWCityWeatherInformation.fromJson(jsonDecode(message));
}

OWDetailedCityWeatherInformation _parseDetailCityFindResponse(String message){
  return OWDetailedCityWeatherInformation.fromJson(jsonDecode(message));
}

class OWService {
  Future<OWCityWeatherInformation?> getCityByName(String name) async {
    var response = await http.get(
      Uri.https(_baseUrl, "data/2.5/weather", {
        "q": name,
        "units": "metric",
        "appid": _openWeatherApiKey,
      }),
    );
    if(response.statusCode == 404) return null;
    return await compute(_parseCityFindResponse, response.body);
  }

  Future<OWDetailedCityWeatherInformation?> getForecast(String lat, String lon) async {
    var response = await http.get(
      Uri.https(_baseUrl, "data/2.5/onecall", {
        "lat": lat,
        "lon": lon,
        "exclude": "current,minutely,alerts",
        "units": "metric",
        "appid": _openWeatherApiKey,
      }),
    );
    if(response.statusCode == 404) return null;
    return await compute(_parseDetailCityFindResponse, response.body);
  }

  Future<WeatherCityItem?> getCity(String name) async {
    var resp = await getCityByName(name);
    if(resp == null) return null;
    var city = new WeatherCityItem(
        resp.id,
        resp.name,
        NetworkImage("https://openweathermap.org/img/wn/${resp.weather[0].icon}@2x.png"),
        resp.main.temp_min,
        resp.main.temp,
        resp.main.temp_max,
        resp.wind.deg,
        resp.wind.speed,
        resp.coordinate.lat,
        resp.coordinate.lon,
        resp.main.feels_like,
        resp.main.humidity,
        resp.main.pressure
    );
    return city;
  }

  Future<List<WeatherCityItem>> getCityList(List<String> weathers) async {
    List<WeatherCityItem> list = [];
    for(String w in weathers){
      var resp = await getCityByName(w);
      if(resp != null){
        list.add(new WeatherCityItem(
            resp.id,
            resp.name,
            NetworkImage("https://openweathermap.org/img/wn/${resp.weather[0].icon}.png"),
            resp.main.temp_min,
            resp.main.temp,
            resp.main.temp_max,
            resp.wind.deg,
            resp.wind.speed,
            resp.coordinate.lat,
            resp.coordinate.lon,
            resp.main.feels_like,
            resp.main.humidity,
            resp.main.pressure
        )
        );
      }
    }
    return list;
  }
}