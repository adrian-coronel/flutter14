import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter20062024/model/team.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class ConnDatabase {

  static final ConnDatabase connections = ConnDatabase._internal();

  static Database? _database;

  ConnDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, '../model/team.dart');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }


  Future<void> _createDatabase(Database db, _) async {
    return await db.execute('''
      CREATE TABLE ${Team.TableNameTeam}(
        _id INTEGER PRIMARY KEY AUTOINCREMENT,
        name VARCHAR(200),
        foundingYear INTEGER,
        dateChamp TEXT
      );
    ''');
  }

  Future close() async {
    final db = await connections.database;
    db.close();
  }

}