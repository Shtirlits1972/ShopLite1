import 'package:path/path.dart';
import 'package:shoplite1/constants.dart';
import 'package:sqflite/sqflite.dart';

class InitCrud {
  static init() async {
    String productTab =
        'CREATE TABLE [Product](  [id] INTEGER PRIMARY KEY AUTOINCREMENT,  [NameProduct] NVARCHAR, [PriceProduct] DOUBLE );  ';

    String orderRowTab =
        'CREATE TABLE [OrderRow](  [id] INTEGER PRIMARY KEY AUTOINCREMENT,   [ProductId] INT NOT NULL DEFAULT 0,   [Qty] INT DEFAULT 0); ';

    String orderRowView =
        'CREATE VIEW OrderRowView AS  SELECT R.id,   R.ProductId,  P.NameProduct AS "ProductName",  P.PriceProduct,  R.Qty  FROM OrderRow R   LEFT JOIN Product P ON P.id = R.ProductId;';

    String ins1 =
        'INSERT INTO Product (NameProduct, PriceProduct) values(\"Pizza Piperoni\", 50.0);';
    String ins2 =
        'INSERT INTO Product (NameProduct, PriceProduct) values(\"Pizza Four taste\", 150.0);';
    String ins3 =
        'INSERT INTO Product (NameProduct, PriceProduct) values(\"Pizza Margarita\", 80.0);';

    getDatabasesPath().then((String strPath) {
      String path = join(strPath, dbName);
      try {
        final database = openDatabase(path, onCreate: (db, version) async {
          db.execute(productTab);

          db.execute(ins1);
          db.execute(ins2);
          db.execute(ins3);

          db.execute(orderRowTab);
          db.execute(orderRowView);

          print('DB created');
        }, version: 1);
      } catch (e) {
        print(e);
      }
    });
  }
}
