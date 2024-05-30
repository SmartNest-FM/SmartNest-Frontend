import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/screens/main_screens/login_screen.dart';
import 'package:smartnest/screens/main_screens/register_data_screen.dart';
import 'package:smartnest/widgets/button/button_primary.dart';

import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    

    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      String uid = _auth.currentUser!.uid;

      UserModel user = UserModel(
        id: 0,
        uid: uid,
        emailuser: email,   
        nametutor: '',
        nameuser: '',
        age: 0,
        photouser: '',
      );

      var response = await http.post(
        Uri.parse('http://10.0.2.2:8080/user'),  // Asegúrate de usar la URL correcta
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toMap()),
      );


    // Obtener el cuerpo de la respuesta del servidor
    String responseBody = response.body;

    // Buscar la parte del mensaje que contiene el ID
    int index = responseBody.lastIndexOf('=');
    String idString = responseBody.substring(index + 1).trim();

     // Convertir la cadena del ID en un entero
    int userId = int.parse(idString);

    // Actualizar el objeto UserModel con el ID obtenido del servidor
    user.id = userId; 

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterDataScreen(userSend: user),
        ),
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
                      'Error al registrarse',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Por favor, inténtalo de nuevo.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cerrar'),
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
                  _buildInputField('Email', Icons.email, controller: _emailController),
                  const SizedBox(height: 15),
                  _buildInputField('Contraseña', Icons.lock, isPassword: true, controller: _passwordController),
                  const SizedBox(height: 35),
                  
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
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
                    onPressed: () {
                      //logica cuando se registre entra con exito
                      _register();

                    },
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


 
