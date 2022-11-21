import 'package:path/path.dart';
import 'package:shoplite1/constants.dart';
import 'package:sqflite/sqflite.dart';

class InitCrud {
  static init() async {
    String productTab = 'CREATE TABLE [Product](  ' +
        '[id] INTEGER PRIMARY KEY AUTOINCREMENT,  ' +
        '[NameProduct] NVARCHAR, ' +
        '[PriceProduct] DOUBLE );  ';

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

          print('DB created');
        }, version: 1);
      } catch (e) {
        print(e);
      }
    });
  }
}
