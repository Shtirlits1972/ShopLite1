import 'package:flutter/material.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/widgets/bottom_bar.dart';

class ShopMain extends StatelessWidget {
  ShopMain({Key? key, required this.selectedIndex}) : super(key: key);

  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ShopMain'),
      ),
      body: Center(
        child: Text(
          'ShopMain',
          style: txt30,
        ),
      ),
      bottomNavigationBar: BottomBarGeneral(selectedIndex: selectedIndex),
    );
  }
}
