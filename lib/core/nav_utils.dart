import 'package:flutter/material.dart';

class NavUtils{

  static void push(BuildContext context, Widget widget){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return widget;
      },
    ));
  }
}