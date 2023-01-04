import 'package:flutter/material.dart';

class BottomBarGeneral extends StatelessWidget {
  const BottomBarGeneral({
    Key? key,
    required int selectedIndex,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'ShopMain',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_shopping_cart_rounded),
          label: 'Card',
          backgroundColor: Colors.yellow,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business
              // IconData(0xf0564, fontFamily: 'MaterialIcons')
              ),
          label: 'Products',
          backgroundColor: Colors.red,
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.person),
        //   label: 'Login',
        //   backgroundColor: Colors.cyanAccent,
        // ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue[800],
      onTap: (value) {
        print(value);
        if (value == 0) {
          Navigator.pushNamed(context, '/ShopMain', arguments: value);
        } else if (value == 1) {
          Navigator.pushNamed(context, '/Cart', arguments: value);
        } else if (value == 2) {
          Navigator.pushNamed(context, '/ProductView', arguments: value);
        }

        // else if (value == 3) {
        //   Navigator.pushNamed(context, '/ProductAddEdit', arguments: value);
        //}

        // else if (value == 3) {
        //   Navigator.pushNamed(context, '/Login', arguments: value);
        // }
      },
    );
  }
}
