import 'package:flutter/material.dart';
import 'package:smartnest/widgets/button/button_primary.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageHeight = screenHeight * 0.23; // Altura de la imagen

    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: screenHeight),
          child: Container(
            width: screenWidth, // Asegura que el contenedor se ajuste al ancho de la pantalla
            decoration: const BoxDecoration(
              color: Color(0xFF709ccc),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20), // Añadir padding horizontal para evitar overflow
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // Centra horizontalmente el contenido
                children: [
                  SizedBox(height: screenHeight * 0.1), // Espacio superior para centrar el contenido
                  Container(
                    child: Image.asset(
                      'lib/img/img_login.png',
                      height: imageHeight,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black, // Color de la línea
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Bienvenido de nuevo!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Inicia sesión en tu cuenta de SmartNest',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInputField('Email', Icons.email),
                  const SizedBox(height: 15),
                  _buildInputField('Contraseña', Icons.lock, isPassword: true),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      // Acción para registrarse
                    },
                    child: const Text(
                      '¿No tienes una cuenta? Regístrate',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      // Acción para recuperar contraseña
                    },
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ButtonPrimary(
                    onPressed: () {},
                    text: 'Iniciar Sesión',
                  ),
                  SizedBox(height: screenHeight * 0.1), // Espacio inferior para centrar el contenido
                ],
              ),
            ),
          ),
        ),
      ),
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