import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/model/product.dart';

class KeeperProduct {
  List<Product> productsList = [];
}

class DataCubitProduct extends Cubit<KeeperProduct> {
  List<Product> get getProduct => state.productsList;

  setProductList(List<Product> newList) {
    state.productsList = newList;
  }

  add(Product prod) {
    state.productsList.add(prod);
  }

  upd(Product prod) {
    for (int i = 0; i < state.productsList.length; i++) {
      if (state.productsList[i].id == prod.id) {
        state.productsList[i] = prod;
        break;
      }
    }
  }

  del(int id) {
    for (int i = 0; i < state.productsList.length; i++) {
      if (state.productsList[i].id == id) {
        state.productsList.removeAt(i);
        break;
      }
    }
  }

  DataCubitProduct(KeeperProduct initState) : super(initState);
}
