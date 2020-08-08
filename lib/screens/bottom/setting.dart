import 'package:channab/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("Setting"),
       automaticallyImplyLeading: false,
       elevation: 0.0,
     ),
     body: ListView(
       children: [
         ListTile(
           title: Text("Edit Profile"),
           leading: Icon(Icons.person),
         ),
         ListTile(title: Text("Change Password"),leading:Icon(Icons.lock) ,),
         ListTile(
           title: Text("Log Out"),
           leading: Icon(Icons.lock_open),
           onTap: ()async{
             SharedPreferences pref=await SharedPreferences.getInstance();
             setState(() {
               pref.setBool('islogedin', false).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LogIn())));
             });
             
           },
         )
       ],
     ),
    );
  }
}