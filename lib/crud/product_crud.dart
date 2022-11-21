import 'package:path/path.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/model/product.dart';
import 'package:sqflite/sqflite.dart';

class ProductCrud {
  static Future<Product> add(Product model) async {
    String command =
        'INSERT INTO Product (NameProduct, PriceProduct) values(?, ?);';
    Product pr = Product.empty();

    String strPath = await getDatabasesPath();
    String path = join(strPath, dbName);
    Database db = await openDatabase(path, version: 1);

    pr = await db.transaction<Product>((txn) async {
      int id =
          await txn.rawInsert(command, [model.NameProduct, model.PriceProduct]);
      Product pr1 = Product(id, model.NameProduct, model.PriceProduct);
      return pr1;
    });
    return pr;
  }

  static Future del(int id) async {
    String command = 'DELETE FROM Product WHERE id = ?';
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

  static Future upd(Product model) async {
    String command =
        'UPDATE exercise SET NameProduct = ?, PriceProduct = ? WHERE id = ?';
    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);
      Database db = await openDatabase(path, version: 1);

      int count = await db.rawUpdate(
          command, [model.NameProduct, model.PriceProduct, model.id]);

      print('row updated = $count ');
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Product>> getAll() async {
    List<Product> listProduct = [];

    try {
      String strPath = await getDatabasesPath();
      String path = join(strPath, dbName);

      Database db = await openDatabase(path, version: 1);

      List<Map> list = await db
          .rawQuery('SELECT id, NameProduct, PriceProduct FROM Product ;');

      for (int i = 0; i < list.length; i++) {
        int id = list[i]['id'];
        String NameProduct = list[i]['NameProduct'];
        double PriceProduct = double.parse(list[i]['PriceProduct'].toString());
        Product pr = Product(id, NameProduct, PriceProduct);
        listProduct.add(pr);
      }
    } catch (e) {
      print(e);
    }
    return listProduct;
  }
}
