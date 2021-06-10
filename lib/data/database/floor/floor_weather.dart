import 'package:floor/floor.dart';

@Entity(tableName: "weather")
class FloorWeather {
  @PrimaryKey(autoGenerate: true)
  int id;
  String name;
  double lat;
  double lon;

  FloorWeather({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
  });
}