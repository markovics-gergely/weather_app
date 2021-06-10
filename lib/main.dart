import 'package:flutter/material.dart';
import 'package:weather_app/data/database/floor/floor_weather_repository.dart';
import 'package:weather_app/detailPage.dart';

import 'data/database/data_source.dart';
import 'data/datasource_provider.dart';
import 'list_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dataSource = DataSource(FloorWeatherRepository());

  await dataSource.init();

  runApp(
    DataSourceProvider(
      dataSource: dataSource,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListPageWidget(dataSource: DataSourceProvider.of(context)!.dataSource),
    );
  }
}

class ScreenArguments {
  final String message;

  ScreenArguments(this.message);
}
