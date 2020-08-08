import 'package:channab/backend/model/animal.dart';
import 'package:channab/screens/myfarm/animaldetails.dart';
import 'package:flutter/material.dart';

class FilterResult extends StatefulWidget {
 final  List<AnimalModel>animals;
  FilterResult({this.animals});

  @override
  _FilterResultState createState() => _FilterResultState();
}

class _FilterResultState extends State<FilterResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Avilable Result"),
      ),
      body: ListView.builder(
        itemCount: widget.animals.length,
        itemBuilder: (_,index){
        return Wrap(children: [
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
                        backgroundImage: NetworkImage(widget.animals[index].image),
                      ),
                      title:Text(widget.animals[index].tag),
                      trailing: Container(
                            height: 30,
                            width: 70,
                           decoration: BoxDecoration(
                              color: widget.animals[index].type.toLowerCase()=="milking"?Colors.green:widget.animals[index].type.toLowerCase()=="dry"?Colors.yellow:Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                           ),
                            child: Center(
                              child: Text(widget.animals[index].type,style: TextStyle(color: Colors.white,fontSize: 12),),
                            ),
                          ),
                          
                      
                      subtitle: Text(widget.animals[index].gender),
                      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>AnimalDetails(animal:widget.animals[index],))),
                    )
            ],),
          )
        ],);
      }),
    );
  }
}