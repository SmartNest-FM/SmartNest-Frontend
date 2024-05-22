import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/main_screens/forgot_password_screen.dart';
import 'package:smartnest/screens/main_screens/login_screen.dart';
import 'package:smartnest/screens/main_screens/main_login.dart';
import 'package:smartnest/screens/main_screens/register_data_screen.dart';
import 'package:smartnest/screens/main_screens/register_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'screens/main_screens/welcome_screen.dart';


import 'package:permission_handler/permission_handler.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await _requestMicPermission();

  runApp(const MyApp());
}

Future<void> _requestMicPermission() async {
  var status = await Permission.microphone.status;
  if (status.isDenied || status.isPermanentlyDenied) {
    await Permission.microphone.request();
  }
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
      home: PercentageScreen()
    );
  }

  
}
