import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/app_router.dart';
import 'package:shoplite1/block/app_block_observer.dart';
import 'package:shoplite1/block/product_block.dart';
import 'package:shoplite1/block/product_block.dart';
import 'package:shoplite1/block/product_block.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/crud/init_crud.dart';
import 'package:shoplite1/crud/product_crud.dart';
import 'package:shoplite1/form/cart.dart';
import 'package:shoplite1/form/product_view.dart';
import 'package:shoplite1/model/product.dart';

import 'block/product_block.dart';
import 'form/shop_main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitCrud.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();

    return MaterialApp(
      title: 'ShopLite',
      onGenerateRoute: appRouter.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
