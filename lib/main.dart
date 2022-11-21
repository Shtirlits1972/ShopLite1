import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/block/app_block_observer.dart';
import 'package:shoplite1/block/product_block.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/crud/init_crud.dart';
import 'package:shoplite1/crud/product_crud.dart';
import 'package:shoplite1/form/cart.dart';
import 'package:shoplite1/form/product_view.dart';

import 'form/shop_main.dart';

// void main() => runApp(const MyApp());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitCrud.init();
  // ignore: deprecated_member_use
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    print(index);
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyApp._title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ShopLite1'),
          centerTitle: true,
        ),
        body: MainVidget(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ShopMain',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_rounded),
              label: 'Card',
              backgroundColor: Colors.yellow,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business
                  // IconData(0xf0564, fontFamily: 'MaterialIcons')
                  ),
              label: 'Products',
              backgroundColor: Colors.red,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget MainVidget(int index) {
    if (index == 1) {
      return Cart();
    } else if (index == 2) {
      return ProductView();
    } else {
      return ShopMain();
    }
  }
}
