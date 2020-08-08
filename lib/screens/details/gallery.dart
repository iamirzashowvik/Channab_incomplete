import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          FlatButton(onPressed: (){}, child: Icon(FlatIcons.photo_camera))
        ],
      ),
      body: GridView.count(crossAxisCount: 2,children: List.generate(10, (index) =>
          Stack(
            children: [
              Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[100],
              spreadRadius: 1,
              blurRadius: 1
            )
          ]
        ),
      ),
      Positioned(child: IconButton(icon: Icon(Icons.delete_outline), onPressed: (){  }))
            ],
          )
        
      
      ),),
    );
  }
}