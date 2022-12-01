import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/model/order_row.dart';

class KeeperOrderRow {
  List<OrderRow> order_row_List = [];
}

class DataCubitOrderRow extends Cubit<KeeperOrderRow> {
  List<OrderRow> get getOrderRow => state.order_row_List;

  setOrderRowList(List<OrderRow> newList) {
    state.order_row_List = newList;
  }

  add(OrderRow row) {
    bool flag = false;
    for (int i = 0; i < state.order_row_List.length; i++) {
      if (row.ProductId == state.order_row_List[i].ProductId) {
        state.order_row_List[i].qty += row.qty;

        if (state.order_row_List[i].qty == 0) {
          removeByProductId(state.order_row_List[i].ProductId);
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

  removeByProductId(int productId) {
    int index = -1;
    for (int i = 0; i < state.order_row_List.length; i++) {
      if (state.order_row_List[i].ProductId == productId) {
        index = i;
        break;
      }
      if (index > -1) {
        state.order_row_List.removeAt(index);
      }
    }
  }

  DataCubitOrderRow(KeeperOrderRow initState) : super(initState);
}
