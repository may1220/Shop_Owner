import 'package:flutter/material.dart';

class AppUtils {
  static void showSnackBar(String title, ScaffoldState state,
      {Color bgColor = Colors.black, Color textColor = Colors.white}) {
    state.showSnackBar(SnackBar(
      content: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      backgroundColor: bgColor,
    ));
  }
}
