import 'package:channab/backend/model/animal.dart';
import 'package:channab/screens/details/family.dart';
import 'package:channab/screens/details/gallery.dart';
import 'package:channab/screens/details/health.dart';
import 'package:channab/screens/myfarm/milking.dart';
import 'package:flutter/material.dart';

class AnimalDetails extends StatefulWidget {
  final AnimalModel animal;
  AnimalDetails({this.animal});

  @override
  _AnimalDetailsState createState() => _AnimalDetailsState();
}

class _AnimalDetailsState extends State<AnimalDetails> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.animal.tag.toUpperCase()),
            elevation: 0.0,
            actions: [
              IconButton(icon: Icon(Icons.edit), onPressed: (){}),
              IconButton(icon: Icon(Icons.notifications), onPressed: (){}),
              Switch(
                  value: status,
                  activeColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      status = value;
                    });
                  })
            ],
          ),
          body: SingleChildScrollView(            
              child: Column(
                mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 1,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 3,
                              color: Colors.blue,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(
                              2,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                image: NetworkImage(widget.animal.image),
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Wrap(
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    ListTile(
                                      leading: Text(
                                        widget.animal.type,
                                      ),
                                      trailing: Text(
                                        widget.animal.breed,
                                      ),
                                    ),
                                    ListTile(
                                      leading: Text(
                                        widget.animal.gender,
                                      ),
                                      trailing: Text(
                                        widget.animal.status == true
                                            ? "Active"
                                            : "Retired",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(widget.animal.tag),
                    ),
                    Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5, right: 0, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[200],
                                    spreadRadius: 1,
                                    blurRadius: 1)
                              ]),
                          child: TabBar(tabs: [
                            Tab(
                              child: Text(
                                "Health",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Family",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Milking",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Gallary",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        Health(),
                       Family(),
                        Milking(),
                        Gallery()
                      ]),
                    )
                  ],
                ),
              ),
            ],
          ))),
    );
  }
}
