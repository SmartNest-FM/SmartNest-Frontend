import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/levels_screen.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';

import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();


  UserModel? _user;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cerrar sesión: $e'),
        ),
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
        // Actualizar la foto del usuario en el servidor
        _updateUserPhoto(_imagePath);
      });
    }
  }

  Future<void> _updateUserPhoto(String? imagePath) async {
    //BUSCAR USUARIO AUTENTICADO UID, Y EN BASE A ESO BUSCAR SU ID Y CON SU ATRIBUTO ID HACER EL UPDATE EN EL BACKEND PASANDOLE SU ID Y LISTO
    /* try {
      // Obtener el UID del usuario autenticado
      String uid = _auth.currentUser!.uid;
      
      // Realizar una solicitud GET para obtener el ID del usuario basado en su UID
      var getUserResponse = await http.get(Uri.parse('http://10.0.2.2:8080/user/by-uid/$uid'));
      
      if (getUserResponse.statusCode == 200) {
        // Obtener el ID del usuario de la respuesta
        var userData = jsonDecode(getUserResponse.body);
        String userId = userData['id'].toString();

        // Construir el cuerpo de la solicitud con la nueva foto del usuario
        var requestBody = jsonEncode({"photouser": imagePath});

        // Realizar una solicitud PUT para actualizar la foto del usuario
        var updateUserResponse = await http.put(
          Uri.parse('http://10.0.2.2:8080/user/$userId'),
          headers: {"Content-Type": "application/json"},
          body: requestBody,
        );

        if (updateUserResponse.statusCode == 200) {
          // Si la solicitud PUT es exitosa, mostrar un mensaje de éxito
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Foto actualizada con éxito')),
          );
        } else {
          // Si la solicitud PUT no es exitosa, mostrar un mensaje de error
          print('Error al actualizar la foto del usuario: ${updateUserResponse.reasonPhrase}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al actualizar la foto del usuario: ${updateUserResponse.reasonPhrase}')),
          );
        }
      } else {
        // Si la solicitud GET no es exitosa, mostrar un mensaje de error
        print('Error al obtener el ID del usuario: ${getUserResponse.reasonPhrase}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al obtener el ID del usuario: ${getUserResponse.reasonPhrase}')),
        );
      }
    } catch (e) {
      // Manejar cualquier error que pueda ocurrir
      print('Error al actualizar la foto del usuario: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar la foto del usuario: $e')),
      );
    }*/
  }

  Future<void> _loadUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/user/by-uid/$uid'));

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        setState(() {
          _user = UserModel.fromMap(userData);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos del usuario: ${response.reasonPhrase}')),
          
        );
        print(response.reasonPhrase);
      }
    } catch (e) {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar datos del usuario: $e')),
       
      );
       print(e);
    }
  }

 Widget _buildInputField(String hintText, TextEditingController controller, {bool isPassword = false}) {
  String? userData;
  switch(hintText) {
    case 'Name':
      userData = _user?.nameuser;
      break;
    case 'Edad':
      userData = _user?.age.toString();
      break;
    case 'Email':
      userData = _user?.emailuser;
      break;
    default:
      userData = '';
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20), // Asegura que el campo de entrada no se desborde horizontalmente
    child: TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: userData ?? hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Mis Datos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            iconSize: 40,
            color: Colors.white,
          ),
        actions: [
          
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            iconSize: 40,
            color: Colors.white,
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_user?.nameuser ?? "Nombre no disponible"),
              accountEmail: Text(_user?.emailuser ?? "Email no disponible"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: _user != null && _user!.photouser != null
                ? FileImage(File(_user!.photouser!))
                : AssetImage('lib/img/user_no_photo.png'),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF1D4F7C),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Niveles'),
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LevelsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Progreso de aprendizaje'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PercentageScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar sesión'),
              onTap: () {
                _signOut();
              },
            ),
          ],
        ),
      ),
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
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56),
            ),
            color: Colors.white,
            child: Container(
              width: 370,
              height: 520,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Perfil',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  CircleAvatar(
                    radius: 46.5,
                    backgroundImage: _user != null && _user!.photouser != null
                        ? FileImage(File(_user!.photouser!))
                        : AssetImage('lib/img/user_no_photo.png'),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectImage();
                        },
                        child: Icon(Icons.upload, size: 16),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Actualizar foto del niño',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Row(
                    children: [
                      const Expanded(flex: 2, child: Text('Nombres')),
                      Expanded(
                        flex: 7,
                        child: _buildInputField('Name', _nameController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(flex: 2, child: Text('Edad')),
                      Expanded(
                        flex: 7,
                        child: _buildInputField('Edad', _ageController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(flex: 2, child: Text('Correo electrónico')),
                      Expanded(
                        flex: 7,
                        child: _buildInputField('Email', _emailController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Actualiza tus datos',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.edit, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
