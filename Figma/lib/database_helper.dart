import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:figma/UserModel.dart';
import 'dart:io' as io;

class DbHelper {
  static Database? _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserName = 'user_name';
  static const String C_IdNumber = 'id_number';
  static const String C_PhoneNumber = 'phone_number';
  static const String C_Password = 'password';

  static Future<Database?> get db async {

    if (_db != null) {
      return _db;
    }
    _db =  await initDb();
    return _db;
  }

  static Future<Database?> initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  static Future<void> _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserName TEXT, "
        " $C_IdNumber TEXT, "
        " $C_PhoneNumber TEXT,"
        " $C_Password TEXT, "
        " PRIMARY KEY ($C_IdNumber)"
        ")");
  }

  static Future<int?> saveData(UserModel user) async {
    var dbClient = await db;
    int? userId = await dbClient?.insert(Table_User, user.toMap());
    return userId;
  }

  Future<UserModel?> getLoginUser(String phoneNumber) async {
    var dbClient = await db;
    var res = await dbClient?.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_PhoneNumber = '$phoneNumber'");

    if (res?.isNotEmpty ?? false) {
      return UserModel.fromMap(res!.first);
    }

    return null;
  }

  static Future<void> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient?.update(Table_User, user.toMap(),
        where: '$C_IdNumber = ?', whereArgs: [user.id_number]);
    print(user.id_number);
  }

  Future<UserModel?> getUserById(String userId) async {
    var dbClient = await db;
    var res = await dbClient?.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_IdNumber = '$userId'");


    if (res?.isNotEmpty ?? false) {
      return UserModel.fromMap(res!.first);
    }

    return null;
  }
  Future<List<UserModel>> getAllUser() async {
    var dbClient = await db;
    final List<Map<String, dynamic>>? maps = await dbClient?.rawQuery('SELECT * FROM $Table_User ');
    if (maps != null) {
      return List.generate(maps.length, (i) {
        return UserModel(
          user_name: maps[i]['user_name'],
          id_number: maps[i]['id_number'],
          phone_number: maps[i]['phone_number'],
          password: maps[i]['password'],
        );
      });
    } else {
      return []; // Return an empty list if maps is null
    }
  }
}