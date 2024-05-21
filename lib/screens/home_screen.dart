import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/widgets/button/button_primary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();


  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cerrar sesión: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.getColorThemes()[0],
              AppTheme.getColorThemes()[6]
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ), 
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SmartNest', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
              SizedBox(height: 30, width: 420),
              ButtonPrimary(onPressed: (){
                _signOut();
                
              }, text: 'Salir de sesión')
            ],
            
          ),
        
      ),
    );
  }
}