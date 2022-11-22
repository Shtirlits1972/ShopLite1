import 'package:flutter/material.dart';
import 'package:shoplite1/form/cart.dart';
import 'package:shoplite1/form/product_add_edit.dart';
import 'package:shoplite1/form/product_view.dart';
import 'package:shoplite1/form/shop_main.dart';
import 'package:shoplite1/main.dart';
import 'package:shoplite1/model/product.dart';
import 'package:shoplite1/model/product.dart';

class AppRouter {
  int selectIndex = 0;

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => ShopMain(
            selectedIndex: selectIndex,
          ),
        );

      case '/ProductAddEdit':
        final Product product = routeSettings.arguments as Product;
        return MaterialPageRoute(
          builder: (context) => ProductAddEdit(
            product: product,
          ),
        );

      case '/Cart':
        return MaterialPageRoute(
          builder: (context) => Cart(
            selectedIndex: selectIndex,
          ),
        );

      case '/ProductView':
        return MaterialPageRoute(
          builder: (context) => ProductView(
            selectedIndex: selectIndex,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => ShopMain(
            selectedIndex: selectIndex,
          ),
        );
    }
  }
}
