import 'package:flutter/material.dart';

class MySnackBar {
 static showSnackBar(BuildContext context, key, String text) {
    return key.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blue[900],
      content: Text(
        '$text',
        style: TextStyle(color: Colors.white),
      ),
    ));
  }
}
