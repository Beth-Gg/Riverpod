import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final authoProvider = Provider((ref) => AuthService());

class AuthService {
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('access_token', value);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<bool> setID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('id', value);
  }

  Future<String?> getID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  Future<void> login(
      String username, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.253.42:6036/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final token = responseBody['access_token'];
        final userId = responseBody['id'];

        await setToken(token);
        await setID(userId);
        // print(token);

        final role = _decodeRoleFromToken(token);
        _navigateToRolePage(role, context);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      // print('Error: $e');
      throw Exception('Network error: Failed to login');
    }
  }

  String _decodeRoleFromToken(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken['role']; 
    } catch (e) {
      throw Exception('Failed to decode token');
    }
  }

  void _navigateToRolePage(String role, BuildContext context) {
    if (role == 'admin') {
      context.go('/shops');
    } else if (role == 'user') {
      context.go('/userNav');
    } else {
      throw Exception('Unknown role');
    }
  }

  Future<void> logout() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
    } catch (error) {
      rethrow;
    }
  }
}
