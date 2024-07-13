import 'package:cmru_application/screen/homescreen.dart';
import 'package:cmru_application/screen/loginscreen.dart';
import 'package:cmru_application/screen/registerscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'login',
      routes: {
        '/': ((context) => LoginScreen()),
        '/register': ((context) => RegisterScreen()),
        '/home': ((context) => HomeScreen()),
      },
    );
  }
}
