import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/widgets/button/button_primary.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageHeight = screenHeight * 0.25;

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: Container(
            width: screenWidth,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Registro',
                      style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    'Registrate ahora mismo!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Registrate en tu cuenta de SmartNest ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  
                  Image(
                    image: const AssetImage('lib/img/img_register.png'),
                    height: imageHeight
                  ),
                      
                  const SizedBox(height: 20),
                  
                  const SizedBox(height: 20),
                  _buildInputField('Email', Icons.email),
                  const SizedBox(height: 15),
                  _buildInputField('Contraseña', Icons.lock, isPassword: true),
                  const SizedBox(height: 35),
                  
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: const Text(
                      'Tienes una cuenta? Iniciar sesion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),  
                  const SizedBox(height: 35),
                  ButtonPrimary(
                    onPressed: () {},
                    text: 'Registrarse',
                  ),
                ],
              ),
            ),  
          ),
        )
      )
    );
  }

  Widget _buildInputField(String hintText, IconData icon, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20), // Asegura que el campo de entrada no se desborde horizontalmente
      child: SizedBox(
        width: 320,
        child: TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}