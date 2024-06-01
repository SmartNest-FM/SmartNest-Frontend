import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/main_screens/login_screen.dart';
import 'package:smartnest/widgets/button/button_primary.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class RegisterDataScreen extends StatefulWidget {
  final UserModel userSend;

  const RegisterDataScreen({super.key, required this.userSend });

  @override
  State<RegisterDataScreen> createState() => _RegisterDataScreenState();
}

class _RegisterDataScreenState extends State<RegisterDataScreen> {
  TextEditingController _apoderadoController = TextEditingController();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _edadController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _apoderadoController.text = '';
    _nombreController.text = '';
    _edadController.text = '';
  }

  bool aceptarTerminos = false;

  String? _imagePath;

  
  Future<void> _updateUser() async {

    UserModel updatedUser = UserModel(
      id: widget.userSend.id,
      uid: widget.userSend.uid,
      emailuser: widget.userSend.emailuser,
      nametutor: _apoderadoController.text,
      nameuser: _nombreController.text,
      age: int.parse(_edadController.text),
      photouser: _imagePath ?? 'lib/img/user_no_photo.png',
    );

    var response = await http.put(
      Uri.parse('http://10.0.2.2:8080/user/${updatedUser.id}'), // Asegúrate de usar la URL correcta
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedUser.toMap()),
    );

    if (response.statusCode == 200) {
      // Actualización exitosa
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text("Éxito"),
            ),
            content: Text(
              "Datos actualizados correctamente.",
              textAlign: TextAlign.justify,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cerrar"),
              ),
            ],
          );
        },
      );


      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );

    } else {
      // Error al actualizar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Hubo un error al actualizar los datos. Por favor, inténtelo de nuevo."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cerrar"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Actualiza el estado con la ruta de la imagen seleccionada
      setState(() {
        _imagePath = image.path;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageHeight = screenHeight * 0.20;

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
                  ClipOval(
                    child: _imagePath != null
                      ? Image.file(
                          File(_imagePath!),
                          height: imageHeight,
                          width: imageHeight,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'lib/img/user_no_photo.png',
                          height: imageHeight,
                          width: imageHeight,
                          fit: BoxFit.cover,
                        ),
                  ),   
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                     _selectImage();
                    },
                    child: const Text(
                      'Cargar foto del niño o niña',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),   
                  const SizedBox(height: 20),
                  _buildInputField('Nombre del Apoderado', Icons.person, controller: _apoderadoController),
                  const SizedBox(height: 15),
                  _buildInputField('Nombres del Niño o Niña', Icons.child_care, controller: _nombreController),
                  const SizedBox(height: 15),
                  _buildInputField('Edad', Icons.cake, controller: _edadController),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: aceptarTerminos,
                        onChanged: (value) {
                          setState(() {
                            aceptarTerminos = value ?? false;
                          });
                        },
                      ),
                      const Text(
                        'Aceptar términos y condiciones',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
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
                        if (aceptarTerminos) {
                          _updateUser();
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("Debe aceptar los términos y condiciones."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cerrar"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
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


  Widget _buildInputField(String hintText, IconData icon, {bool isPassword = false , TextEditingController? controller}) {
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