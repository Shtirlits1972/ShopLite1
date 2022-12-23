import 'package:flutter/material.dart';
import 'package:shoplite1/constants.dart';

class CheckboxWidget extends StatefulWidget {
  final Function(bool) callback;

  const CheckboxWidget({Key? key, required this.callback}) : super(key: key);

  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool _checkbox = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Checkbox(
            value: _checkbox,
            onChanged: (value) {
              widget.callback(value!);
              setState(() => _checkbox = !_checkbox);
            }),
        Text(
          'Remember me',
          style: txt30,
        )
      ],
    );

    // CheckboxListTile(
    //   title:  Text(
    //     'Remember me',
    //     style: txt30,
    //   ),
    //   value: _checkbox,
    //   onChanged: (value) {
    //     widget.callback(value!);
    //     setState(() => _checkbox = !_checkbox);
    //   },
    // );
  }
}
