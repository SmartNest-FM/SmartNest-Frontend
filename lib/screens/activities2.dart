import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

import 'package:smartnest/config/api.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/fluent_reading.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/level2_screenG.dart';
import 'package:smartnest/screens/levels_screen.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'package:smartnest/widgets/button/button_activities.dart';

class Activities2Screen extends StatefulWidget {
  const Activities2Screen({super.key});

  @override
  State<Activities2Screen> createState() => _Activities2ScreenState();
}

class _Activities2ScreenState extends State<Activities2Screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  static const int startId = 1;
  static const int endId = 10;

  UserModel? _user;
  double levelPercentage = 0.0;
  bool get levelCompleted => levelPercentage == 100;

  // ✅ tamaño correcto para indexar 1..10
  final List<FluentReadingModel?> fluentReading = List.filled(endId + 1, null);
  final List<bool> activityCompleted = List.filled(endId + 1, false);

  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    loadAllFluentReading();
    loadActivityStatus();
    loadLevelPercentage();

    speak(
      "Bienvenido al nivel 2, aquí encontrarás 10 actividades para mejorar tu Lectura Fluida. Presiona una actividad para comenzar.",
    );
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  Future<void> loadLevelPercentage() async {
    final uid = _auth.currentUser!.uid;

    // ✅ NIVEL 2 (antes tenías 1)
    final url = "${Api.baseUrl}/progress/percentage/2?uid=$uid";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() {
          levelPercentage = (json["percentage"] ?? 0).toDouble();
        });
      }
    } catch (e) {
      print("loadLevelPercentage error: $e");
    }
  }

  Future<void> loadAllFluentReading() async {
    for (int id = startId; id <= endId; id++) {
      await fetchFluentReading(id);
    }
  }

  Future<void> fetchFluentReading(int id) async {
    try {
      final response = await http.get(Uri.parse(Api.fluentById(id)));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          fluentReading[id] = FluentReadingModel.fromMap(jsonResponse);
        });
      } else {
        print("fetchFluentReading($id) status: ${response.statusCode}");
      }
    } catch (e) {
      print("fetchFluentReading($id) error: $e");
    }
  }

  Future<bool> fetchActivityStatus(int activityId) async {
    final uid = _auth.currentUser!.uid;
    final url = "${Api.baseUrl}/progress/status/FLUENT/$activityId?uid=$uid";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json["completed"] ?? false;
      }
    } catch (e) {
      print("fetchActivityStatus error: $e");
    }
    return false;
  }

  Future<void> loadActivityStatus() async {
    for (int id = startId; id <= endId; id++) {
      final completed = await fetchActivityStatus(id);
      setState(() {
        activityCompleted[id] = completed;
      });
    }
  }

  Future<void> _loadUserData() async {
    try {
      final uid = _auth.currentUser!.uid;
      final response = await http.get(Uri.parse(Api.userByUid(uid)));
      if (response.statusCode == 200) {
        setState(() {
          _user = UserModel.fromMap(jsonDecode(utf8.decode(response.bodyBytes)));
        });
      }
    } catch (e) {
      print("Error cargando usuario: $e");
    }
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
    );
  }

  // ✅ Muestra Actividad 1..10 pero navega con IDs reales 11..20
  Widget activityItem(int realId) {
    final shown = realId - startId + 1; // 11->1, 12->2 ... 20->10

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonActivities(
          text: "Actividad $shown",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Level2ScreenG(activityId: realId)),
            );
          },
        ),
        ClipOval(
          child: Image.asset(
            activityCompleted[realId]
                ? "lib/img/activitie_check.png"
                : "lib/img/activitie_none.png",
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Nivel 2", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 40,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LevelsScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            iconSize: 40,
            color: Colors.white,
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_user?.nameuser ?? "Nombre no disponible"),
              accountEmail: Text(_user?.emailuser ?? "Email no disponible"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: _user != null &&
                        _user!.photouser != null &&
                        File(_user!.photouser!).existsSync()
                    ? FileImage(File(_user!.photouser!))
                    : const AssetImage("lib/img/user_no_photo.png") as ImageProvider,
              ),
              decoration: const BoxDecoration(color: Color(0xFF1D4F7C)),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Perfil"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Inicio"),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text("Progreso de aprendizaje"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PercentageScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Configuración"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Cerrar sesión"),
              onTap: _signOut,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.getColorThemes()[0], AppTheme.getColorThemes()[6]],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(56)),
            color: Colors.white,
            child: Container(
              width: 370,
              height: 630,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 70,
                        height: 70,
                        color: levelCompleted ? Colors.green : Colors.grey.shade400,
                        child: Center(
                          child: Text(
                            "${levelPercentage.toStringAsFixed(0)}%",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ejercicios", style: TextStyle(fontSize: 18)),
                        Text("Estado", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    for (int id = startId; id <= endId; id++) ...[
                      activityItem(id),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
