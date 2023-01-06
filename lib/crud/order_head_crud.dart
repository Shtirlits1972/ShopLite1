import 'package:path/path.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/model/order_head.dart';
import 'package:sqflite/sqflite.dart';

class OrderHeadCrud {
  static Future<order_head> add(order_head model) async {
    String command =
        'INSERT INTO order_head (user_id, data_order) values(?, ?);';
    order_head head = order_head.empty();

    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    head = await db.transaction<order_head>((txn) async {
      int id = await txn
          .rawInsert(command, [model.user_id, model.data_order.toString()]);
      order_head head1 =
          order_head(id, model.user_id, model.data_order, model.total_sum);
      return head1;
    });
    return head;
  }

  static Future del(int id) async {
    String command = 'DELETE FROM order_head WHERE id = ?';
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

  static Future upd(order_head model) async {
    String command =
        'UPDATE order_head SET user_id = ?, data_order = ? WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db
          .rawUpdate(command, [model.user_id, model.data_order, model.id]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future<List<order_head>> getAll(int userId) async {
    List<order_head> listorder_head = [];

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list = await db.rawQuery(
          'SELECT id, user_id, data_order, total_sum FROM order_head_view where user_id = ? ;',
          [userId]);

      for (int i = 0; i < list.length; i++) {
        int id = list[i]['id'];

        int user_id = list[i]['user_id'];
        DateTime data_order = DateTime.parse(list[i]['data_order']);
        double total_sum = double.tryParse(list[i]['total_sum'].toString())!;

        order_head head = order_head(id, user_id, data_order, total_sum);

        listorder_head.add(head);
      }
    } catch (e) {
      print(e);
    }
    return listorder_head;
  }
}
