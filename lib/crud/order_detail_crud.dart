import 'package:path/path.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/model/order_detail.dart';
import 'package:sqflite/sqflite.dart';

class OrderDetailCrud {
  static Future<order_detail> add(order_detail model) async {
    String command =
        'INSERT INTO order_detail (order_id, tovar_id, qty) values(?, ?, ?);';
    order_detail head = order_detail.empty();

    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    head = await db.transaction<order_detail>((txn) async {
      int id = await txn
          .rawInsert(command, [model.order_id, model.tovar_id, model.qty]);
      order_detail head1 = order_detail(id, model.order_id, model.tovar_id,
          model.NameProduct, model.PriceProduct, model.qty, model.sum_row);
      return head1;
    });
    return head;
  }

  static Future del(int id) async {
    String command = 'DELETE FROM order_detail WHERE id = ?';
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

  static Future upd(order_detail model) async {
    String command =
        'UPDATE order_detail SET order_id = ?, tovar_id = ?, qty = ? WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db.rawUpdate(
          command, [model.order_id, model.tovar_id, model.qty, model.id]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future<List<order_detail>> getAll(int order_id) async {
    List<order_detail> list_order_detail = [];

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list = await db.rawQuery(
          'SELECT id, order_id, tovar_id, NameProduct, PriceProduct, qty, sum_row  FROM order_detail_view WHERE order_id = ? ;',
          [order_id]);

      for (int i = 0; i < list.length; i++) {
        int id = list[i]['id'];

        int order_id = list[i]['order_id'];
        int tovar_id = list[i]['tovar_id'];

        String NameProduct = list[i]['NameProduct'];
        double PriceProduct = double.parse(list[i]['PriceProduct'].toString());
        int qty = list[i]['qty'];
        double sum_row = double.parse(list[i]['sum_row'].toString());

        order_detail detail = order_detail(
            id, order_id, tovar_id, NameProduct, PriceProduct, qty, sum_row);

        list_order_detail.add(detail);
      }
    } catch (e) {
      print(e);
    }
    return list_order_detail;
  }
}
