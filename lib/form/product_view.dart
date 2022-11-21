import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/block/product_block.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/crud/product_crud.dart';
import 'package:shoplite1/model/product.dart';

class ProductView extends StatefulWidget {
  const ProductView({Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  List<Product> products = [];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DataCubitProduct(KeeperProduct()),
      child: BlocBuilder<DataCubitProduct, KeeperProduct>(
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
                  IconButton(
                      onPressed: () {
                        showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Warning!'),
                            content: const Text('Do you want to delete?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ).then((value) {
                          if (value! == true) {
                            print(value);
                            ProductCrud.del(products[index].id).then((value) {
                              setState(() {
                                products.remove(products[index]);
                              });
                            });
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.black26,
                      )),
                ],
              );
            },
          ),
        );
      }),
    );
  }

  @override
  void initState() {
    ProductCrud.getAll().then((value) {
      setState(() {
        print(value);
        products = value;
      });
    });

    super.initState();
  }
}
