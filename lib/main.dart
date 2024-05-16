import 'package:flutter/material.dart';
import 'package:smartnest/screens/main_screens/login_screen.dart';
import 'package:smartnest/screens/main_screens/main_login.dart';
import 'package:smartnest/screens/main_screens/register_data_screen.dart';
import 'package:smartnest/screens/main_screens/register_screen.dart';
import 'screens/main_screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartNest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const RegisterDataScreen(), 
    );
  }
}
