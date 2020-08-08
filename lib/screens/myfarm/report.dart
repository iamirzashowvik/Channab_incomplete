import 'package:flutter/material.dart';

class MyReport extends StatefulWidget {
  MyReport({Key key}) : super(key: key);

  @override
  _MyReportState createState() => _MyReportState();
}

class _MyReportState extends State<MyReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton.extended(onPressed: (){}, label: Text("Add Report")),
    );
  }
}