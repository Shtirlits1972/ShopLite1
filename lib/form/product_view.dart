import 'package:flutter/material.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/crud/product_crud.dart';
import 'package:shoplite1/form/product_add_edit.dart';
import 'package:shoplite1/model/product.dart';
import 'package:shoplite1/app_router.dart';
import 'package:shoplite1/widgets/bottom_bar.dart';
import 'package:shoplite1/app_router.dart';

class ProductView extends StatefulWidget {
  ProductView({Key? key, required this.selectedIndex}) : super(key: key);
  int selectedIndex;
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  List<Product> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProductView'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              print('add new');
              try {
                Product product33 = Product.empty();
                Navigator.pushNamed(context, '/ProductAddEdit',
                        arguments: product33)
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      products.add(value as Product);
                    });
                  }
                });
              } catch (e) {
                print(e);
              }
            },
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Add new product',
          )
        ],
      ),
      body: Center(
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
                InkWell(
                  onLongPress: () {
                    print('edit product');
                    try {
                      Navigator.pushNamed(context, '/ProductAddEdit',
                              arguments: products[index])
                          .then((value) {
                        Product prodEdit = value as Product;
                        if (prodEdit != null) {
                          for (int i = 0; i < products.length; i++) {
                            if (products[i].id == prodEdit.id) {
                              setState(() {
                                products[i] = prodEdit;
                              });
                              break;
                            }
                          }
                        }
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      products[index].NameProduct,
                      style: txt15,
                    ),
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
                            showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Warning!'),
                                content: const Text('Do you want to delete?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
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
                                ProductCrud.del(products[index].id);
                                setState(() {
                                  products.remove(products[index]);
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
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomBarGeneral(selectedIndex: 2),
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
