import 'package:flutter/material.dart';

class Family extends StatefulWidget {
  Family({Key key}) : super(key: key);

  @override
  _FamilyState createState() => _FamilyState();
}

class _FamilyState extends State<Family> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       body: SingleChildScrollView(
         child: Column(
           children: [
             ListTile(
               title: Text("Parents"),
             ),
            SingleChildScrollView( 
                 scrollDirection: Axis.horizontal,               
                 child: Row(
                   children: List.generate(2, (index) =>Wrap(children: [
                     Container(
                       margin: EdgeInsets.all(10),
                       height: 80,
                       width: 300,
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            spreadRadius: 1,
                            blurRadius: 1
                          )
                        ]
                       ),
                       child: Center(
                         child: ListTile(
                           contentPadding: EdgeInsets.all(5),
                           leading: CircleAvatar(
                             child: Icon(Icons.camera_alt),
                           ),
                           title: Text("Animal Tag number",style: TextStyle(fontSize: 13),),
                            trailing: RaisedButton(
                           elevation: 0.0,
                           color: Colors.blue,
                           onPressed: (){},child: Text("Male",style: TextStyle(color:Colors.white),),),
                         ),
                       ),
                     )
                   ],),
                 ),
               )),
               ListTile(
                 title: Text("Childs"),
               ),
               SingleChildScrollView(
                 child: Column(children:List.generate(5, (index) => Wrap(
                   children: [
                     Container(
                       child: ListTile(
                         leading: CircleAvatar(child: Icon(Icons.camera_alt)),
                         title: Text("Animal Tag number"),
                         trailing: RaisedButton(
                           elevation: 0.0,
                           color: Colors.blue,
                           onPressed: (){},child: Text("Male",style: TextStyle(color:Colors.white),),),
                       ),
                     )
                   ],
                 )),),
               )
             
           ],
         ),
       ),
    );
  }
}