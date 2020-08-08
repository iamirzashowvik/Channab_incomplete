import 'package:channab/screens/auth/login.dart';
import 'package:channab/screens/bottom/bottom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() { 
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      decideScreen();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(child: Center(
         child: Image.asset("assets/images/splash.png"),
       )),
    );
  }
  decideScreen()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.getBool('islogedin')==false|| pref.getBool('islogedin')==null?Navigator.push(context, MaterialPageRoute(builder: (_)=>LogIn())):Navigator.push(context, MaterialPageRoute(builder: (_)=>Bottom()));
  }
}