import 'package:resto/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  static String _tableFavorite = 'favorite';

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database?> get database async => _database ?? await _initializeDb();

  Future<Database?> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase('$path/restaurant.db', onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE $_tableFavorite (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating REAL
        )
      ''');
    }, version: 1);
    return db;
  }

  Future<List<Restaurant>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tableFavorite);
    return results
        .map((restaurant) => Restaurant.fromJson(restaurant))
        .toList();
  }

  Future<void> saveFavorite(Restaurant restaurants) async {
    final db = await database;
    await db!.insert(_tableFavorite, restaurants.toJson());
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;
    await db!.delete(_tableFavorite, where: 'id=?', whereArgs: [id]);
  }

  Future<bool?> isFavorite(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db!.query(
      _tableFavorite,
      where: 'id=?',
      whereArgs: [id],
    );
    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
