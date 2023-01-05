import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/block/shop_block.dart';

import 'package:shoplite1/form/cart.dart';
import 'package:shoplite1/form/login_form.dart';
import 'package:shoplite1/form/order_detail_form.dart';
import 'package:shoplite1/form/orders_form.dart';
import 'package:shoplite1/form/product_add_edit.dart';
import 'package:shoplite1/form/product_view.dart';
import 'package:shoplite1/form/shop_main.dart';
import 'package:shoplite1/main.dart';
import 'package:shoplite1/model/product.dart';
import 'package:shoplite1/model/product.dart';

class AppRouter {
  int selectIndex = 0;
  int orderId = 0;
  final DataCubitShop shopCubit = DataCubitShop(KeeperShop());

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: shopCubit,
            child: LoginForm(),
          ),
        );

      case '/ShopMain':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: shopCubit,
            child: ShopMain(
              selectedIndex: selectIndex,
            ),
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
            value: shopCubit,
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

      case '/OrdersForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: shopCubit,
            child: OrdersForm(
              selectedIndex: selectIndex,
            ),
          ),
        );

      // case '/OrderDetailForm':
      //   return MaterialPageRoute(
      //     builder: (context) => OrderDetailForm(
      //       orderId: orderId,
      //     ),
      //   );

      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: shopCubit,
            child: LoginForm(),
          ),
        );
    }
  }
}
