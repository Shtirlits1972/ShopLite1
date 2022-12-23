import 'package:flutter/material.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/widgets/bottom_bar.dart';
import 'package:shoplite1/widgets/check_box_user.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key, required this.selectedIndex}) : super(key: key);
  int selectedIndex;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController loginController = TextEditingController(text: '');
    TextEditingController passwordController = TextEditingController(text: '');
    bool isCheckedFrm = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: txt20,
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'LOGIN',
            style: txt30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: loginController,
              style: txt20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 30),
            child: Text(
              'Password',
              style: txt30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: passwordController,
              style: txt20,
            ),
          ),
          CheckboxWidget(callback: (value) => isCheckedFrm = value),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    print('isCheckedFrm = $isCheckedFrm');
                  },
                  child: Text(
                    'login',
                    style: txt30,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('register');
                  },
                  child: Text(
                    'register',
                    style: txt30,
                  ),
                ),
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: const BottomBarGeneral(selectedIndex: 3),
    );
  }
}
