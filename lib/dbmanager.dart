import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbUser {
  Database _database;
//
//  get user => null;
  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "leaderboard.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE users(id INTEGER PRIMARY KEY autoincrement,name TEXT,score TEXT,created_at TEXT,game TEXT)",
        );
      });
    }
  }

  Future<int> insertUser(User user) async {
    await openDb();
    return await _database.insert('users', user.toMap());
  }

  Future<List<User>> getUserList(String game) async {
    await openDb();
    final List<Map<String, dynamic>> maps = await _database.rawQuery('SELECT * FROM users where game LIKE "%'+game+'%"');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        score: maps[i]['score'],
        created_at: maps[i]['created_at'],
        game: maps[i]['game'],

      );
    });
  }

  Future<int> updateUser(User user) async {
    await openDb();
    return await _database
        .update('users', user.toMap(), where: "id = ?", whereArgs: [user.id]);
  }

  Future<void> deleteUser(String id) async {
    await openDb();
    await _database.delete('users', where: "contact_id= ?", whereArgs: [id]);
  }
}

class User {
  int id;
  String name;
  String created_at;
  String score;
  String game;
  User(

      {@required this.name,
      @ required this.created_at,
      @required this.score,
      @required this.game,
        this.id});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'score': score,
      'created_at': created_at,
      'game': game,
    };
  }
}
