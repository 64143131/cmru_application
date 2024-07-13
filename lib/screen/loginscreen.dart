import 'package:cmru_application/confg/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _email = TextEditingController();
  final _password = TextEditingController();

  Future<void> checklogin() async {
    final prefs = await _prefs;
    final token = prefs.getString('token');
    if (token != null) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    checklogin();
  }

  Future<void> _login() async {
    final response = await http.post(
      Uri.parse('${API_URL}/api/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': _email.text,
        'password': _password.text,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      final prefs = await _prefs;
      await prefs.setString('token', jsonDecode(response.body)['token']);
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${response.reasonPhrase}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('โปรดเข้าสู่ระบบ'),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                labelText: 'อีเมล',
              ),
            ),
            TextFormField(
              controller: _password,
              decoration: InputDecoration(
                labelText: 'รหัสผ่าน',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('เข้าสู่ระบบ'),
            ),
          ],
        ),
      ),
    );
  }
}
