import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/screens/main_screens/main_login.dart';
import 'package:smartnest/widgets/button/button1.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
            const SizedBox(height: 150),
            const Center(
              child: Text(
                'SmartNest',
                style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 50),
            Image.asset('lib/img/welcome_img.png', height:237),
            const SizedBox(height: 70),
            Button1(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainLogin()),
                );
              },
              text: 'Comenzar',
            ),
            const SizedBox(height: 130),
            // ignore: sized_box_for_whitespace
            Container(
              width: 300,
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    children: [
                      TextSpan(
                        text: 'Al usar SmartNest, acepto ',
                      ),
                      TextSpan(
                        text: 'términos de uso y políticas de privacidad',
                        style: TextStyle(
                          decoration: TextDecoration.underline, // Subrayado
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
        
      ),
    );
  }
}