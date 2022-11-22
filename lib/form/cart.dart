import 'package:flutter/material.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/widgets/bottom_bar.dart';

class Cart extends StatelessWidget {
  Cart({Key? key, required this.selectedIndex}) : super(key: key);
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
      ),
      body: Center(
        child: Text(
          'Cart',
          style: txt30,
        ),
      ),
      bottomNavigationBar: const BottomBarGeneral(selectedIndex: 1),
    );
  }
}
