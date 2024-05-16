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
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              color: Color(0xFF709ccc),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset('lib/img/img_login.png'),
                const SizedBox(height: 30),
                const Text(
                  'Bienvenido de nuevo!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Inicia sesión en tu cuenta de SmartNest',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                _buildInputField('Email', Icons.email),
                const SizedBox(height: 10),
                _buildInputField('Contraseña', Icons.lock, isPassword: true),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Aquí puedes añadir la acción que quieras realizar cuando se haga clic en "Registrate"
                    // Por ejemplo, puedes navegar a una nueva pantalla de registro
                  },
                  child: const Text(
                    '¿No tienes una cuenta? Registrate',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Aquí puedes añadir la acción que quieras realizar cuando se haga clic en "Registrate"
                    // Por ejemplo, puedes navegar a una nueva pantalla de registro
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
                const SizedBox(height: 30),
                ButtonPrimary(
                  onPressed: () {},
                  text: 'Iniciar Sesión',
                )
              ],
            )
          )
        );
  }

  Widget _buildInputField(String hintText, IconData icon,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
