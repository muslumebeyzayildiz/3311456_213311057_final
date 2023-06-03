import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Konum_model.dart';

class DbUtils {

  static final DbUtils _dbUtils = DbUtils._internal();

  DbUtils._internal();

  factory DbUtils() {
    return _dbUtils;
  }

  static Database? _db;

  Future<Database?> get db async {
    _db ??= await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String path = join(await getDatabasesPath(), 'doggie_database.db');//AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
    var dbKonumlar = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbKonumlar;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE konumlar(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)");
  }

  Future<void> deleteTable() async {
    final Database? db = await this.db;
    db?.delete('konumlar');
  }

  Future<void> insertKonum(Konum konum) async {
    final Database? db = await this.db;
    await db?.insert(
      'konumlar',
      konum.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Konum>> konumlar() async {
    // Get a reference to the database.
    final Database? db = await this.db;
    // Query the table for all The Dogs.
    final List<Map<String, Object?>>? maps = await db?.query('konumlar');

    // Convert the List<Map<String, dynamic> into a List<Konum>.
    return List.generate(maps!.length, (i) {
      return Konum(
        id: int.parse(maps[i]['id'].toString()),
        name: maps[i]['name'].toString(),
        age: int.parse(maps[i]['age'].toString()),
      );
    });
  }

  Future<void> updateKonum(Konum konum) async {
    final db = await this.db;
    await db?.update(
      'konumlar',
      konum.toMap(),
      where: "id = ?",
      whereArgs: [konum.id],
    );
  }

  Future<void> deleteKonum(int id) async {
    final db = await this.db;
    await db?.delete(
      'konumlar',
      where: "id = ?",
      whereArgs: [id],
    );
  }

}