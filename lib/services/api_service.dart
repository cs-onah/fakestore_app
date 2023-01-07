import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/models/user_login.dart';

class ApiService{
  static const String baseUrl = 'https://fakestoreapi.com';
  static const headers = {'Content-type': 'application/json'};

  Future<dynamic> login(String username, String password) async {
    final params = UserLogin(username: username, password: password);
    return http.post(Uri.parse('$baseUrl/auth/login'), body: params.toJson())
        .then((data){
      if(data.statusCode == 200){
        final jsonData = json.decode(data.body);
        return jsonData;
      }
    }).catchError((error)=> print(error));

  }
}