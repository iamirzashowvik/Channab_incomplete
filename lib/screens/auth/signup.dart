import 'dart:convert';

import 'package:channab/backend/auth/authorization.dart';
import 'package:channab/screens/Animation/FadeAnimation.dart';
import 'package:channab/screens/auth/login.dart';
import 'package:channab/screens/bottom/bottom.dart';
import 'package:channab/screens/shared/loading.dart';
import 'package:channab/screens/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey();
  GlobalKey<State> _loader = new GlobalKey<State>();
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  bool showpassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                         SizedBox(height: 20),
                        FadeAnimation(
                            1,
                            Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 30),
                            )),
                        SizedBox(height: 50),
                        FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[200],
                                      blurRadius: 20,
                                      spreadRadius: 20,
                                    )
                                  ]),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: _phoneController,
                                        validator: (value) => value.isEmpty
                                            ? "Please enter  mobile"
                                            : null,
                                        decoration: InputDecoration(
                                            hintText: "Mobile",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            suffixIcon: Icon(Icons.phone)),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: _emailController,
                                        validator: (value) => value.isEmpty
                                            ? "Please enter  email"
                                            : null,
                                        decoration: InputDecoration(
                                            hintText: "Email",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            suffixIcon: Icon(Icons.email)),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        obscureText: showpassword,
                                        controller: _passwordController,
                                        validator: (value) => value.isEmpty
                                            ? "Please enter password"
                                            : null,
                                        decoration: InputDecoration(
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            suffixIcon: IconButton(
                                                icon: showpassword == true
                                                    ? Icon(Icons.remove_red_eye)
                                                    : Icon(FontAwesomeIcons
                                                        .solidEyeSlash),
                                                onPressed: () {
                                                  setState(() {
                                                    showpassword =
                                                        !showpassword;
                                                  });
                                                })),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: _confirmPasswordController,
                                        obscureText: showpassword,
                                        validator: (value) => value !=
                                                _passwordController.text
                                            ? "password and confirm password don't match"
                                            : value.isEmpty
                                                ? "Confirm password can't be empty"
                                                : null,
                                        decoration: InputDecoration(
                                            hintText: "Confirm Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            suffixIcon: Icon(Icons.lock)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1,
                            GestureDetector(
                              onTap: () {
                               signUp();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue),
                                child: Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 60,
                        ),                        
                      
                        
                        FadeAnimation(
                          1,
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => LogIn()));
                            },
                            child: Center(
                              child: Text(
                                "Already have an account? Log in",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  signUp() async{
     Dialogs.showLoadingDialog(context, _loader);
  try {
  var  response=await Authorization.signUp(_phoneController.text, _passwordController.text,_emailController.text);
  http.Response res=await http.Response.fromStream(response);
  var data=json.decode(res.body);
  if(data['status']==200){
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString('token',data['token']);
    pref.setString('email', data['user_email']);
    pref.setString('phone', data['phone']);
    pref.setBool('islogedin',true);
    Navigator.of(_loader.currentContext,rootNavigator: true).pop();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Bottom()));
  }
  } catch (e) {
     Navigator.of(_loader.currentContext,rootNavigator: true).pop();
    Mytoast.customToast("Fail to register.Try again");
  }
 
   
  }
}
 

