import 'package:flutter/material.dart';

class Navigate {
  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void pop(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }
}
