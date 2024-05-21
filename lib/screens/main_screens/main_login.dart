import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/main_screens/login_screen.dart';
import 'package:smartnest/screens/main_screens/register_screen.dart';
import 'package:smartnest/widgets/button/button_fb.dart';
import 'package:smartnest/widgets/button/button_google.dart';
import 'package:smartnest/widgets/button/button_primary.dart';
import 'package:smartnest/widgets/button/button_secondary.dart';


class MainLogin extends StatefulWidget {
  const MainLogin({super.key});

  @override
  State<MainLogin> createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
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
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(10.0), // Radio de las esquinas
                  ),
                  width: 321,
                  height: 596,
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      ButtonFb(
                        onPressed: () async { },
                        text: 'Facebook',
                        imageAsset: 'lib/img/social_network/facebook.png', // Ruta de la imagen para Facebook
                      ),
                      const SizedBox(height: 30),
                      ButtonGoogle(
                        onPressed: () {},
                        text: 'Google',
                        imageAsset: 'lib/img/social_network/google.png', // Ruta de la imagen para Google
                      ),
                      const SizedBox(height: 270),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonPrimary(
                              onPressed: () {
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              }, text: 'Iniciar Sesión'),
                          const SizedBox(
                              width: 20), // Espacio entre los botones
                          ButtonSecondary(
                              onPressed: () {
                                 Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                                );
                              }, text: 'Registrarse'),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
