import 'dart:convert';
import 'package:channab/backend/auth/authorization.dart';
import 'package:channab/backend/model/user.dart';
import 'package:channab/screens/Animation/FadeAnimation.dart';
import 'package:channab/screens/auth/signup.dart';
import 'package:channab/screens/bottom/bottom.dart';
import 'package:channab/screens/shared/loading.dart';
import 'package:channab/screens/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  GlobalKey<State> _loader = new GlobalKey<State>();
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  CurrentUser user=CurrentUser();
  bool showpassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Container(
            width: double.infinity,
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
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1,
                                Text(
                                  "Login",
                                  style: TextStyle(fontSize: 30),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1,
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[200],
                                          spreadRadius: 20,
                                          blurRadius: 20,
                                        )
                                      ]),
                                  child: Form(
                                    key: _key,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            controller: _emailController,
                                            keyboardType: TextInputType.number,
                                            validator: (value) {
                                              return value.isEmpty
                                                  ? "Please enter a valid number"
                                                  : null;
                                            },
                                            decoration: InputDecoration(
                                                hintText: "Mobile",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none,
                                                suffixIcon: Icon(
                                                  Icons.email,
                                                  color: Colors.blue,
                                                )),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color:
                                                          Colors.grey[200]))),
                                          child: TextFormField(
                                            controller: _passwordController,
                                            validator: (value) {
                                              return value.isEmpty
                                                  ? "Please enter a valid password"
                                                  : null;
                                            },
                                            obscureText: showpassword,
                                            decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none,
                                                suffixIcon: IconButton(
                                                  icon: showpassword == true
                                                      ? Icon(
                                                          FontAwesomeIcons.eye)
                                                      : Icon(FontAwesomeIcons
                                                          .eyeSlash),
                                                  onPressed: () {
                                                    setState(() {
                                                      showpassword =
                                                          !showpassword;
                                                    });
                                                  },
                                                )),
                                          ),
                                        ),
                                        FadeAnimation(
                                            1,
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors
                                                              .grey[200]))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  GestureDetector(
                                                      onTap: () {
                                                        resetSheet();
                                                      },
                                                      child: Text(
                                                          "Forgot Password")),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                                1,
                                GestureDetector(
                                  onTap: () {
                                    logIn();
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                              1,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Expanded(
                                      child: Divider(
                                    thickness: 2,
                                    height: 1,
                                    color: Colors.black38,
                                  )),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "OR",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                      child: Divider(
                                    thickness: 2,
                                    height: 1,
                                    color: Colors.black38,
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1,
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue[900]),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            "Login with Facebook",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(FontAwesomeIcons.facebookSquare,
                                              color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            FadeAnimation(
                                1,
                                GestureDetector(
                                  onTap: () {
                                   
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.red[700]),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            "Login with Google",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Icon(FontAwesomeIcons.google,
                                              color: Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            FadeAnimation(
                                1,
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => SignUp()));
                                  },
                                  child: Center(
                                    child: Text(
                                      "Need an account? Sign up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
logIn()async{
  Dialogs.showLoadingDialog(context, _loader);
  try {
  var  response=await Authorization.login(_emailController.text, _passwordController.text);
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
    Mytoast.customToast("Fail to login.Try again");
  }
 
}
  resetSheet() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(title: Text("Enter your email")),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey[200]))),
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        return value.isEmpty
                            ? "Please enter a valid email"
                            : null;
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.email)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                     
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue[900]),
                      child: Center(
                        child: Text(
                          "Reset",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  
}
