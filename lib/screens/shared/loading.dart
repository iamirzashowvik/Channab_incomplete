import 'dart:async';
import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => true,
              child: SimpleDialog(key: key,                               
                  children: <Widget>[
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey[900]),
                        ),
                        Text("Please wait ...")
                      ],
                    ),
                    SizedBox(height: 5,)
                  ]));
        });
  }
}
