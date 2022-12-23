import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/block/order_row_block.dart';
import 'package:shoplite1/block/users_block.dart';
import 'package:shoplite1/form/cart.dart';
import 'package:shoplite1/form/login_form.dart';
import 'package:shoplite1/form/product_add_edit.dart';
import 'package:shoplite1/form/product_view.dart';
import 'package:shoplite1/form/shop_main.dart';
import 'package:shoplite1/main.dart';
import 'package:shoplite1/model/product.dart';
import 'package:shoplite1/model/product.dart';

class AppRouter {
  int selectIndex = 0;
  final DataCubitOrderRow orderRow = DataCubitOrderRow(KeeperOrderRow());
  final DataCubitUser cubitUser = DataCubitUser(KeeperUser());

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: orderRow,
            child: ShopMain(
              selectedIndex: selectIndex,
            ),
          ),
        );

      case '/Login':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubitUser,
            child: LoginForm(selectedIndex: selectIndex),
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
          builder: (context) => BlocProvider.value(
            value: orderRow,
            child: Cart(
              selectedIndex: selectIndex,
            ),
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
          builder: (context) => BlocProvider.value(
            value: orderRow,
            child: ShopMain(
              selectedIndex: selectIndex,
            ),
          ),
        );
    }
  }
}
