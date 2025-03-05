import 'package:restaurant_app/data/model/restaurant_sql.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  static const String _databaseName = 'restaurant_list.db';
  static const String _tableName = 'restaurant';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute(
      """CREATE TABLE $_tableName(
       id TEXT,
       name TEXT,
       description TEXT,
       pictureId TEXT,
       city TEXT,
       rating REAL
     )
     """,
    );
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> insertItem(RestaurantSql restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  // membaca seluruh item
  Future<List<RestaurantSql>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName, orderBy: "id");

    return results.map((result) => RestaurantSql.fromJson(result)).toList();
  }


   // mencari item berdasarkan nilai id
  Future<List> getItemById(String id) async {
    final db = await _initializeDb();
    final results =
        await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    
    return results; // Mengembalikan null jika tidak ditemukan
  }


  // memperbarui item berdasarkan nilai id-nya

 Future<int> updateItem(int id, RestaurantSql restaurant) async {
   final db = await _initializeDb();
 
   final data = restaurant.toJson();
 
   final result =
       await db.update(_tableName, data, where: "id = ?", whereArgs: [id]);
   return result;
 }

  // menghapus item berdasarkan nilai id
 Future<int> removeItem(String id) async {
   final db = await _initializeDb();
 
   final result =
       await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
   return result;
 }

 Future<void> removeAllItem() async {
   final db = await _initializeDb();
 
   await db.delete(_tableName);
 }
}
