import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/block/shop_block.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/crud/order_detail_crud.dart';
import 'package:shoplite1/crud/order_head_crud.dart';
import 'package:shoplite1/model/order_detail.dart';
import 'package:shoplite1/model/order_head.dart';
import 'package:shoplite1/model/order_row.dart';
import 'package:shoplite1/widgets/bottom_bar.dart';

class Cart extends StatefulWidget {
  Cart({Key? key, required this.selectedIndex}) : super(key: key);
  int selectedIndex;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
            //  context.read<DataCubitShop>().getUser.Login,
            'Cart'),
      ),
      body: BlocBuilder<DataCubitShop, KeeperShop>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 10,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    itemCount: context.read<DataCubitShop>().getOrderRow.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              context
                                  .read<DataCubitShop>()
                                  .getOrderRow[index]
                                  .ProductName,
                              style: txt15,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  context
                                      .read<DataCubitShop>()
                                      .getOrderRow[index]
                                      .qty
                                      .toStringAsFixed(2),
                                  style: txt15,
                                ),
                                IconButton(
                                  onPressed: () {
                                    print('+');
                                    OrderRow row = OrderRow(
                                        0,
                                        context
                                            .read<DataCubitShop>()
                                            .getOrderRow[index]
                                            .ProductId,
                                        0,
                                        context
                                            .read<DataCubitShop>()
                                            .getOrderRow[index]
                                            .ProductName,
                                        context
                                            .read<DataCubitShop>()
                                            .getOrderRow[index]
                                            .ProductPrice,
                                        1);

                                    setState(() {
                                      context.read<DataCubitShop>().add(row);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.add_circle,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    print('-');
                                    OrderRow row = OrderRow(
                                        0,
                                        context
                                            .read<DataCubitShop>()
                                            .getOrderRow[index]
                                            .ProductId,
                                        0,
                                        context
                                            .read<DataCubitShop>()
                                            .getOrderRow[index]
                                            .ProductName,
                                        context
                                            .read<DataCubitShop>()
                                            .getOrderRow[index]
                                            .ProductPrice,
                                        -1);

                                    setState(() {
                                      context.read<DataCubitShop>().add(row);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    size: 30,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Total:  ${context.read<DataCubitShop>().getTotal().toStringAsFixed(2)}\$',
                    style: txt20,
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 120,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextButton(
                            onPressed: () {
                              try {
                                setState(() {
                                  context.read<DataCubitShop>().clear();
                                  print('Clear cart');
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text(
                              'Clear',
                              style: txt15,
                            ),
                          ),
                        ),
                        Container(
                          width: 120,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextButton(
                            onPressed: () async {
                              try {
                                int userId =
                                    context.read<DataCubitShop>().getUser.id;
                                DateTime dt = DateTime.now();

                                order_head head = order_head(0, userId, dt, 0);

                                OrderHeadCrud.add(head).then((value) {
                                  List<OrderRow> list =
                                      context.read<DataCubitShop>().getOrderRow;

                                  for (int i = 0; i < list.length; i++) {
                                    order_detail detail = order_detail(
                                        0,
                                        value.id,
                                        list[i].ProductId,
                                        list[i].ProductName,
                                        list[i].ProductPrice,
                                        list[i].qty,
                                        (list[i].ProductPrice * list[i].qty));
                                    OrderDetailCrud.add(detail);
                                  }

                                  setState(() {
                                    context.read<DataCubitShop>().clear();
                                    print('Clear cart');
                                  });
                                });
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: Text(
                              'Order',
                              style: txt15,
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomBarGeneral(selectedIndex: 1),
    );
  }
}
