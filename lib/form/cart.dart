import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/block/order_row_block.dart';
import 'package:shoplite1/constants.dart';
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
        title: const Text('Cart'),
      ),
      body: BlocBuilder<DataCubitOrderRow, KeeperOrderRow>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                    itemCount:
                        context.read<DataCubitOrderRow>().getOrderRow.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              context
                                  .read<DataCubitOrderRow>()
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
                                      .read<DataCubitOrderRow>()
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
                                            .read<DataCubitOrderRow>()
                                            .getOrderRow[index]
                                            .ProductId,
                                        context
                                            .read<DataCubitOrderRow>()
                                            .getOrderRow[index]
                                            .ProductName,
                                        context
                                            .read<DataCubitOrderRow>()
                                            .getOrderRow[index]
                                            .ProductPrice,
                                        1);

                                    setState(() {
                                      context
                                          .read<DataCubitOrderRow>()
                                          .add(row);
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
                                            .read<DataCubitOrderRow>()
                                            .getOrderRow[index]
                                            .ProductId,
                                        context
                                            .read<DataCubitOrderRow>()
                                            .getOrderRow[index]
                                            .ProductName,
                                        context
                                            .read<DataCubitOrderRow>()
                                            .getOrderRow[index]
                                            .ProductPrice,
                                        -1);

                                    setState(() {
                                      context
                                          .read<DataCubitOrderRow>()
                                          .add(row);
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
                // Text(
                //   'Total:  ${context.read<DataCubitOrderRow>().getTotal().toStringAsFixed(2)}\$',
                //   style: txt20,
                // )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomBarGeneral(selectedIndex: 1),
    );
  }
}
