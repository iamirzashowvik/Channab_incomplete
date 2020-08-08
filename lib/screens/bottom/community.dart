import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  Community({Key key}) : super(key: key);

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
        automaticallyImplyLeading: false,
      ),
    );
  }
}