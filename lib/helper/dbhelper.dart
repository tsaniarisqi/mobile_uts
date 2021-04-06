import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_daftar_lagu/models/user.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'utsdaftarLagu.db';

    //create, read databases
    var utsDaftarLaguDatabase =
        openDatabase(path, version: 1, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return utsDaftarLaguDatabase;
  }

  // untuk membuat tabel pada database
  void _createDb(Database db, int version) async {
    await db.execute('''
                CREATE TABLE user (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT,
                password TEXT
                )
                ''');
  }

  //select data tabel user
  Future<List<Map<String, dynamic>>> selectUser() async {
    Database db = await this.initDb();
    var mapList = await db.query('user', orderBy: 'username');
    return mapList;
  }

  // insert data tabel User
  Future<int> insertUser(User object) async {
    Database db = await this.initDb();
    int count = await db.insert('user', object.toMap());
    return count;
  }

  //delete data tabel user
  Future<int> deleteUser(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('user', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<User> getLogin(String username, String password) async {
    Database db = await this.initDb();
    // var res = await dbClient.rawQuery("SELECT * FROM user WHERE username = '$user' and password = '$password'");
    List<Map<String, dynamic>> count = await db.rawQuery(
        "SELECT * FROM user WHERE username = '$username' and password = '$password'");
    if (count.length > 0) {
      return new User.fromMap(count.first);
    }
    return null;
  }

  Future<List<User>> getAllUser() async {
    var itemMapList = await selectUser();
    int count = itemMapList.length;
    List<User> itemList = List<User>();
    for (int i = 0; i < count; i++) {
      itemList.add(User.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
