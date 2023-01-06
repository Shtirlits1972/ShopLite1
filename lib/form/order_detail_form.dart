import 'package:flutter/material.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/crud/order_detail_crud.dart';
import 'package:shoplite1/model/order_detail.dart';
import 'package:shoplite1/model/order_head.dart';

class OrderDetailForm extends StatefulWidget {
  OrderDetailForm({Key? key, required this.order}) : super(key: key);
  order_head order;
  @override
  _OrderDetailFormState createState() => _OrderDetailFormState();
}

class _OrderDetailFormState extends State<OrderDetailForm> {
  List<order_detail> list = [];
  @override
  Widget build(BuildContext context) {
    print(widget.order);
    int h = 0;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Order Num: ${widget.order.id} ',
            style: txt30,
          ),
        ),
        body: Center(
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      (index + 1).toString(),
                      style: txt30,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        list[index].NameProduct,
                        style: txt20,
                      ),
                      Text(
                        list[index].qty.toString() +
                            ' * ' +
                            list[index].PriceProduct.toStringAsFixed(2) +
                            ' = ' +
                            list[index].sum_row.toStringAsFixed(2),
                        style: txt20,
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.blue),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total SUMMA: ${widget.order.total_sum.toStringAsFixed(2)}',
              style: txt20,
            ),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    print(widget.order.id);
    int h = 0;
    OrderDetailCrud.getAll(widget.order.id).then((value) {
      setState(() {
        list = value;
      });
      print(value);
    });
  }
}
