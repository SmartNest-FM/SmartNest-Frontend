import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/combination_reading_images.dart';
import 'package:smartnest/model/fluent_reading.dart';
import 'package:smartnest/model/phonological_awareness.dart';
import 'package:smartnest/model/reading_comprehension.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/model/vocabulary_verb.dart';
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

  var _valuePercentage = 0.0;

  UserModel? _user;

  //TTS
  FlutterTts flutterTts = FlutterTts();

  PhonologicalAwarenessModel? phonologicalAwarenessModel;
  PhonologicalAwarenessModel? phonologicalAwarenessModel2;
  FluentReadingModel? fluentReadingModel;
  FluentReadingModel? fluentReadingModel2;
  ReadingComprehensionModel? readingComprehensionModel;
  ReadingComprehensionModel? readingComprehensionModel2;
  CombinationReadingImagesModel? combinationReadingImagesModel;
  CombinationReadingImagesModel? combinationReadingImagesModel2;
  VocabularyVerbModel? vocabularyVerbModel;
  VocabularyVerbModel? vocabularyVerbModel2;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetchPhonologicalAwareness(5);
    fetchPhonologicalAwareness(5);
    fetchPhonologicalAwareness(5);
    fetchPhonologicalAwareness(5);
    fetchPhonologicalAwareness(5);
    fetchPhonologicalAwareness(10);
    fetchFluentReading(10);
    fetchReadingComprehension(10);
    fetchCombinationReadingImages(10);
    fetchVocabularyVerb(10);
  }

  Future<void> fetchVocabularyVerb(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel = VocabularyVerbModel.fromMap(jsonResponse); 
          _updateProgress();
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
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/vocabularyVerb/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          vocabularyVerbModel2 = VocabularyVerbModel.fromMap(jsonResponse); 
          _updateProgress();
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchCombinationReadingImages2(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/combinationReadingImages/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          combinationReadingImagesModel2 = CombinationReadingImagesModel.fromMap(jsonResponse); 
          _updateProgress();
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchCombinationReadingImages(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/combinationReadingImages/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          combinationReadingImagesModel = CombinationReadingImagesModel.fromMap(jsonResponse); 
          _updateProgress();
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchReadingComprehension(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/readingComprehension/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          readingComprehensionModel = ReadingComprehensionModel.fromMap(jsonResponse); 
          _updateProgress();
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchReadingComprehension2(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/readingComprehension/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          readingComprehensionModel2 = ReadingComprehensionModel.fromMap(jsonResponse); 
          _updateProgress();
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchPhonologicalAwareness(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/phonologicalAwareness/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          phonologicalAwarenessModel = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          _updateProgress();
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
          phonologicalAwarenessModel2 = PhonologicalAwarenessModel.fromMap(jsonResponse); 
          _updateProgress();
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchFluentReading(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/fluentReading/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          fluentReadingModel = FluentReadingModel.fromMap(jsonResponse); 
          _updateProgress();
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchFluentReading2(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/fluentReading/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          fluentReadingModel2 = FluentReadingModel.fromMap(jsonResponse); 
          _updateProgress();
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

   void _updateProgress() {
    double progress = 0.0;
    if (phonologicalAwarenessModel?.correct ?? false) progress += 0.10;
    if (phonologicalAwarenessModel2?.correct ?? false) progress += 0.10;
    if (fluentReadingModel?.correct ?? false) progress += 0.10;
    if (fluentReadingModel2?.correct ?? false) progress += 0.10;
    if (readingComprehensionModel?.correct ?? false) progress += 0.10;
    if (readingComprehensionModel2?.correct ?? false) progress += 0.10;
    if (combinationReadingImagesModel?.correct ?? false) progress += 0.10;
    if (combinationReadingImagesModel2?.correct ?? false) progress += 0.10;
    if (vocabularyVerbModel?.correct ?? false) progress += 0.10;
    if (vocabularyVerbModel2?.correct ?? false) progress += 0.10;

    setState(() {
      _valuePercentage = progress;
    });
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
      print('Error: $e');
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
              height: 480,
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
                  ),
                  const SizedBox(height: 30),
                  ButtonSecondary2(onPressed: (){
                    speak('Vamos por buen camino ${_user?.nameuser}. ¡Tú puedes!');
                  }, text: '¡Sigue Estudiando!'),
                  const SizedBox(height: 30),
                  ButtonPrimary(onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LevelsScreen()),
                    );
                  }, text: 'Comenzar')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


