import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:channab/screens/bottom/community.dart';
import 'package:channab/screens/bottom/home.dart';
import 'package:channab/screens/bottom/myfarm.dart';
import 'package:channab/screens/bottom/setting.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Bottom extends StatefulWidget {
  Bottom({Key key}) : super(key: key);

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation<double> animation;
  CurvedAnimation curve;
   var _bottomNavIndex = 0;
   @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  final iconList = <IconData>[
    Icons.home,
    FontAwesomeIcons.tractor,
    FlatIcons.users,
    FlatIcons.settings_4
  ];

  List<Widget>screen=[
    Home(),
    MyFarm(),
    Community(),
    Setting()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        height: 50,
        backgroundColor: Colors.white,
        activeIndex: _bottomNavIndex,
        activeColor: Colors.blue[500],
        splashColor: Colors.blue,
        inactiveColor: Colors.black38,
        notchAndCornersAnimation: animation,
        splashSpeedInMilliseconds: 300,      
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        onTap: (index) => setState(() => _bottomNavIndex = index),
      ),
      body: WillPopScope(onWillPop: ()async=>false,child: screen[_bottomNavIndex]),
    );
  }
}






