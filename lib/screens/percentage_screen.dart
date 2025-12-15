import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:smartnest/config/api.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/levels_screen.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'package:smartnest/widgets/button/button_primary.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smartnest/widgets/button/button_secondary2.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class PercentageScreen extends StatefulWidget {
  const PercentageScreen({super.key});

  @override
  State<PercentageScreen> createState() => _PercentageScreenState();
}

class _PercentageScreenState extends State<PercentageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  double _valuePercentage = 0.0;
  UserModel? _user;

  // TTS
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetchTotalProgress();
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cerrar sesión: $e')),
      );
    }
  }

  Future<void> fetchTotalProgress() async {
    try {
      String uid = _auth.currentUser!.uid;

      var response = await http.get(
        Uri.parse(Api.progressLevels(uid)),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        double total = 0;

        for (var level in data) {
          total += (level["percentage"] ?? 0).toDouble();
        }

        double finalPercentage = total / 5;

        setState(() {
          _valuePercentage = finalPercentage / 100;
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _loadUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
      var response = await http.get(Uri.parse(Api.userByUid(uid)));

      if (response.statusCode == 200) {
        var userData = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _user = UserModel.fromMap(userData);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar datos del usuario: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar datos del usuario: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Pogreso de Aprendizaje', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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
                backgroundImage: _user != null &&
                        _user!.photouser != null &&
                        File(_user!.photouser!).existsSync()
                    ? FileImage(File(_user!.photouser!))
                    : const AssetImage('lib/img/user_no_photo.png') as ImageProvider,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF1D4F7C),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Niveles'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LevelsScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Progreso de aprendizaje'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PercentageScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
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
              AppTheme.getColorThemes()[6],
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
              height: 515,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Progreso Actual',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 10.0,
                    percent: _valuePercentage,
                    center: Text("${(_valuePercentage * 100).toStringAsFixed(0)} %"),
                    progressColor: const Color(0xFF1D4F7C),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Vamos por buen camino. ¡Tú puedes!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  ButtonSecondary2(
                    onPressed: () {
                      speak('Vamos por buen camino ${_user?.nameuser ?? ''}. ¡Tú puedes!');
                    },
                    text: '¡Sigue Estudiando!',
                  ),
                  const SizedBox(height: 25),
                  ButtonPrimary(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LevelsScreen()));
                    },
                    text: 'Comenzar',
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
