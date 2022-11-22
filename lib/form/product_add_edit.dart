import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/crud/product_crud.dart';
import 'package:shoplite1/model/product.dart';
import 'package:shoplite1/widgets/bottom_bar.dart';
import 'package:shoplite1/app_router.dart';

class ProductAddEdit extends StatefulWidget {
  ProductAddEdit({Key? key, required this.product}) : super(key: key);
  Product product;
  @override
  _ProductAddEditState createState() => _ProductAddEditState();
}

class _ProductAddEditState extends State<ProductAddEdit> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: '');
    nameController.text = widget.product.NameProduct;
    TextEditingController priceController = TextEditingController(text: '0.0');
    priceController.text = widget.product.PriceProduct.toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Add New product',
          style: txt30,
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Name product',
                    style: txt20,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: nameController,
                    style: txt20,
                  ),
                ),
              )
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Price',
                    style: txt20,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: priceController,
                    style: txt20,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    onPressed: () {
                      double price = double.tryParse(priceController.text)!;

                      if (nameController.text.isNotEmpty && price > 0) {
                        widget.product.NameProduct = nameController.text;
                        widget.product.PriceProduct = price;

                        if (widget.product.id > 0) {
                          ProductCrud.upd(widget.product).then((value) {
                            Navigator.pop(context, widget.product);
                          });
                        } else {
                          ProductCrud.add(widget.product).then(
                            (value) {
                              print(widget.product);
                              Navigator.pop(context, widget.product);
                            },
                          );
                        }
                      } else {
                        print('Error: $nameController.text, $price ');
                      }
                    },
                    child: Text(
                      'OK',
                      style: txt15,
                    ),
                  ),
                ),
                Container(
                  width: 120,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    onPressed: () {
                      print('Cancel');
                      Navigator.pop(context, null);
                    },
                    child: Text(
                      'Cancel',
                      style: txt15,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
