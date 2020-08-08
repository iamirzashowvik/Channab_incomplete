import 'dart:convert';
import 'dart:io';

import 'package:channab/backend/config/animal.dart';
import 'package:channab/backend/model/category.dart';
import 'package:channab/screens/shared/loading.dart';
import 'package:channab/screens/shared/toast.dart';
import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddAnimal extends StatefulWidget {
  AddAnimal({Key key}) : super(key: key);

  @override
  _AddAnimalState createState() => _AddAnimalState();
}

class _AddAnimalState extends State<AddAnimal> {
  TextEditingController _tagController = TextEditingController();
  // TextEditingController _costController = TextEditingController();
  // TextEditingController _descriptionController = TextEditingController();
  GlobalKey<State> _loader = GlobalKey<State>();
  List<CategoriesModel> categories = [];
  List<FemaleModel> females = [];
  List<MaleModel> males = [];
  String male;
  String female;
  String currentCat;
  String gender;
  File _file;
  String _date;
  String type;
  @override
  void initState() {
    super.initState();
    // getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Animal"),
        elevation: 0.0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    choice();
                  },
                  child: Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      margin: EdgeInsets.only(left: 0, right: 0, top: 20),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _file == null
                            ? Image.asset(
                                "assets/images/p.png",
                                fit: BoxFit.cover,
                                height: 200,
                                width: 200,
                              )
                            : Image.file(
                                _file,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                _file != null
                    ? Positioned(
                        left: 160,
                        top: 10,
                        child: CircleAvatar(
                            child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _file = null;
                                  });
                                })))
                    : Container()
              ],
            ),
          ),
          myCustomTextField(
              "Animal Tag No", "Enter animal tag number", _tagController),
          ListTile(
            leading: Text("DOB"),
            title: _date == null ? Container() : Text(_date),
            trailing: IconButton(
                icon: Icon(Icons.cake),
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100))
                      .then((date) {
                    setState(() {
                      _date = date.toString().split(" ")[0];
                    });
                  });
                }),
          ),
          // ListTile(leading: Text("Purchase Date"),trailing: IconButton(icon: Icon(Icons.cake), onPressed: (){}),),
          ListTile(
            leading: Text("Category"),
            trailing: categories.length == 0
                ? CircularProgressIndicator()
                : DropdownButton<String>(
                    underline: Container(),
                    hint: Text("Category"),
                    value: currentCat,
                    items: categories
                        .map((e) => DropdownMenuItem<String>(
                              child: Text(e.name),
                              value: e.name,
                              onTap: () {
                                //getParent(e.id);
                              },
                            ))
                        .toList(),
                    onChanged: (String value) {
                      setState(() {
                        print(value);
                        currentCat = value;
                      });
                    }),
          ),
          ListTile(
            leading: Text("Gender"),
            trailing: DropdownButton(
                hint: Text("Gender"),
                underline: Container(),
                value: gender,
                items: [
                  DropdownMenuItem(
                    child: Text("Male"),
                    value: "Male",
                  ),
                  DropdownMenuItem(
                    child: Text("Female"),
                    value: "Female",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                }),
          ),
          ListTile(
            leading: Text("Animal Type"),
            trailing: DropdownButton(
                hint: Text("Type"),
                value: type,
                underline: Container(),
                items: [
                  DropdownMenuItem(
                    child: Text("Dry"),
                    value: "Dry",
                  ),
                  DropdownMenuItem(
                    child: Text("Milking"),
                    value: "Milking",
                  ),
                  DropdownMenuItem(
                    child: Text("None"),
                    value: "None",
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    type = value;
                  });
                }),
          ),
          GestureDetector(
            onTap: () => addAnimal(_file),
            child: Container(
              height: 50,
              margin: EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 50),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Text(
                  "Add",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          )

          // ListTile(
          //   title: Text("Male Parent"),
          //   trailing: males.length==0?Text("No Data"):DropdownButton<String>(
          //   underline: Container(),
          //   hint: Text("Male"),
          //   value: male,
          //   items: males.map((e) => DropdownMenuItem<String>(
          //     child: Text(e.tag),value:e.tag,onTap: (){
          //     },)).toList(), onChanged: (String value){
          //   setState(() {
          //     print(value);
          //     male=value;
          //   });
          // }
          // ),
          // ),
          //  ListTile(
          //   title: Text("Female Parent"),
          //   trailing: females.length==0?Text("No Data"):DropdownButton<String>(
          //   underline: Container(),
          //   value: female,
          //   hint: Text("Female"),
          //   items: females.map((e) => DropdownMenuItem<String>(
          //     child: Text(e.tag),value:e.tag,onTap: (){
          //     },)).toList(), onChanged: (String value){
          //   setState(() {
          //     print(value);
          //     female=value;
          //   });
          // }
          // ),
          // ),
          // myCustomTextField("Cost of Purchase", "Enter cost of purchase", _costController),
          // myCustomTextField("Description", "Enter description", _descriptionController),
        ],
      ),
    );
  }

  myCustomTextField(
      String label, String hint, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        validator: (value) => value.isEmpty ? "Please enter $label" : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          labelText: label,
        ),
      ),
    );
  }

  // getCategory() async {
  //   http.Response response = await AnimalConfig.getAnimalCategory();
  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);
  //     setState(() {
  //       categories = (data['all_categories'] as List)
  //           .map((e) => CategoriesModel.fromApi(e))
  //           .toList();
  //     });
  //   }
  // }

  getParent(int id) async {
    setState(() {
      males = [];
      females = [];
    });
    http.Response response = await AnimalConfig.getAnimalParent(id);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      setState(() {
        females = (data['female'] as List)
            .map((e) => FemaleModel.fromApi(e))
            .toList();
        males =
            (data['male'] as List).map((e) => MaleModel.fromApi(e)).toList();
      });
    }
  }

  choice() {
    return showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (BuildContext context, setState) {
          return AlertDialog(
            title: Text(
              "Choose",
              textAlign: TextAlign.center,
            ),
            content: Wrap(
              children: [
                ListTile(
                  leading: Icon(FlatIcons.photo_camera),
                  title: Text(
                    "Camera",
                  ),
                  onTap: () => chooseImage(true),
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text(
                    "Gallery",
                  ),
                  onTap: () => chooseImage(false),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  chooseImage(bool isCamera) async {
    var _picker = ImagePicker();
    if (isCamera) {
      var file = await _picker.getImage(source: ImageSource.camera);
      if (file != null) {
        setState(() {
          _file = File(file.path);
        });
        Navigator.pop(context);
      }
    } else {
      var file = await _picker.getImage(source: ImageSource.gallery);
      if (file != null) {
        setState(() {
          _file = File(file.path);
        });
        Navigator.pop(context);
      }
    }
  }

  addAnimal(File file) async {
    if (file != null) {
      try {
        Dialogs.showLoadingDialog(context, _loader);
        Map<String, String> body = {
          "animal_tag": _tagController.text,
          "age": _date,
          // "category": currentCat,
          "gender": gender,
          "animal_type": type,
        };

        var res = await AnimalConfig.addAnimal(body, file);
        http.Response response = await http.Response.fromStream(res);
        var data = json.decode(response.body);
        print(data);
        if (response.statusCode == 200) {
          Navigator.of(_loader.currentContext, rootNavigator: true).pop();
          Mytoast.customToast("Animal added sucessfully");
          Navigator.pop(context);
        }
      } catch (e) {
        Navigator.of(_loader.currentContext, rootNavigator: true).pop();
        Mytoast.customToast("fail to add animal");
      }
    } else {
      Mytoast.customToast("Please choose animal image");
    }
  }
}
