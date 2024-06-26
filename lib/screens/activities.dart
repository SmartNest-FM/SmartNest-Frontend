import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/phonological_awareness.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/level1_screen.dart';
import 'package:smartnest/screens/level1_screen10.dart';
import 'package:smartnest/screens/level1_screen2.dart';
import 'package:smartnest/screens/level1_screen3.dart';
import 'package:smartnest/screens/level1_screen4.dart';
import 'package:smartnest/screens/level1_screen5.dart';
import 'package:smartnest/screens/level1_screen6.dart';
import 'package:smartnest/screens/level1_screen7.dart';
import 'package:smartnest/screens/level1_screen8.dart';
import 'package:smartnest/screens/level1_screen9.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'package:smartnest/widgets/button/button_activities.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  UserModel? _user;

  PhonologicalAwarenessModel? phonologicalAwareness1;
  PhonologicalAwarenessModel? phonologicalAwareness2;
  PhonologicalAwarenessModel? phonologicalAwareness3;
  PhonologicalAwarenessModel? phonologicalAwareness4;
  PhonologicalAwarenessModel? phonologicalAwareness5;
  PhonologicalAwarenessModel? phonologicalAwareness6;
  PhonologicalAwarenessModel? phonologicalAwareness7;
  PhonologicalAwarenessModel? phonologicalAwareness8;
  PhonologicalAwarenessModel? phonologicalAwareness9;
  PhonologicalAwarenessModel? phonologicalAwareness10;

  //TTS
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetchPhonologicalAwareness(1);
    fetchPhonologicalAwareness2(2);
    fetchPhonologicalAwareness3(3);
    fetchPhonologicalAwareness4(4);
    fetchPhonologicalAwareness5(5);
    fetchPhonologicalAwareness6(6);
    fetchPhonologicalAwareness7(7);
    fetchPhonologicalAwareness8(8);
    fetchPhonologicalAwareness9(9);
    fetchPhonologicalAwareness10(10);
    speak('Bienvenido al nivel 1, aquí encontrarás 10 actividades para mejorar tu conciencia fonológica. ¡Vamos a empezar!. Presionar click en una actividad para comenzar.');
  }

  //TTS
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  Future<void> fetchPhonologicalAwareness(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwareness1 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPhonologicalAwareness2(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwareness2 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPhonologicalAwareness3(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwareness3 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPhonologicalAwareness4(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwareness4 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPhonologicalAwareness5(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwareness5 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPhonologicalAwareness6(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwareness6 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPhonologicalAwareness7(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwareness7 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPhonologicalAwareness8(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwareness8 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPhonologicalAwareness9(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwareness9 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPhonologicalAwareness10(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwareness10 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Nivel 1', style: TextStyle(color: Colors.white)),
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
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
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
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Progreso de aprendizaje'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PercentageScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
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
              height: 630,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Ejercicios', style: TextStyle(fontSize: 18)),
                        Text('Estado', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Row with button and image
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonActivities(
                          text: 'Actividad 1',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Level1Screen()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            phonologicalAwareness1?.correct == false
                            ? 'lib/img/activitie_none.png'
                            : 'lib/img/activitie_check.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonActivities(
                          text: 'Actividad 2',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Level1Screen2()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            phonologicalAwareness2?.correct == false
                            ? 'lib/img/activitie_none.png'
                            : 'lib/img/activitie_check.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonActivities(
                          text: 'Actividad 3',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Level1Screen3()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            phonologicalAwareness3?.correct == false
                            ? 'lib/img/activitie_none.png'
                            : 'lib/img/activitie_check.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonActivities(
                          text: 'Actividad 4',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Level1Screen4()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            phonologicalAwareness4?.correct == false
                            ? 'lib/img/activitie_none.png'
                            : 'lib/img/activitie_check.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonActivities(
                          text: 'Actividad 5',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Level1Screen5()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            phonologicalAwareness5?.correct == false
                            ? 'lib/img/activitie_none.png'
                            : 'lib/img/activitie_check.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonActivities(
                          text: 'Actividad 6',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Level1Screen6()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            phonologicalAwareness6?.correct == false
                            ? 'lib/img/activitie_none.png'
                            : 'lib/img/activitie_check.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonActivities(
                          text: 'Actividad 7',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Level1Screen7()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            phonologicalAwareness7?.correct == false
                            ? 'lib/img/activitie_none.png'
                            : 'lib/img/activitie_check.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonActivities(
                          text: 'Actividad 8',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Level1Screen8()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            phonologicalAwareness8?.correct == false
                            ? 'lib/img/activitie_none.png'
                            : 'lib/img/activitie_check.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonActivities(
                          text: 'Actividad 9',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Level1Screen9()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            phonologicalAwareness9?.correct == false
                            ? 'lib/img/activitie_none.png'
                            : 'lib/img/activitie_check.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonActivities(
                          text: 'Actividad 10',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Level1Screen10()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            phonologicalAwareness10?.correct == false
                            ? 'lib/img/activitie_none.png'
                            : 'lib/img/activitie_check.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
