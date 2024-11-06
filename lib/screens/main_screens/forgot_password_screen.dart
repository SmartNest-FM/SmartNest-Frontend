import 'package:flutter/material.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/widgets/button/button_primary.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();
  TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    String email = _emailController.text.trim();
      try {
        await _auth.sendPasswordResetEmail(email: email);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black.withOpacity(0.75),
              content: Card(
                color: Colors.black.withOpacity(0.75),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Correo enviado',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Se ha enviado un correo para restablecer tu contraseña',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ButtonPrimary(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: 'Aceptar',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black.withOpacity(0.75),
              content: Card(
                color: Colors.black.withOpacity(0.75),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Error al enviar correo',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'No se ha podido enviar el correo para restablecer tu contraseña',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ButtonPrimary(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: 'Aceptar',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }   
  }


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
                    width: 230 ,
                    child: ButtonPrimary(
                      onPressed: () {
                        _resetPassword();
                      },
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
          controller: _emailController,
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