import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/block/order_row_block.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/crud/product_crud.dart';
import 'package:shoplite1/model/order_row.dart';
import 'package:shoplite1/model/product.dart';
import 'package:shoplite1/widgets/bottom_bar.dart';

class ShopMain extends StatefulWidget {
  ShopMain({Key? key, required this.selectedIndex}) : super(key: key);

  int selectedIndex;

  @override
  State<ShopMain> createState() => _ShopMainState();
}

class _ShopMainState extends State<ShopMain> {
  List<Product> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ShopMain'),
      ),
      body: BlocBuilder<DataCubitOrderRow, KeeperOrderRow>(
          builder: (context, state) {
        return Center(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      products[index].NameProduct,
                      style: txt15,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text(
                          products[index].PriceProduct.toStringAsFixed(2),
                          style: txt15,
                        ),
                        IconButton(
                            onPressed: () {
                              print(
                                  'Add Tovar   ${products[index].NameProduct}');

                              setState(() {
                                OrderRow row = OrderRow(
                                    0,
                                    products[index].id,
                                    products[index].NameProduct,
                                    products[index].PriceProduct,
                                    1);

                                context.read<DataCubitOrderRow>().add(row);
                                bool flag = context
                                    .read<DataCubitOrderRow>()
                                    .notEmpty();
                              });
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              size: 30,
                              color: Colors.blue,
                            )),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
      bottomNavigationBar:
          BottomBarGeneral(selectedIndex: widget.selectedIndex),
    );
  }

  @override
  void initState() {
    super.initState();
    ProductCrud.getAll().then((value) {
      setState(() {
        products = value;
      });
    });
  }
}
