import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/block/shop_block.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/crud/order_head_crud.dart';
import 'package:shoplite1/form/order_detail_form.dart';
import 'package:shoplite1/model/order_head.dart';
import 'package:shoplite1/widgets/bottom_bar.dart';

class OrdersForm extends StatefulWidget {
  OrdersForm({Key? key, required this.selectedIndex}) : super(key: key);
  int selectedIndex;
  @override
  _OrdersFormState createState() => _OrdersFormState();
}

class _OrdersFormState extends State<OrdersForm> {
  List<order_head> list_head = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OrdersForm'),
      ),
      body: Center(
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          itemCount: list_head.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                print('OrdersForm  =>  orderId = ${list_head[index].id}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OrderDetailForm(order: list_head[index])),
                );
              },
              child: ListTile(
                leading: Text(
                  list_head[index].id.toString(),
                  style: txt20,
                ),
                title: Text(
                  dataFormat.format(list_head[index].data_order),
                  style: txt20,
                ),
                trailing: Text(
                  list_head[index].total_sum.toStringAsFixed(2),
                  style: txt20,
                ),
              ),
            );
          },
        ),
      ),

      // Center(
      //   child: Text(
      //     'OrdersForm',
      //     style: txt30,
      //   ),
      // ),
      bottomNavigationBar: const BottomBarGeneral(selectedIndex: 3),
    );
  }

  @override
  void initState() {
    super.initState();
    int userId = context.read<DataCubitShop>().getUser.id;
    OrderHeadCrud.getAll(userId).then((value) {
      list_head = value;
      setState(() {});
    });
  }
}
