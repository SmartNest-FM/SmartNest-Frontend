import 'package:flutter/material.dart';
import 'package:smartnest/config/api.dart';
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
  bool _termsAccepted = false;

  @override
  void initState() {
    super.initState();
    _apoderadoController.text = '';
    _nombreController.text = '';
    _edadController.text = '';
  }

  String? _imagePath;

  void _showError(String msg) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Error"),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cerrar"),
          )
        ],
      ),
    );
  }

  Future<void> _updateUser() async {
    if (_apoderadoController.text.isEmpty ||
        _nombreController.text.isEmpty ||
        _edadController.text.isEmpty) {
      _showError("Completa todos los campos antes de continuar.");
      return;
    }

    int? edad = int.tryParse(_edadController.text);
    if (edad == null || edad <= 0) {
      _showError("La edad debe ser un número válido.");
      return;
    }

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
      Uri.parse(Api.updateUser(updatedUser.id)), // Asegúrate de usar la URL correcta
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

  void _showTermsAndConditionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.75),
          content: SingleChildScrollView(
            child: Card(
              color: Colors.black.withOpacity(0.75),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Términos y Condiciones',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Introducción:\n'
                      'Bienvenido a SmartNest (en adelante, "el Aplicativo"). Al utilizar el Aplicativo, usted acepta estar sujeto a los siguientes términos y condiciones (en adelante, "los Términos"). Si no está de acuerdo con estos Términos, no debe utilizar el Aplicativo.\n\n'
                      '2. Descripción del Servicio:\n'
                      'El Aplicativo utiliza inteligencia artificial (IA) para mejorar la comprensión lectora de los usuarios, especialmente niños con síndrome de Down, mediante ejercicios y análisis personalizados que incluyen el uso reconocimiento de voz y conversión de texto a voz.\n\n'
                      '3. Elegibilidad y Autorización de Padres:\n'
                      'Para los usuarios menores de 18 años, se requiere el consentimiento explícito de los padres o tutores legales. Al aceptar estos Términos, los padres o tutores legales confirman que tienen la autoridad para permitir el uso del Aplicativo por parte del menor y que han leído y entendido estos Términos y la Política de Privacidad.\n\n'
                      '4. Uso Aceptable:\n'
                      'Usted se compromete a utilizar el Aplicativo de manera responsable y a no:\n'
                      '• Utilizar el Aplicativo para cualquier propósito ilegal o no autorizado.\n'
                      '• Interferir o interrumpir el funcionamiento del Aplicativo.\n'
                      '• Intentar acceder sin autorización a otros sistemas informáticos a través del Aplicativo.\n\n'
                      '5. Propiedad Intelectual:\n'
                      'Todos los contenidos, marcas registradas, logotipos y otros elementos del Aplicativo son propiedad de SmartNest o de sus respectivos propietarios. Usted no adquiere ningún derecho de propiedad intelectual al utilizar el Aplicativo.\n\n'
                      '6. Modificaciones:\n'
                      'SmartNest se reserva el derecho de modificar estos Términos en cualquier momento. Las modificaciones serán efectivas una vez publicadas en el Aplicativo. Es su responsabilidad revisar periódicamente estos Términos.\n\n'
                      '7. Terminación:\n'
                      'SmartNest puede suspender o terminar su acceso al Aplicativo en cualquier momento y por cualquier motivo, incluyendo pero no limitado a, el incumplimiento de estos Términos.\n\n'
                      'Política de Privacidad\n'
                      '1. Introducción:\n'
                      'La privacidad de nuestros usuarios es de suma importancia para SmartNest. Esta Política de Privacidad describe cómo recopilamos, utilizamos y protegemos la información personal de los usuarios del Aplicativo.\n\n'
                      '2. Información Recopilada:\n'
                      'Recopilamos información personal de los usuarios cuando se registran en el Aplicativo, incluyendo pero no limitado a:\n'
                      '• Nombres y apellidos del tutor a cargo del menor\n'
                      '• Nombres y apellidos del menor de edad\n'
                      '• Dirección de correo electrónico\n'
                      '• Edad\n'
                      '• Datos de uso del Aplicativo y rendimiento en los ejercicios de comprensión lectora\n\n'
                      '3. Uso de la Información:\n'
                      'La información recopilada se utiliza para:\n'
                      '• Personalizar y mejorar la experiencia de aprendizaje.\n'
                      '• Analizar el rendimiento y proporcionar informes a los padres o tutores.\n'
                      '• Enviar comunicaciones relacionadas con el Aplicativo.\n\n'
                      '4. Compartición de la Información:\n'
                      'No compartimos información personal con terceros, excepto en los siguientes casos:\n'
                      '• Con el consentimiento explícito de los padres o tutores legales.\n'
                      '• Para cumplir con requisitos legales o responder a procesos judiciales.\n\n'
                      '5. Seguridad:\n'
                      'Implementamos medidas de seguridad técnicas y organizativas para proteger la información personal de los usuarios contra el acceso no autorizado, la pérdida o el uso indebido.\n\n'
                      '6. Derechos de los Usuarios:\n'
                      'Los usuarios tienen derecho a:\n'
                      '• Acceder a su información personal.\n'
                      '• Solicitar la corrección de datos inexactos.\n'
                      '• Solicitar la eliminación de sus datos personales.\n'
                      '• Retirar el consentimiento para el tratamiento de sus datos.\n\n'
                      '7. Cumplimiento con Normativas:\n'
                      'Nos comprometemos a cumplir con las leyes de protección de datos aplicables, incluyendo la Ley 29733 de Protección de Datos Personales y la Ley 29973 de Normativa para Personas con Discapacidad en Perú. Esto implica que tomaremos todas las medidas necesarias para asegurar la privacidad y seguridad de los datos personales de los usuarios.\n\n'
                      '8. Contacto:\n'
                      'Si tiene alguna pregunta o inquietud sobre esta Política de Privacidad, puede contactarnos en:\n'
                      'smartnest@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _termsAccepted = true;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Aceptar'),
                        ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
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
                  GestureDetector(
                    onTap: _showTermsAndConditionsDialog,
                    child: SizedBox(
                      width: 300,
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Al usar SmartNest, acepto ',
                              ),
                              TextSpan(
                                text: 'términos de uso y políticas de privacidad',
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                 ButtonPrimary(
                    onPressed: () {
                      if (!_termsAccepted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Debe aceptar los términos y condiciones para continuar',
                            ),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }
                      _updateUser(); 
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