import 'dart:io';

import 'package:channab/backend/config/urls.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimalConfig{
  static getAnimalList()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String url=UrlConfig.baseUrl+UrlConfig.animalListUrl;
    return http.get(url,headers: {
      'token':pref.getString('token')
    });
  }
  static getAnimalCategory()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  String url=UrlConfig.baseUrl+UrlConfig.allAnimalCategory;
    return http.get(url,headers: {
      'token':pref.getString('token')
    });
  }
static getAnimalParent(int id)async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  String url=UrlConfig.baseUrl+UrlConfig.getParentUrl+"category_id=$id";
    return http.get(url,headers: {
      'token':pref.getString('token')
    });
  }

  static filterAnimalById(int id)async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  String url=UrlConfig.baseUrl+UrlConfig.animalByCategory+"=$id";
    return http.get(url,headers: {
      'token':pref.getString('token')
    });
  }
 static addAnimal(var body,File file)async{
       final mineData = lookupMimeType(file.path, headerBytes: [0xFF, 0xD8]).split("/");
    var image = await http.MultipartFile.fromPath("main_image", file.path,contentType: MediaType(mineData[0], mineData[1]));
     SharedPreferences pref=await SharedPreferences.getInstance();
      String url = UrlConfig.baseUrl + UrlConfig.addAnimalUrl;
    Map<String, String> headers = <String, String>{
      'token':pref.getString('token')
    };
     Map<String, String> requestBody = body;
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)..files.add(image)
      ..fields.addAll(requestBody);
    return request.send();

  }
}