import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/model/vocabulary_verb.dart';
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
import 'package:smartnest/screens/level2_screen5.dart';
import 'package:smartnest/screens/level5_screen.dart';
import 'package:smartnest/screens/level5_screen10.dart';
import 'package:smartnest/screens/level5_screen2.dart';
import 'package:smartnest/screens/level5_screen3.dart';
import 'package:smartnest/screens/level5_screen4.dart';
import 'package:smartnest/screens/level5_screen5.dart';
import 'package:smartnest/screens/level5_screen6.dart';
import 'package:smartnest/screens/level5_screen7.dart';
import 'package:smartnest/screens/level5_screen8.dart';
import 'package:smartnest/screens/level5_screen9.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'package:smartnest/widgets/button/button_activities.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class Activities5Screen extends StatefulWidget {
  const Activities5Screen({super.key});

  @override
  State<Activities5Screen> createState() => _Activities5ScreenState();
}

class _Activities5ScreenState extends State<Activities5Screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  UserModel? _user;

  VocabularyVerbModel? vocabularyVerbModel;
  VocabularyVerbModel? vocabularyVerbModel2;
  VocabularyVerbModel? vocabularyVerbModel3;
  VocabularyVerbModel? vocabularyVerbModel4;
  VocabularyVerbModel? vocabularyVerbModel5;
  VocabularyVerbModel? vocabularyVerbModel6;
  VocabularyVerbModel? vocabularyVerbModel7;
  VocabularyVerbModel? vocabularyVerbModel8;
  VocabularyVerbModel? vocabularyVerbModel9;
  VocabularyVerbModel? vocabularyVerbModel10;


  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetchVocabularyVerb(1);
    fetchVocabularyVerb2(2);
    fetchVocabularyVerb3(3);
    fetchVocabularyVerb4(4);
    fetchVocabularyVerb5(5);
    fetchVocabularyVerb6(6);
    fetchVocabularyVerb7(7);
    fetchVocabularyVerb8(8);
    fetchVocabularyVerb9(9);
    fetchVocabularyVerb10(10);
  }

  Future<void> fetchVocabularyVerb(int id) async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel = VocabularyVerbModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchVocabularyVerb2(int id) async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel2 = VocabularyVerbModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchVocabularyVerb3(int id) async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel3 = VocabularyVerbModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchVocabularyVerb4(int id) async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel4 = VocabularyVerbModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchVocabularyVerb5(int id) async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel5 = VocabularyVerbModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchVocabularyVerb6(int id) async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel6 = VocabularyVerbModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchVocabularyVerb7(int id) async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel7 = VocabularyVerbModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchVocabularyVerb8(int id) async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel8 = VocabularyVerbModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchVocabularyVerb9(int id) async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel9 = VocabularyVerbModel.fromMap(jsonResponse); 
          
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchVocabularyVerb10(int id) async {
    try {
      var response = await http.get(Uri.parse('http://10.0.2.2:8080/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel10 = VocabularyVerbModel.fromMap(jsonResponse); 
          
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
        title: const Text('Nivel 5', style: TextStyle(color: Colors.white)),
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
                              MaterialPageRoute(builder: (context) => const Level5Screen()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            vocabularyVerbModel?.correct == false
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
                              MaterialPageRoute(builder: (context) => const Level5Screen2()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            vocabularyVerbModel2?.correct == false
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
                              MaterialPageRoute(builder: (context) => const Level5Screen3()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            vocabularyVerbModel3?.correct == false
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
                              MaterialPageRoute(builder: (context) => const Level5Screen4()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            vocabularyVerbModel4?.correct == false
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
                              MaterialPageRoute(builder: (context) => const Level5Screen5()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            vocabularyVerbModel5?.correct == false
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
                              MaterialPageRoute(builder: (context) => const Level5Screen6()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            vocabularyVerbModel6?.correct == false
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
                              MaterialPageRoute(builder: (context) => const Level5Screen7()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            vocabularyVerbModel7?.correct == false
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
                              MaterialPageRoute(builder: (context) => const Level5Screen8()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            vocabularyVerbModel8?.correct == false
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
                              MaterialPageRoute(builder: (context) => const Level5Screen9()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            vocabularyVerbModel9?.correct == false
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
                              MaterialPageRoute(builder: (context) => const Level5Screen10()),
                            );
                          },
                        ),
                        ClipOval(
                          child: Image.asset(
                            vocabularyVerbModel10?.correct == false
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
