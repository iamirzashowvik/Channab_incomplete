import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Mytoast{
  static  customToast(String msg){
    return Fluttertoast.showToast(msg:msg,toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM,backgroundColor: Colors.blue);
  }
}