import 'package:flutter/material.dart';
import 'package:smartnest/widgets/button/button_primary.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageHeight = screenHeight * 0.40;

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
                  const SizedBox(height: 30),
                  Container(
                    child: Image.asset(
                      'lib/img/img_forgot_password.png',
                      height: imageHeight,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white, // Color de la línea
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 289,
                    child: const Text(
                      '¿No recuerdas tu contraseña?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2, // Asegura que el texto no ocupe más de una línea
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Digita tu email y le ayudaremos',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  _buildInputField('Email', Icons.email),
                  
                  const SizedBox(height: 35),
                  SizedBox(
                    width: 200 ,
                    child: ButtonPrimary(
                      onPressed: () {},
                      text: 'Restablecer Contraseña',
                    ),
                  ),
                   // Espacio inferior para centrar el contenido
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