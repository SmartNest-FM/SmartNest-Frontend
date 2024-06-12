import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/screens/activities.dart';
import 'package:smartnest/screens/activities2.dart';
import 'package:smartnest/screens/activities3.dart';
import 'package:smartnest/screens/activities4.dart';
import 'package:smartnest/screens/activities5.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/level1_screen.dart';
import 'package:smartnest/screens/level2_screen.dart';
import 'package:smartnest/screens/level3_screen.dart';
import 'package:smartnest/screens/level5_screen.dart';
import 'package:smartnest/screens/level4_screen.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'package:smartnest/model/level.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key});

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuthServices _auth = FirebaseAuthServices();

  UserModel? _user;

  LevelModel? _level1;
  LevelModel? _level2;
  LevelModel? _level3;
  LevelModel? _level4;
  LevelModel? _level5;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadLevelData(1); // Cargar datos del nivel 1
    _loadLevelData(2); // Cargar datos del nivel 2
    _loadLevelData(3); // Cargar datos del nivel 3
    _loadLevelData(4); // Cargar datos del nivel 4
    _loadLevelData(5); // Cargar datos del nivel 5
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
      // ignore: use_build_context_synchronously
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
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/user/by-uid/$uid'));

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

  
  Future<void> _loadLevelData(int levelNumber) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/level/$levelNumber'));
      if (response.statusCode == 200) {
        var levelData = jsonDecode(response.body);
        var level = LevelModel.fromMap(levelData);
        setState(() {
          switch (levelNumber) {
            case 1:
              _level1 = level;
              break;
            case 2:
              _level2 = level;
              break;
            case 3:
              _level3 = level;
              break;
            case 4:
              _level4 = level;
              break;
            case 5:
              _level5 = level;
              break;
          }
        });
      } else {
        // Manejar el error si no se pudo cargar los datos del nivel
      }
    } catch (e) {
      // Manejar el error si ocurrió una excepción al cargar los datos del nivel
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Niveles', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
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
                backgroundImage: _user != null && _user!.photouser != null && File(_user!.photouser!).existsSync()
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
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Niveles'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LevelsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Progreso de aprendizaje'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PercentageScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              SizedBox(height: 20), 
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  shrinkWrap: true,
                  children: <Widget>[
                    
                    Container(
                        height: 120,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _level1 != null ? Image.network(
                              _level1!.urlImg,
                              height: 80,
                            ) : Container(),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_level1 != null ? _level1!.name : 'Cargando...', // Mostrar el nombre del nivel 1 si los datos están disponibles, o 'Cargando...' si no
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800]
                                  ),
                                ),
                                Text('10 actividades',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey)),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const ActivitiesScreen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(110, 20),
                                    backgroundColor: Colors.blue[400],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // Color de fondo del botón
                                  ),
                                  child: Text(
                                    "Iniciar",
                                    style: TextStyle(
                                      color: Colors.white, // Color del texto
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                    SizedBox(height: 8.0),
                    Container(
                        height: 120,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _level2 != null ? Image.network(
                              _level2!.urlImg,
                              height: 80,
                            ) : Container(),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_level2 != null ? _level2!.name : 'Cargando...', // Mostrar el nombre del nivel 1 si los datos están disponibles, o 'Cargando...' si no
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800]
                                  ),
                                ),
                                Text('10 actividades',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey)),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Activities2Screen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(110, 20),
                                    backgroundColor: Colors.blue[400],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // Color de fondo del botón
                                  ),
                                  child: Text(
                                    "Iniciar",
                                    style: TextStyle(
                                      color: Colors.white, // Color del texto
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                    SizedBox(height: 8.0),
                    Container(
                        height: 120,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _level3 != null ? Image.network(
                              _level3!.urlImg,
                              height: 80,
                            ) : Container(),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_level3 != null ? _level3!.name : 'Cargando...', // Mostrar el nombre del nivel 1 si los datos están disponibles, o 'Cargando...' si no
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800]
                                  ),
                                ),
                                Text('10 actividades',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey)
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Activities3Screen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(110, 20),
                                    backgroundColor: Colors.blue[400],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // Color de fondo del botón
                                  ),
                                  child: Text(
                                    "Iniciar",
                                    style: TextStyle(
                                      color: Colors.white, // Color del texto
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                    SizedBox(height: 8.0),
                    Container(
                        height: 120,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _level4 != null ? Image.network(
                              _level4!.urlImg,
                              height: 80,
                            ) : Container(),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_level4 != null ? _level4!.name : 'Cargando...', // Mostrar el nombre del nivel 1 si los datos están disponibles, o 'Cargando...' si no
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800]
                                  ),
                                ),
                                Text('10 actividades',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey)),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Activities4Screen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(110, 20),
                                    backgroundColor: Colors.blue[400],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // Color de fondo del botón
                                  ),
                                  child: Text(
                                    "Iniciar",
                                    style: TextStyle(
                                      color: Colors.white, // Color del texto
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                    SizedBox(height: 8.0),
                    Container(
                        height: 120,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _level5 != null ? Image.network(
                              _level5!.urlImg,
                              height: 80,
                            ) : Container(),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_level5 != null ? _level5!.name : 'Cargando...', // Mostrar el nombre del nivel 1 si los datos están disponibles, o 'Cargando...' si no
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800]
                                  ),
                                ),
                                Text('10 actividades',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.grey)),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Activities5Screen()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: Size(110, 20),
                                    backgroundColor: Colors.blue[400],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    // Color de fondo del botón
                                  ),
                                  child: Text(
                                    "Iniciar",
                                    style: TextStyle(
                                      color: Colors.white, // Color del texto
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
