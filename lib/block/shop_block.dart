import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/model/order_row.dart';
import 'package:shoplite1/model/users.dart';

class KeeperShop {
  List<OrderRow> order_row_List = [];
  users user = users.empty();
}

class DataCubitShop extends Cubit<KeeperShop> {
  users get getUser => state.user;

  setCurrentUser(users NewUser) {
    state.user = NewUser;
  }

  List<OrderRow> get getOrderRow => state.order_row_List;

  setOrderRowList(List<OrderRow> newList) {
    state.order_row_List = newList;
  }

  add(OrderRow row) {
    bool flag = false;
    for (int i = 0; i < state.order_row_List.length; i++) {
      if (row.ProductId == state.order_row_List[i].ProductId) {
        state.order_row_List[i].qty += row.qty;
        print(state.order_row_List[i]);
        if (state.order_row_List[i].qty < 1) {
          print('qty = 0');
          removeByProductById(state.order_row_List[i].ProductId);
        }
        flag = true;
        break;
      }
    }

    if (!flag) {
      state.order_row_List.add(row);
    }
  }

  bool notEmpty() {
    bool flag = false;

    if (state.order_row_List.length > 0) {
      flag = true;
    }
    return flag;
  }

  double getTotal() {
    double total = 0;

    for (int i = 0; i < state.order_row_List.length; i++) {
      total += state.order_row_List[i].total();
    }

    return total;
  }

  clear() {
    state.order_row_List.clear();
  }

  removeByProductById(int productId) {
    for (int i = 0; i < state.order_row_List.length; i++) {
      if (state.order_row_List[i].ProductId == productId) {
        state.order_row_List.removeAt(i);
        print('remove $i');
        break;
      }
    }
  }

  DataCubitShop(KeeperShop initState) : super(initState);
}
