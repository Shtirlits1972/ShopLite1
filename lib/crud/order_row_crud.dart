import 'package:path/path.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/model/order_row.dart';
import 'package:sqflite/sqflite.dart';

class OrderRowCrud {
  static Future<OrderRow> add(OrderRow model) async {
    String command = 'INSERT INTO OrderRow(ProductId, Qty) values(?, ?);';
    OrderRow pr = OrderRow.empty();

    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    pr = await db.transaction<OrderRow>((txn) async {
      int id = await txn.rawInsert(command, [model.ProductId, model.qty]);

      OrderRow pr1 = OrderRow(id, model.ProductId, model.ProductName,
          model.ProductPrice, model.qty);
      return pr1;
    });
    return pr;
  }

  static Future del(int id) async {
    String command = 'DELETE FROM OrderRow WHERE id = ?';
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

  static Future upd(OrderRow model) async {
    String command = 'UPDATE OrderRow SET ProductId = ?, Qty = ? WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count =
          await db.rawUpdate(command, [model.ProductId, model.qty, model.id]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future<List<OrderRow>> getAll() async {
    List<OrderRow> listProduct = [];

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list = await db.rawQuery(
          ' SELECT id, ProductId, ProductName, PriceProduct, Qty FROM OrderRowView ;');

      for (int i = 0; i < list.length; i++) {
        int id = list[i]['id'];
        int ProductId = int.parse(list[i]['ProductId']);
        String ProductName = list[i]['ProductName'];
        double PriceProduct = double.parse(list[i]['PriceProduct'].toString());
        int Qty = int.parse(list[i]['Qty']);

        OrderRow orderRow =
            OrderRow(id, ProductId, ProductName, PriceProduct, Qty);

        listProduct.add(orderRow);
      }
    } catch (e) {
      print(e);
    }
    return listProduct;
  }
}
