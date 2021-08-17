import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_offline/models/books.dart';

class DbConn {

  Database database;

  Future initDB() async {
    if (database != null) {
      return database;
    }

    String databasesPath = await getDatabasesPath();
    database = await openDatabase(
      join(databasesPath, 'books.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE books(id INTEGER PRIMARY KEY, date TEXT, name TEXT, auth TEXT, cate TEXT,pubyear INTEGER, image TEXT)",
        );
      },
      version: 1,
    );

    return database;
  }

  void insertBooks(Books books) async {
    final Database db = database;

    db.insert(
      'books',
      books.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Books>> books() async {
    final Database db = database;

    final List<Map<String, dynamic>> maps = await db.query('books');

    return List.generate(maps.length, (i) {
      return Books(
        id: maps[i]['id'],
        booksDesc: maps[i]['date'],
        booksName: maps[i]['name'],
        booksAuth: maps[i]['auth'],
        booksCate: maps[i]['cate'],
        pubyear: maps[i]['pubyear'],
        image : maps[i]['image'] == 'null'?maps[i]['image'] : 'https://www.mcicon.com/wp-content/uploads/2020/12/Education_Book_1-copy-18.jpg' ,
      );
    });
  }

  // Future<int> countTotal() async {
  //   final Database db = database;
  //   final int sumEarning = Sqflite
  //       .firstIntValue(await db.rawQuery('SELECT SUM(amount) FROM books WHERE type = "earning"'));
  //   final int sumExpense = Sqflite
  //       .firstIntValue(await db.rawQuery('SELECT SUM(amount) FROM books WHERE type = "expense"'));
  //   return ((sumEarning  == null? 0: sumEarning) - (sumExpense == null? 0: sumExpense));
  // }

  Future<void> updateBooks(Books books) async {
    final db = database;

    await db.update(
      'books',
      books.toMap(),
      where: "id = ?",
      whereArgs: [books.id],
    );
  }

  Future<void> deleteBooks(int id) async {
    final db = database;

    await db.delete(
      'books',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}