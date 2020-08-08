import 'dart:convert';

import 'package:channab/backend/config/animal.dart';
import 'package:channab/backend/model/animal.dart';
import 'package:channab/screens/myfarm/animal.dart';
import 'package:channab/screens/myfarm/filterresult.dart';
import 'package:channab/screens/myfarm/milking.dart';
import 'package:channab/screens/myfarm/report.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyFarm extends StatefulWidget {
  MyFarm({Key key}) : super(key: key);

  @override
  _MyFarmState createState() => _MyFarmState();
}

class _MyFarmState extends State<MyFarm> {
  int _index=0;
  String animalType="Male";
  String workingstatus="Active";
  String age="less than 3 months";
  String status="Milking";
   List<AnimalModel>animalList=[];
   @override
   void initState() { 
     super.initState();
     getList();
   }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:3 ,
          child: Scaffold(
        appBar: AppBar(
          title: Text("MyFarm"),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          actions: [
            _index==0?FlatButton(onPressed: (){
              showFilterSheet(animalList);
            }, child: Text("Filters",style: TextStyle(color: Colors.white),)):Container()
          ],
          bottom: TabBar(
            onTap: (index)=>setState((){_index=index;}),
            tabs: [
            Tab(              
              child: Text("Animals"),),
            Tab(child: Text("Milking"),),
            Tab(child: Text("Reports"),),
          ]),
        ),
        body: TabBarView(children: [
          MyAnimal(),
          Milking(),
          MyReport()
        ]),
      ),
    );
  }
  showFilterSheet(List<AnimalModel> animals){
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
      isDismissible: false,
      context: context, builder:(_)=>StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Wrap(
          children: [
            ListTile(
              title: Text("Apply Filter",textAlign: TextAlign.center ,),
             trailing: IconButton(icon: Icon(Icons.close,color: Colors.blue,), onPressed: ()=>Navigator.pop(context)),
            ),
            ListTile(
              title: Text("Animal Type"),
              trailing: DropdownButton(
                value: animalType,
                underline: Container(),
                items: [
                DropdownMenuItem(child: Text("Male"),value: "Male",),
                DropdownMenuItem(child: Text("Female"),value: "Female",),
              ], onChanged: (value){
                setState((){
                  animalType=value;
                });
              }),
            ),
            ListTile(
              title: Text("Status"),
              trailing: DropdownButton(
                value: workingstatus,
                underline: Container(),
                items: [
                DropdownMenuItem(child: Text("Active"),value: "Active",),
                DropdownMenuItem(child: Text("Retired"),value: "Retired",),
              ], onChanged: (value){
                setState((){
                  workingstatus=value;
                });
              }),
            ) ,
            ListTile(
              title: Text("Animal Status"),
              trailing: DropdownButton(
                value: status,
                underline: Container(),
                items: [
                DropdownMenuItem(child: Text("Milking"),value: "Milking",),
                DropdownMenuItem(child: Text("Dry"),value: "Dry",),
              ], onChanged: (value){
                setState((){
                  status=value;
                });
              }),
            ) ,
             ListTile(
              title: Text("Age"),
              trailing: DropdownButton(
                value: age,
                underline: Container(),
                items: [
                DropdownMenuItem(child: Text("less than 3 months"),value: "less than 3 months",),
                DropdownMenuItem(child: Text("less than 6 months"),value: "less than 6 months",),
                DropdownMenuItem(child: Text("less than 1 year"),value: "less than 1 year",),
                DropdownMenuItem(child: Text("less than 1.6 years"),value: "less than 1.6 years",),
                DropdownMenuItem(child: Text("greater than 1.6 years"),value: "greater than 1.6 years",),
              ], onChanged: (value){
                setState((){
                  age=value;
                });
              }),
            ) ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: (){
                    var data=animals.where((a) =>a.gender==animalType||a.type==status).toList();                 
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>FilterResult(animals: data,)));
                    },
                    child: Container(
                    height: 50,
                    width: 200,
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    padding: EdgeInsets.only(left: 10,right: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: Text("Apply",style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            )         
               ],
        );
      },
    ),);
  }
   getList()async{
    http.Response response =await AnimalConfig.getAnimalList();
    if(response.statusCode==200){
      var data=json.decode(response.body);
      setState(() {
        animalList=(data['all_animal_list'] as List).map((e) => AnimalModel.fromApi(e)).toList();
       
      });
    }    
  }
}