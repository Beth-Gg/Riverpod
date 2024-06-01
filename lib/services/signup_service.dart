import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future signUp(String username, String password, String role, context) async {
  final response = await http.post(
      Uri.parse('http://192.168.253.42:6036/user/signup'),
      headers:{'Authorizaton': '' },
      body: {
        'username': username,
        'password': password,
        'role': role,
      },
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  

  
}
