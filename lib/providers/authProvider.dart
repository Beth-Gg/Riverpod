
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/signup_service.dart';
import '../presentation/pages/login/login.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final authProvider =
    Provider((ref) => AuthState(ref.watch(apiServiceProvider)));

class AuthState {
  final ApiService _apiService;

  AuthState(this._apiService);

  Future<void> signUp(String username, String password, String role, context) async {
    await _apiService.signUp(username, password, role, context);
  } 
}

