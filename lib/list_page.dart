import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/domain/model/weather_city_item.dart';
import 'package:weather_app/domain/model/weather_header.dart';
import 'package:weather_app/list_repository.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/service/ow_service.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weather_app/data/database/data_source.dart';
import 'package:weather_app/detailPage.dart';

class ListPageWidget extends StatefulWidget {
  final DataSource dataSource;

  ListPageWidget({Key? key, required this.dataSource}) : super(key: key);

  @override
  _ListPageWidgetState createState() => _ListPageWidgetState(dataSource);
}

class _ListPageWidgetState extends State<ListPageWidget> {
  DataSource _weatherDataSource;
  Future<List<Weather_Header>>? _weatherHeaderFuture;
  _ListPageWidgetState(this._weatherDataSource);

  final repository = ListRepository();
  Future<List<WeatherCityItem>>? listRequest;

  @override
  void initState() {
    _weatherHeaderFuture = _weatherDataSource.getAllWeather();
    listRequest = repository.getCitiesByName(_weatherHeaderFuture!);
    super.initState();
  }

  void onDeletePressed(Weather_Header weather) async {
    await _weatherDataSource.deleteWeather(weather);
    refreshWeathers();
  }

  void addWeather(String name) async {
    OWService service = new OWService();
    var city = await service.getCity(name);
    if(city != null){
      await _weatherDataSource.upsertWeather(new Weather_Header(id: city.id, name: city.name, lat: city.lat, lon: city.lat));
      refreshWeathers();
    }
    else ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void searchWeather(String name) async {
    OWService service = new OWService();
    var city = await service.getCity(name);
    if(city != null){
      var cities = await listRequest;
      var favorited = false;
      cities!.forEach((element) {if(element.name == name) favorited = true; });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(dataSource: _weatherDataSource, arguments: ScreenArguments(name), favorited: favorited),
        ),
      ).then((value) => {
        refreshWeathers()
      });
    }
    else ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> refreshWeathers() async {
    _weatherHeaderFuture = _weatherDataSource.getAllWeather();
    var request = repository.getCitiesByName((_weatherHeaderFuture)!);
    setState(() {
      listRequest = request;
    });
    await listRequest;
  }

  TextEditingController _textFieldController = TextEditingController();
  Widget _buildPopupDialog(BuildContext context, String mode) {
    return new AlertDialog(
      title: Text(mode + ' City'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("City Name"),
          TextField(
            autofocus: true,
            controller: _textFieldController,
          )
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            if(mode == "Add") addWeather(_textFieldController.text);
            else if(mode == "Search") searchWeather(_textFieldController.text);
          },
          child: Text(mode),
        ),
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            _textFieldController.clear();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  final snackBar = SnackBar(content: Text('Not Valid City Name'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App")
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var request = repository.getCitiesByName((_weatherHeaderFuture)!);
          setState(() {
            listRequest = request;
          });
          await request;
        },
        child: FutureBuilder<List<WeatherCityItem>>(
            future: listRequest,
            builder: (context, snapshot) {
              if (snapshot.hasError){
                return Center(
                  child: Text(
                      "Hiba történt: ${snapshot.error}"
                  ),
                );
              } else if (snapshot.hasData){
                var list = snapshot.data!;
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, i){
                    return ListItem(list[i], onDeletePressed: onDeletePressed, weatherDataSource: _weatherDataSource, onRefreshState: refreshWeathers);
                  },
                  itemCount: list.length,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.blue,
          shape: const CircularNotchedRectangle(),
          child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: IconButton(
                    tooltip: 'Search',
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      _textFieldController.clear();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => _buildPopupDialog(context, "Search"),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _textFieldController.clear();
            showDialog(
              context: context,
              builder: (BuildContext context) => _buildPopupDialog(context, "Add"),
              );
            },
          child: const Icon(Icons.add),
          tooltip: 'Create'
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class ListItem extends StatelessWidget {
  final WeatherCityItem item;
  final Function(Weather_Header weather) onDeletePressed;
  final DataSource weatherDataSource;
  final Function() onRefreshState;
  
  const ListItem(
      this.item, {
        Key? key,
        required this.onDeletePressed,
        required this.weatherDataSource,
        required this.onRefreshState
      }) : super(key: key);

  Widget _buildDeleteDialog(BuildContext context, Weather_Header header) {
    return new AlertDialog(
      title: const Text("Delete Weather"),
      content: Text("Are you sure to delete ${header.name}?"),
      actions: <Widget>[
        new TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
            onDeletePressed(header);
          },
          child: Text('Ok'),
        ),
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => DetailPage(dataSource: weatherDataSource, arguments: ScreenArguments(item.name), favorited: true),
          ),
        ).then((value) => {
          onRefreshState()
        })
      },
      child: Card(
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: Image(
                image: item.iconImage,
                fit: BoxFit.cover,
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Temp: " + item.currentTemp.toString() + " °C",
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    "Felt Temp: " + item.feels_like.toString() + " °C",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Wind"),
                    WindIcon(degree: item.windDegree),
                    Text("${item.windMagnitude} m/s"),
                  ],
                ),
              ),
            ),
            IconButton(
                icon:
                Icon(
                    Icons.delete,
                    color: Colors.black
                ),
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildDeleteDialog(context, new Weather_Header(id: item.id, name: item.name, lat: item.lat, lon: item.lon)),
                )
            )
          ],
        ),
      ),
      )
    );
  }
}