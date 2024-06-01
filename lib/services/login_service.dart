import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../presentation/pages/shops/admin_shops_page.dart';
import 'package:go_router/go_router.dart';

// import '';
class LoginServicess {
  Future login(String username, String password, String role, context) async {
    final response = await http.post(
      Uri.parse('http://localhost:6036/auth/login'),
      body: {
        'username': username,
        'password': password
        // 'role': role,
      },
    );

    if (response.statusCode == 201) {
      // Handle successful signup
      print(response);
     context.go('/shops');
     
    } else {
      // Handle signup failure
      throw Exception(FlutterError.presentError);
    }
  }
}
