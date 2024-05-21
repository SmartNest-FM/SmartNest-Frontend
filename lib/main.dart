import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/main_screens/forgot_password_screen.dart';
import 'package:smartnest/screens/main_screens/login_screen.dart';
import 'package:smartnest/screens/main_screens/main_login.dart';
import 'package:smartnest/screens/main_screens/register_data_screen.dart';
import 'package:smartnest/screens/main_screens/register_screen.dart';
import 'screens/main_screens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      //home: WelcomeScreen(), 
      home: HomeScreen()
    );
  }
}
