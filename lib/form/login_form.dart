import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoplite1/block/shop_block.dart';
import 'package:shoplite1/constants.dart';
import 'package:shoplite1/crud/users_crud.dart';
import 'package:shoplite1/model/users.dart';
import 'package:shoplite1/widgets/bottom_bar.dart';
import 'package:shoplite1/widgets/check_box_user.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

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
                Container(
                  width: 150,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    onPressed: () async {
                      print(
                          'login = ${loginController.text}, password = ${passwordController.text}');
                      print('isCheckedFrm = $isCheckedFrm');
                      UsersCrud.LoginUser(
                              loginController.text, passwordController.text)
                          .then((value) {
                        if (value != null && value.id > 0) {
                          context.read<DataCubitShop>().setCurrentUser(value);
                          Navigator.pushNamed(context, '/ShopMain',
                              arguments: 1);
                        } else {
                          showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Warning!'),
                              content: const Text('Chack Login and Password!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      });
                    },
                    child: Text(
                      'login',
                      style: txt30,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TextButton(
                    onPressed: () async {
                      //==================================

                      if (loginController.text.trim().isEmpty ||
                          passwordController.text.trim().isEmpty) {
                        showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Warning!'),
                            content: const Text(
                                'Login and Password can not be empty!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        // print('Login and Password can not be empty!');
                      } else {
                        users usr = users(0, loginController.text,
                            passwordController.text, isCheckedFrm);

                        UsersCrud.add(usr).then((value) {
                          if (value != null && value.id > 0) {
                            context.read<DataCubitShop>().setCurrentUser(value);
                            print(value);
                            Navigator.pushNamed(context, '/ShopMain',
                                arguments: 1);
                          } else {
                            print('user not correct');
                          }
                        });
                        //==================================

                      }
                    },
                    child: Text(
                      'register',
                      style: txt30,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )),
      // bottomNavigationBar: const BottomBarGeneral(selectedIndex: 3),
    );
  }
}
