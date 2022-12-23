import 'dart:ffi';

import 'package:path/path.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/model/product.dart';
import 'package:sqflite/sqflite.dart';

import '../model/users.dart';

class UsersCrud {
  static Future<users> LoginUser(String Login, String Password) async {
    users user = users.empty();

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list = await db.rawQuery(
          'SELECT id, Login, IsRemember Password FROM users WHERE Login = ? AND Password = ? LIMIT 1 ;',
          [Login, Password]);

      if (list != null && list.length > 0) {
        int id = list[0]['id'];
        String Login = list[0]['Login'];
        String Password = list[0]['Password'];
        bool IsRemember = list[0]['IsRemember'];
        users pr = users(id, Login, Password, IsRemember);
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<users> add(users model) async {
    String command =
        'INSERT INTO users (Login, Password, IsRemember) values(?, ?, ?);';

    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    model = await db.transaction<users>((txn) async {
      int id = await txn.rawInsert(command, [model.Login, model.Password]);
      model = users(id, model.Login, model.Password, model.IsRemember);
      return model;
    });
    return model;
  }

  static Future del(int id) async {
    String command = 'DELETE FROM users WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db.rawDelete(command, [id]);

      print('row delete = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future upd(users model) async {
    String command =
        'UPDATE users SET Login = ?, Password = ?, IsRemember = ? WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db.rawUpdate(
          command, [model.Login, model.Password, model.IsRemember, model.id]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future<List<users>> getAll() async {
    List<users> listUsers = [];

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list =
          await db.rawQuery('SELECT id, Login, Password FROM users ;');

      for (int i = 0; i < list.length; i++) {
        int id = list[i]['id'];
        String Login = list[i]['Login'];
        String Password = list[i]['Password'];
        bool IsRemember = list[0]['IsRemember'];

        users pr = users(id, Login, Password, IsRemember);
        listUsers.add(pr);
      }
    } catch (e) {
      print(e);
    }
    return listUsers;
  }
}
