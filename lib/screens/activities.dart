import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

import 'package:smartnest/config/api.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/phonological_awareness.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/screens/home_screen.dart';

import 'package:smartnest/screens/level1_screenG.dart';
import 'package:smartnest/screens/levels_screen.dart';

import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';

import 'package:smartnest/widgets/button/button_activities.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  UserModel? _user;
  double levelPercentage = 0.0;

  bool get levelCompleted => levelPercentage == 100;

  List<bool> activityCompleted = List.filled(11, false);

  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    loadActivityStatus();
    loadLevelPercentage();

    speak(
      "Bienvenido al nivel 1, aquí encontrarás 10 actividades para mejorar tu Conciencia Fonológica. Presiona una actividad para comenzar."
    );
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  // =======================
  // PROGRESO DEL NIVEL
  // =======================
  Future<void> loadLevelPercentage() async {
    String uid = _auth.currentUser!.uid;
    final url = "${Api.baseUrl}/progress/percentage/1?uid=$uid";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        setState(() => levelPercentage = (json["percentage"] ?? 0).toDouble());
      }
    } catch (e) {
      print(e);
    }
  }

  // =======================
  // ESTADO REAL
  // =======================
  Future<bool> fetchActivityStatus(int id) async {
    final uid = _auth.currentUser!.uid;
    final url =
        "${Api.baseUrl}/progress/status/PHONOLOGICAL/$id?uid=$uid";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json["completed"] ?? false;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> loadActivityStatus() async {
    for (int i = 1; i <= 10; i++) {
      bool completed = await fetchActivityStatus(i);
      setState(() => activityCompleted[i] = completed);
    }
  }

  // =======================
  // CARGA USUARIO
  // =======================
  Future<void> _loadUserData() async {
    try {
      String uid = _auth.currentUser!.uid;
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

  // =======================
  // ITEM REUTILIZABLE
  // =======================
  Widget activityItem(int id, Widget screen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ButtonActivities(
          text: "Actividad $id",
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
          },
        ),
        ClipOval(
          child: Image.asset(
            activityCompleted[id]
                ? "lib/img/activitie_check.png"
                : "lib/img/activitie_none.png",
            width: 50,
            height: 50,
          ),
        )
      ],
    );
  }

  // =======================
  // UI
  // =======================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      // ================= APPBAR ============
      appBar: AppBar(
        title: const Text("Nivel 1", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 40,
          color: Colors.white,
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

      // ================= DRAWER ================
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
                    : const AssetImage("lib/img/user_no_photo.png")
                        as ImageProvider,
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

      // ================= BODY ================
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
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56),
            ),
            child: Container(
              width: 370,
              height: 630,
              padding: const EdgeInsets.all(20),

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // ==== PORCENTAJE ====
                    ClipOval(
                      child: Container(
                        width: 70,
                        height: 70,
                        color: levelCompleted
                            ? Colors.green
                            : Colors.grey.shade400,
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

                    // TITULOS
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ejercicios", style: TextStyle(fontSize: 18)),
                        Text("Estado", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // ITEMS
                    activityItem(1, const Level1ScreenG(activityId: 1)),
                    const SizedBox(height: 20),

                    activityItem(2, const Level1ScreenG(activityId: 2)),
                    const SizedBox(height: 20),

                    activityItem(3, const Level1ScreenG(activityId: 3)),
                    const SizedBox(height: 20),

                    activityItem(4, const Level1ScreenG(activityId: 4)),
                    const SizedBox(height: 20),

                    activityItem(5, const Level1ScreenG(activityId: 5)),
                    const SizedBox(height: 20),

                    activityItem(6, const Level1ScreenG(activityId: 6)),
                    const SizedBox(height: 20),

                    activityItem(7, const Level1ScreenG(activityId: 7)),
                    const SizedBox(height: 20),

                    activityItem(8, const Level1ScreenG(activityId: 8)),
                    const SizedBox(height: 20),

                    activityItem(9, const Level1ScreenG(activityId: 9)),
                    const SizedBox(height: 20),

                    activityItem(10, const Level1ScreenG(activityId: 10)),
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
