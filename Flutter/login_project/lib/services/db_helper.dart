import 'dart:async';
import 'dart:io';

import 'package:login_project/model/user.dart';
import 'package:login_project/repository/db_repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper extends DBRepository {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "UserDatabase.db");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (
      Database db,
      int version,
    ) async {
      await db.execute("CREATE TABLE User ("
          "id INTEGER,"
          "email TEXT,"
          "password TEXT,"
          "access_token TEXT"
          ")");
    });
  }

  @override
  Future<void> newUser(User user) async {
    final db = await database;
    try {
      await db.insert("User", user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {}
  }

  @override
  Future<User?> getUser() async {
    final db = await database;
    try {
      final res = await db.rawQuery("SELECT * FROM User Where access_token='access_token'");
      return res.isNotEmpty ? User.fromJson(res.first) : null;
    } catch (_) {
      return null;
    }
  }
}
