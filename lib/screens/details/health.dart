import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';

class Health extends StatefulWidget {
  Health({Key key}) : super(key: key);

  @override
  _HealthState createState() => _HealthState();
}

class _HealthState extends State<Health> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          FlatButton(onPressed: (){}, child: Icon(FlatIcons.add,)),
          FlatButton(onPressed: (){}, child: Icon(FlatIcons.edit)),
        ],
      ),  
      body: Center(
        child: Text("No information avilable"),
      ),   
     
    );
  }
}