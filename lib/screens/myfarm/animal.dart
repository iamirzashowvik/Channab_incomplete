import 'dart:convert';

import 'package:channab/backend/config/animal.dart';
import 'package:channab/backend/model/animal.dart';
import 'package:channab/screens/myfarm/addanimal.dart';
import 'package:channab/screens/myfarm/animaldetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyAnimal extends StatefulWidget {
  MyAnimal({Key key}) : super(key: key);

  @override
  _MyAnimalState createState() => _MyAnimalState();
}

class _MyAnimalState extends State<MyAnimal> {
  List<AnimalModel>animalList=[];
  List<AnimalModel>filteranimalList=[];
  bool loading=true;
  List<String>categories=['All','Cow','Buffalo','Goat','Horse','Sheep',"Others"];
  String currentCat="All";
  @override
  void initState() { 
    super.initState();
    getList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (_)=>AddAnimal()));
      }, label: Text("Add Animal")),
      body:loading==true?Center(child: CircularProgressIndicator(),): animalList.length==0?Center(child: Text("No animal"),):SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (_,index)=>GestureDetector(
                        onTap: (){
                          setState(() {
                            currentCat=categories[index];
                            filterAnimal(getId(currentCat));                            
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 10,right: 10),
                          decoration: BoxDecoration(
                            color:currentCat==categories[index]?Colors.blue:Colors.grey,
                            borderRadius: BorderRadius.circular(25)
                          ),
                          margin: EdgeInsets.all(10),
                          child: Center(
                            child: Text(categories[index],style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ))
                  ),                 
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
          itemCount:currentCat=="All"?animalList.length:filteranimalList.length,
          itemBuilder: (_,index)=>Wrap(children: [
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[200],
                        blurRadius: 1,
                        spreadRadius: 1
                      )
                    ]
            ),
            child: Column(
                    children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(currentCat=="All"?animalList[index].image:filteranimalList[index].image),
                      ),
                      title:Text(animalList[index].tag),
                      trailing: Container(
                            height: 30,
                            width: 70,
                           decoration: BoxDecoration(
                              color: animalList[index].type.toLowerCase()=="milking"?Colors.green:animalList[index].type.toLowerCase()=="dry"?Colors.yellow:Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                           ),
                            child: Center(
                              child: Text(currentCat=="All"?animalList[index].type:filteranimalList[index].type,style: TextStyle(color: Colors.white,fontSize: 12),),
                            ),
                          ),
                          
                      
                      subtitle: Text(currentCat=="All"?animalList[index].gender:filteranimalList[index].gender),
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>AnimalDetails(animal:currentCat=="All"?animalList[index]:filteranimalList[index],))),
                    )
            ],),
          )
        ],)),
                  ),
                ],
              ),
      ),
    );
  }
  getList()async{
    http.Response response =await AnimalConfig.getAnimalList();
    if(response.statusCode==200){
      var data=json.decode(response.body);
      setState(() {
        animalList=(data['all_animal_list'] as List).map((e) => AnimalModel.fromApi(e)).toList();
        loading=false;
      });
    }    
  }
  filterAnimal(int id)async{
    setState(() {
      loading=true;
    });
    http.Response res=await AnimalConfig.filterAnimalById(id);
    print(res.body);
     if(res.statusCode==200){
      var data=json.decode(res.body);
      setState(() {
        filteranimalList=(data['filtered_animals'] as List).map((e) => AnimalModel.fromApi(e)).toList();
        loading=false;
      });
    }    
  }
  getId(String cat){
   return cat!="All"&&cat=="Cow"?19:cat=="Goat"&&cat!="All"?17:cat=="Buffalo"&&cat!="All"?18:cat=="Sheep"&&cat!="All"?16:cat=="Horse"&&cat!="All"?15:14;
  }
}