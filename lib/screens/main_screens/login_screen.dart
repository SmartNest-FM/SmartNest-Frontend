import 'package:flutter/material.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/main_screens/forgot_password_screen.dart';
import 'package:smartnest/screens/main_screens/register_screen.dart';
import 'package:smartnest/widgets/button/button_primary.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

   final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()),
      );
    } catch (e) {
      // Manejar errores de inicio de sesión aquí
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al iniciar sesión: $e'),
        ),
      );
    }
  }

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
                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      'Iniciar Sesión',
                      style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Container(
                    child: Image.asset(
                      'lib/img/img_login.png',
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
                  const Text(
                    'Bienvenido de nuevo!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Inicia sesión en tu cuenta de SmartNest',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 25),
                  _buildInputField('Email', Icons.email, controller: _emailController),
                  const SizedBox(height: 15),
                  _buildInputField('Contraseña', Icons.lock, isPassword: true, controller: _passwordController),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: const Text(
                      '¿No tienes una cuenta? Regístrate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: const Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ButtonPrimary(
                    onPressed: () {
                       _login();
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    text: 'Iniciar Sesión',
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

  Widget _buildInputField(String hintText, IconData icon, {bool isPassword = false, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20), // Asegura que el campo de entrada no se desborde horizontalmente
      child: SizedBox(
        width: 320,
        child: TextField(
          controller: controller,
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