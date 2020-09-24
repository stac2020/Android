import 'dart:io';

import 'package:chuck_chu/database/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tableName = 'TEST_DB';

class DBHelper {
  DBHelper._();

  static final DBHelper _db = DBHelper._();

  factory DBHelper() => _db;
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'TEST_DB1.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            '''CREATE TABLE $tableName(id INTEGER PRIMARY KEY, record TEXT, date TEXT)''');
      },
    );
  }

  createData(Record record) async {
    final db = await database;
    var res = await db.rawInsert('INSERT INTO $tableName(record, date) VALUES(?, ?)', [record.record, record.date]);
    print(res);
    return res;
  }

  getAllData() async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $tableName ORDER BY date');

    print(res);

    return res;
  }

  getRank() async {
    final db = await database;
    var res = await db.rawQuery('SELECT avg(CAST(record as DOUBLE)) as AVG FROM $tableName');
double data = res[0]['AVG'];
    return data ;
  }

  deleteAllData() async {
    final db = await database;
    db.rawDelete('DELETE FROM $tableName');
  }

}
