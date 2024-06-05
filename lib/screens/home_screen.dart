import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/screens/levels_screen.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'package:smartnest/screens/use_guide_screen.dart';

import 'dart:convert';
import 'dart:io';
import 'package:smartnest/model/user.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cerrar sesión: $e'),
        ),
      );
    }
  }

  Future<void> _loadUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/user/by-uid/$uid'));

      if (response.statusCode == 200) {
        var userData = jsonDecode(utf8.decode(response.bodyBytes));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(''),
         backgroundColor: Colors.red,
        // Botón del navbar
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Abre el drawer
            _scaffoldKey.currentState?.openDrawer();
          },
          iconSize: 40,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(_user?.nameuser ?? "Nombre no disponible"),
                accountEmail: Text(_user?.emailuser ?? "Email no disponible"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: _user != null && _user!.photouser != null  && File(_user!.photouser!).existsSync()
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
              leading: const Icon(Icons.bar_chart), // Icono para los niveles
              title: const Text('Niveles'),
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LevelsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up), // Icono para el progreso de aprendizaje
              title: const Text('Progreso de aprendizaje'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PercentageScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings), // Icono para la configuración
              title: const Text('Configuración'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app), // Icono para cerrar sesión
              title: const Text('Cerrar sesión'),
              onTap: () {
                // Acción al presionar "Cerrar sesión"
                _signOut();
              },
            ),

          ],
        ),
      ),
      body: Container(
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
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('SmartNest', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
              const SizedBox(height: 30, width: 420),
               GestureDetector(
                onTap: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LevelsScreen()),
                  );
                },
                child: Container(
                  width: 365,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D4F7C),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Hora de aprender',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Image.asset(
                                'lib/img/welcome_img.png',
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              'Inicia aquí tus ejercicios de lectura',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          
                        ),
                                              
                      ],
                    ),
                  ),
                  
                ),
              ),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PercentageScreen()),
                  );
                },
                child: Container(
                  width: 365,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D4F7C),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PercentageScreen()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Progreso de\nAprendizaje',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Image.asset(
                                  'lib/img/percentage.png',
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              'Mire su proceso de aprendizaje de los ejercicios',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                         // Espacio entre el texto y la imagen
                        
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UseGuideScreen()),
                  );
                },
                child: Container(
                  width: 365,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D4F7C),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UseGuideScreen()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Guia de Uso',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Image.asset(
                                  'lib/img/youtube_icon.png',
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Vea los videos guia referentes al uso del aplicativo',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                         // Espacio entre el texto y la imagen
                        
                      ],
                    ),
                  ),
                ),
              ),
            ],
            
          ),
        
      ),
    );
  }
}