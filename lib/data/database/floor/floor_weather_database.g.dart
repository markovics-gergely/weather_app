// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_weather_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorFloorWeatherDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorWeatherDatabaseBuilder databaseBuilder(String name) =>
      _$FloorWeatherDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$FloorWeatherDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$FloorWeatherDatabaseBuilder(null);
}

class _$FloorWeatherDatabaseBuilder {
  _$FloorWeatherDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$FloorWeatherDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$FloorWeatherDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<FloorWeatherDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$FloorWeatherDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$FloorWeatherDatabase extends FloorWeatherDatabase {
  _$FloorWeatherDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FloorWeatherDao? _weatherDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `weather` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `lat` REAL NOT NULL, `lon` REAL NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FloorWeatherDao get weatherDao {
    return _weatherDaoInstance ??= _$FloorWeatherDao(database, changeListener);
  }
}

class _$FloorWeatherDao extends FloorWeatherDao {
  _$FloorWeatherDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _floorWeatherInsertionAdapter = InsertionAdapter(
            database,
            'weather',
            (FloorWeather item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'lat': item.lat,
                  'lon': item.lon
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FloorWeather> _floorWeatherInsertionAdapter;

  @override
  Future<List<FloorWeather>> getAllWeather() async {
    return _queryAdapter.queryList('SELECT * FROM weather',
        mapper: (Map<String, Object?> row) => FloorWeather(
            id: row['id'] as int,
            name: row['name'] as String,
            lat: row['lat'] as double,
            lon: row['lon'] as double));
  }

  @override
  Future<FloorWeather?> getWeather(int id) async {
    return _queryAdapter.query('SELECT * FROM weather WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FloorWeather(
            id: row['id'] as int,
            name: row['name'] as String,
            lat: row['lat'] as double,
            lon: row['lon'] as double),
        arguments: [id]);
  }

  @override
  Future<void> deleteWeather(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM weather WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAllWeather() async {
    await _queryAdapter.queryNoReturn('DELETE FROM weather');
  }

  @override
  Future<void> upsertWeather(FloorWeather weather) async {
    await _floorWeatherInsertionAdapter.insert(
        weather, OnConflictStrategy.replace);
  }
}
