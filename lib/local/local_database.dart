import 'package:flutter/cupertino.dart';
import 'package:flutter_user_bloc/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("userszz.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''
    CREATE TABLE ${UserModelFields.table_name} (
    ${UserModelFields.id} $idType,
    ${UserModelFields.firstName} $textType,
    ${UserModelFields.lastName} $textType,
    ${UserModelFields.age} $textType,
    ${UserModelFields.gender} $textType,
    ${UserModelFields.jobTitle} $textType
    )
    ''');

    debugPrint("-------DB----------CREATED---------");
  }

  static Future<UserModel> insertUser(
      UserModel userModel) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        UserModelFields.table_name, userModel.toJson());
    return userModel.copyWith(id: id);
  }

  static Future<List<UserModel>> getAllUsers() async {
    List<UserModel> allUsers = [];
    final db = await getInstance.database;
    allUsers = (await db.query(UserModelFields.table_name))
        .map((e) => UserModel.fromJson(e))
        .toList();

    return allUsers;
  }

  // static updateNewsAuthor({required int id, required String author}) async {
  //   final db = await getInstance.database;
  //   db.update(
  //     NewsModelFields.table_name,
  //     {NewsModelFields.author: author},
  //     where: "${NewsModelFields.id} = ?",
  //     whereArgs: [id],
  //   );
  // }

  static updateUser({required UserModel userModel}) async {
    final db = await getInstance.database;
    print(userModel.toJson());
    await db.update(UserModelFields.table_name, userModel.toJson(), where: '${UserModelFields.id}=?', whereArgs: [userModel.id]);
    // db.update(
    //   UserModelFields.table_name,
    //   userModel.toJson(),
    //   where: "${UserModelFields.id} = ?",
    //   whereArgs: [userModel.id]
    // );
  }

  static Future<int> deleteUser(int id) async {
    final db = await getInstance.database;
    int count = await db.delete(
      UserModelFields.table_name,
      where: "${UserModelFields.id} = ?",
      whereArgs: [id],
    );
    return count;
  }

  // static Future<List<NewsModelSql>> getNewsByLimit(int limit) async {
  //   List<NewsModelSql> allNews = [];
  //   final db = await getInstance.database;
  //   allNews = (await db.query(NewsModelFields.table_name,
  //       limit: limit, orderBy: "${NewsModelFields.author} ASC"))
  //       .map((e) => NewsModelSql.fromJson(e))
  //       .toList();
  //
  //   return allNews;
  // }

  // static Future<NewsModelSql?> getSingleNews(int id) async {
  //   List<NewsModelSql> news = [];
  //   final db = await getInstance.database;
  //   news = (await db.query(
  //     NewsModelFields.table_name,
  //     where: "${NewsModelFields.id} = ?",
  //     whereArgs: [id],
  //   ))
  //       .map((e) => NewsModelSql.fromJson(e))
  //       .toList();
  //
  //   if (news.isNotEmpty) {
  //     return news.first;
  //   }
  // }

  // static Future<List<NewsModelSql>> getNewsByAlphabet(
  //     String order) async {
  //   List<NewsModelSql> allNews = [];
  //   final db = await getInstance.database;
  //   allNews = (await db.query(NewsModelFields.table_name,
  //       orderBy: "${NewsModelFields.author} $order"))
  //       .map((e) => NewsModelSql.fromJson(e))
  //       .toList();
  //   return allNews;
  // }
}