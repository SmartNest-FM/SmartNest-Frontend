import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
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
            const Center(
              child: Text(
                'SmartNest',
                style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 30),
            Image.asset('lib/img/welcome_img.png'),
            const SizedBox(height: 30),
            Button1(
              onPressed: () {},
              text: 'Comenzar',
            ),
            const SizedBox(height: 120),
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