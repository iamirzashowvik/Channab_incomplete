import 'package:channab/backend/config/urls.dart';
import 'package:http/http.dart' as http;

class Authorization {
  static login(String phone, String password) async {
    String url = UrlConfig.baseUrl + UrlConfig.loginUrl;
    Map<String, String> headers = <String, String>{
      'x-api-key': '9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b'
    };
     Map<String, String> requestBody = <String,String>{
     'mobile_number':phone,
     'password':password
  };
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields.addAll(requestBody);
    return request.send();
  }
  static signUp(String phone, String password,String email) async {
    String url = UrlConfig.baseUrl + UrlConfig.loginUrl;
    Map<String, String> headers = <String, String>{
      'x-api-key': '9944b09199c62bcf9418ad846dd0e4bbdfc6ee4b'
    };
     Map<String, String> requestBody = <String,String>{
     'mobile_number':phone,
     'password':password,
     'email':email
  };
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields.addAll(requestBody);
    return request.send();
  }
}
