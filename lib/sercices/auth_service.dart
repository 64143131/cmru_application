import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cmru_application/confg/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<bool> checklogin() async {
    final prefs = await AuthService()._prefs;
    final token = prefs.getString('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${API_URL}/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final prefs = await AuthService()._prefs;
      await prefs.setString('token', jsonDecode(response.body)['token']);
    }
    return;
  }
}
