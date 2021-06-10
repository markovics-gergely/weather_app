import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/model/forecast.dart';
import 'package:weather_app/domain/model/weather_header.dart';
import 'package:weather_icons/weather_icons.dart';

import 'data/database/data_source.dart';
import 'domain/model/forecast.dart';
import 'domain/model/weather_city_item.dart';
import 'list_repository.dart';
import 'main.dart';

class DetailPage extends StatefulWidget {
  final DataSource dataSource;
  final ScreenArguments arguments;
  final bool favorited;

  DetailPage({Key? key, required this.dataSource, required this.arguments, required this.favorited}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(arguments, favorited, dataSource);
}

class _DetailPageState extends State<DetailPage> {
  final repository = ListRepository();
  Future<WeatherCityItem?>? cityRequest;
  Future<Forecast?>? forecast;
  bool favorited;
  final DataSource dataSource;
  int _selectedIndex = 0;

  ScreenArguments arguments;
  _DetailPageState(this.arguments, this.favorited, this.dataSource);

  @override
  void initState() {
    var city = repository.getCityByName(arguments.message);
    cityRequest = city;
    setForecast(city);
    super.initState();
  }

  void setForecast(Future<WeatherCityItem?> city) async {
    var c = await city;
    if(c != null){
      setState(() {
        forecast = repository.getForecast(c.lat.toString(), c.lon.toString());
      });
      await forecast;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(arguments.message),
                IconButton(
                  onPressed: () async {
                    setState(() {
                      favorited = !favorited;
                    });
                    var city = await cityRequest;
                    if(city != null) {
                      if (favorited) await dataSource.upsertWeather(Weather_Header(
                          id: city.id,
                          name: city.name,
                          lat: city.lat,
                          lon: city.lon));
                      else{
                        await dataSource.deleteWeather(Weather_Header(
                            id: city.id,
                            name: city.name,
                            lat: city.lat,
                            lon: city.lon));
                      }
                    }
                  },
                  tooltip: 'Favorite',
                  icon: favorited ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
                  color: Colors.redAccent
                )
              ],
            )
        ),
      body: RefreshIndicator(
        onRefresh: () async {
          var request = repository.getCityByName(arguments.message);
          setState(() {
            cityRequest = request;
          });
          await request;
        },
        child: FutureBuilder<WeatherCityItem?>(
          future: cityRequest,
          builder: (context, snapshot) {
            if (snapshot.hasError){
              return Center(
                child: Text(
                    "Hiba történt: ${snapshot.error}"
                ),
              );
            } else if (snapshot.hasData){
              if(snapshot.data == null)
                return Center(
                  child: Text("City cannot be found"),
                );
              var city = snapshot.data!;


              return Padding(
                padding: EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(image: city.iconImage),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Max Temp:"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Temperature:"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Felt Temp:"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Min Temp:"),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(city.maxTemp.toString() + " °C"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(city.currentTemp.toString() + " °C"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(city.feels_like.toString() + " °C"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(city.minTemp.toString() + " °C"),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Wind"),
                                  WindIcon(degree: city.windDegree),
                                  Text("${city.windMagnitude} m/s"),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Hummidity:"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text("Pressure:"),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(city.humidity.toString() + " %"),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(city.pressure.toString() + " hPa"),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    /*Card(
                      child: FutureBuilder<Forecast?>(
                      future: forecast,
                        builder: (context, snapshot) {
                        if (snapshot.hasError){
                          return Center(
                            child: Text(
                            "Hiba történt: ${snapshot.error}"
                            ),
                            );
                          } else if (snapshot.hasData){
                            var forecast = snapshot.data!;

                            final screenHeight = MediaQuery.of(context).size.height;
                            if(_selectedIndex == 0){
                              return Container(
                                  height: screenHeight / 4 * 3,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i){
                                      return ForecastHourlyListItem(forecast.hourly[i]);
                                    },
                                    itemCount: forecast.hourly.length,
                                  )
                              );
                            }
                            else{
                              return Container(
                                  color: Colors.lightBlueAccent,
                                  height: screenHeight / 4 * 3,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i){
                                      return ForecastDailyListItem(forecast.daily[i]);
                                    },
                                    itemCount: forecast.daily.length,
                                  )
                              );
                            }
                          }
                          else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                      ),
                    )*/
                    FutureBuilder<Forecast?>(
                        future: forecast,
                        builder: (context, snapshot) {
                          if (snapshot.hasError){
                            return Center(
                              child: Text(
                                  "Hiba történt: ${snapshot.error}"
                              ),
                            );
                          } else if (snapshot.hasData){
                            var forecast = snapshot.data!;

                            final screenHeight = MediaQuery.of(context).size.height;
                            if(_selectedIndex == 0){
                              return Container(
                                  color: Colors.lightBlueAccent,
                                  height: screenHeight / 4 * 3,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i){
                                      return ForecastHourlyListItem(forecast.hourly[i]);
                                    },
                                    itemCount: forecast.hourly.length,
                                  )
                              );
                            }
                            else{
                              return Container(
                                  color: Colors.lightBlueAccent,
                                  height: screenHeight / 4 * 3,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i){
                                      return ForecastDailyListItem(forecast.daily[i]);
                                    },
                                    itemCount: forecast.daily.length,
                                  )
                              );
                            }
                          }
                          else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                    ),
                  ],
                )
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.timer_rounded),
            label: 'Hourly',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Daily',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ForecastHourlyListItem extends StatelessWidget {
  final hourly_forecast item;

  const ForecastHourlyListItem(
      this.item, {
        Key? key,
      }) : super(key: key);

  String GetTime(num dt){
    var format = new DateFormat('MM-dd HH:mm');
    var date = new DateTime.fromMillisecondsSinceEpoch(dt.toInt() * 1000);

    return format.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
          color: const Color(0xFFc9e9f5),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: EdgeInsets.all(3),
                    child: Text(GetTime(item.dt)),
                ),
                Image(
                    image: item.iconImage,
                    fit: BoxFit.cover,
                  ),
                Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        const Text("Temp"),
                        Text(item.temp.toString() + " °C")
                      ],
                    )
                ),
                Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        const Text("Felt Temp"),
                        Text(item.feels_like.toString() + " °C")
                      ],
                    )
                ),
                Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        WindIcon(degree: item.wind_deg),
                        Text("${item.wind_speed} m/s"),
                      ],
                    )
                ),
                Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        const Text("Humidity"),
                        Text(item.humidity.toString() + " %")
                      ],
                    )
                ),
                Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        const Text("Pressure"),
                        Text(item.pressure.toString() + " hPa")
                      ],
                    )
                ),
              ],
            ),
    );
  }
}

class ForecastDailyListItem extends StatelessWidget {
  final daily_forecast item;

  const ForecastDailyListItem(
      this.item, {
        Key? key,
      }) : super(key: key);

  String GetTime(num dt){
    var format = new DateFormat('MM-dd');
    var date = new DateTime.fromMillisecondsSinceEpoch(dt.toInt() * 1000);

    return format.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFc9e9f5),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(GetTime(item.dt)),
        Image(
          image: item.iconImage,
          fit: BoxFit.cover,
        ),
        Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                const Text("Day Temp"),
                Text(item.dayTemp.toString() + " °C")
              ],
            )
        ),
        Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                const Text("Night Temp"),
                Text(item.nightTemp.toString() + " °C")
              ],
            )
        ),
        Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                const Text("Max Temp"),
                Text(item.maxTemp.toString() + " °C")
              ],
            )
        ),
        Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                const Text("Min Temp"),
                Text(item.minTemp.toString() + " °C")
              ],
            )
        ),
        Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                WindIcon(degree: item.wind_deg),
                Text("${item.wind_speed} m/s"),
              ],
            )
        ),
        Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                const Text("Humidity"),
                Text(item.humidity.toString() + " %")
              ],
            )
        ),
        Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Column(
              children: [
                const Text("Pressure"),
                Text(item.pressure.toString() + " hPa")
              ],
            )
        ),
      ],
    ),
    );
  }
}