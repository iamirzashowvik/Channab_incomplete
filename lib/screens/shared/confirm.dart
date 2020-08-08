import 'package:flutter/material.dart';

class Confirm {
  static confirmDialog(BuildContext context, String message, Function onTap) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        child: AlertDialog(
          title: Text("Biguul"),
          actions: <Widget>[FlatButton(onPressed: onTap, child: Text("Ok"))],
          content: Container(
            child: Text(message),
          ),
        ));
  }
}
