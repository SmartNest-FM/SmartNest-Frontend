import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/env/env.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/fluent_reading.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/screens/activities2.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/level2_screen7.dart';
import 'package:smartnest/screens/levels_screen.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'package:smartnest/widgets/button/button_activities.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartnest/widgets/button/button_primary2.dart';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


import 'package:flutter_tts/flutter_tts.dart';

class Level2Screen6 extends StatefulWidget {
  const Level2Screen6({super.key});

  @override
  State<Level2Screen6> createState() => _Level2Screen6State();
}

class _Level2Screen6State extends State<Level2Screen6> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  UserModel? _user;

  FluentReadingModel? fluentReadingModel;

  bool _isCorrectAnswer = false;

   FluentReadingModel? fluentReadingModelUpdate;

   String feedbackImageG = ''; 
  String feedbackMessageG = ''; 

  final FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  
  String audioFilePathG = '';

  bool microphone_active = false;

  String gosuPath = '';

  String answerRecorder = ''; 

  //TTS
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetchFluentReading(6);
    fetchFeedback(6);
    requestPermissions();
    speak('Responde cuál es la respuesta correcta para la siguiente actividad. Presione click en el botón de reproducir enunciado');
  }

  //TTS
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  Future<void> requestPermissions() async {
    if (await Permission.microphone.request().isGranted &&
        await Permission.storage.request().isGranted) {
        _initRecorder();
    } else {
      print('Permission denied' );
    }
  }

  void _initRecorder() async {
    try {
      await _soundRecorder.openAudioSession();
      print('Audio session opened');
    } catch (e) {
      print('Error opening audio session: $e');
    }
  }

  Future<String> convertSpeechToText(String filePath) async{

    const apiKey = apiKeyWhisper;
    var url = Uri.https("api.openai.com", "/v1/audio/transcriptions");
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({"Authorization":"Bearer $apiKey"});
    request.fields["model"] = "whisper-1";
    request.fields["language"] = "es";
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    var response = await request.send();
    var newresponse =await http.Response.fromStream(response);
    final responseData = json.decode(newresponse.body);
    
    return responseData['text'] ?? '';
  }

  Future<void> startRecording() async {
    String tempDir = (await getTemporaryDirectory()).path;
    String audioFilePath = '$tempDir/audio_temp0.wav';

    print('Recording started, audio file saved at: $audioFilePath');
    audioFilePathG = audioFilePath;

    try {
      await _soundRecorder.startRecorder(
        toFile: audioFilePath, // Ruta donde se guardará el archivo de audio
        codec: Codec.pcm16WAV,
      );
      print('Recording started in the path: $audioFilePath');

      gosuPath = audioFilePath;

      setState(() {
        microphone_active = true;
      });
    } catch (e) {
      print('Error starting recording: $e');
    }
  }

  Future<void> stopRecording() async {
      try {
      String? path = await _soundRecorder.stopRecorder();
      if (path != null) {
        print('Recording stopped, audio file saved at: $gosuPath');
         // Aquí se envia el archivo de audio para su transcripción
        String transcribedText = await convertSpeechToText('$gosuPath');

        // Limpiar el texto transcrito
        String cleanedText = transcribedText.trim().toLowerCase();
      
        // Enviar al metodo clean para limpiar caracteres
        cleanedText = cleanText(cleanedText);

        //Guardamos el dato en una variable
        answerRecorder = cleanedText;

        print('Transcribed text: $answerRecorder');

        //convertir todo el texto en minuscula y comparar con la repsuesta en estatico
        if(answerRecorder =='violin' || answerRecorder =='violín'){
          _showSuccessDialog();
        }else{
          _showRetryDialog();
        }

        // Eliminar el archivo después de completar las operaciones necesarias
        File audioFile = File(gosuPath);
        if (await audioFile.exists()) {
          await audioFile.delete();
          print('Audio file deleted: $gosuPath');
        } else {
          print('Audio file not found: $gosuPath');
        }
      } else {
        print('Recording stopped, but path is null');
      }

      setState(() {
        microphone_active = false;
      });
    } catch (e) {
      print('Error stopping recording: $e');
    }
  }

  String cleanText(String input) {
    final RegExp regex = RegExp(r'[^a-zA-ZáéíóúÁÉÍÓÚñÑ\s]');
    return input.replaceAll(regex, '');
  }

  Future<void> fetchFluentReading(int id) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/fluentReading/$id'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
         setState(() {
          fluentReadingModel = FluentReadingModel.fromMap(jsonResponse); 
          
        });
        print( fluentReadingModel?.main_image ?? '');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchFeedback(int activityId) async {
    try {
      var response = await http.get(Uri.parse('https://smartnest.azurewebsites.net/fluent/$activityId'));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          var firstActivity = jsonResponse[0]; // Tomar solo el primer elemento de la lista
          String feedbackImage = firstActivity['image'];
          String feedbackMessage = firstActivity['feedback'];
          setState(() {
            feedbackImageG = feedbackImage;
            feedbackMessageG = feedbackMessage;
          });
        } else {
          print('La respuesta del servidor está vacía o no es una lista.');
        }
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _showSuccessDialog() async {
    speak('¡Genial!, ¡Lo hiciste fantástico ${_user?.nameuser}!');
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // El dialogo no se puede cerrar tocando fuera de él
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '¡Genial!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/6142/6142783.png',
                    fit: BoxFit.contain, // Ajusta la imagen al contenedor
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '¡Lo hiciste fantástico!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonPrimary2(
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Level2Screen7()),
                        );
                      },
                      text: 'Continuar'
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> updateUserResponse(String? userResponse) async {
    if (fluentReadingModel == null || fluentReadingModel?.level_id == null) {
      print('Fluent reading model or level id is null');
      return;
    }

    fluentReadingModelUpdate = FluentReadingModel(
      id: fluentReadingModel?.id ?? 0,
      main_image: fluentReadingModel?.main_image ?? '',
      question: fluentReadingModel?.question ?? '',
      statement: fluentReadingModel?.statement ?? '',
      user_response: userResponse ?? '',
      correct_answer: fluentReadingModel?.correct_answer ?? '',
      correct: userResponse == fluentReadingModel?.correct_answer,
      level_id: fluentReadingModel?.level_id ?? 0,
      answer_one: fluentReadingModel?.answer_one ?? '',
      answer_two: fluentReadingModel?.answer_two ?? '',
      answer_three: fluentReadingModel?.answer_three ?? '',
    );

    print('fluentReadingUpdate: ${fluentReadingModelUpdate?.toMap()}');

    try {
      var response = await http.put(
        Uri.parse('https://smartnest.azurewebsites.net/fluentReading/${fluentReadingModel?.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(fluentReadingModelUpdate?.toMap()),
      );

      if (response.statusCode != 200) {
        print('Failed to update user response: ${response.statusCode}');
        print('Response body: ${response.body}');
      } else {
        print('User response updated successfully');
        if (userResponse == fluentReadingModel?.correct_answer) {
          _showSuccessDialog();
        }else{
          _showRetryDialog();
        }
      }
    } catch (e) {
      print('Error while updating user response: $e');
    }
  }

  Future<void> _showRetryDialog() async {
    speak('¡Inténtalo de nuevo!. Te daré una pista. ${feedbackMessageG}');
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          '¡Inténtalo de nuevo!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    feedbackImageG,
                    fit: BoxFit.contain,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Text('Failed to load image: $error');
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    'Pista: ${feedbackMessageG}',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonPrimary2(
                      onPressed: (){
                        Navigator.pop(context); // Cerrar el diálogo
                        fetchFluentReading(6);
                        fetchFeedback(6); 
                      },
                      text: 'Reintentar',
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      },
    );
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
      if (!mounted) return;
      Navigator.pushReplacement(
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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Actividad 6', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Activities2Screen()),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pushReplacement(
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
                        MaterialPageRoute(builder: (context) => LevelsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Progreso de aprendizaje'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PercentageScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Cerrar sesión'),
              onTap: _signOut,
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
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Reproducir enunciado',
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                  SizedBox(
                  height: 60.0, // Aquí defines la altura deseada
                  child: IconButton(
                    icon: Image.asset('lib/img/play_button_image.png'),
                    onPressed: () async{
                      await speak('Enunciado. ${fluentReadingModel?.statement ?? ''}');
                      await speak('Pregunta. ${fluentReadingModel?.question ?? ''}');
                    },
                  ),
                )
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0), // Espacio a los lados
                  child: Text(
                    fluentReadingModel?.statement ?? '',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    textAlign: TextAlign.center, // Centra el texto dentro del contenedor
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Image.network(
                fluentReadingModel?.main_image ?? '',
                width: 150,
                height: 150,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Text('Failed to load image: $error');
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                fluentReadingModel?.question ?? '',
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              ButtonActivities(
                text: fluentReadingModel?.answer_one ?? '',
                onPressed: () async{
                  String? userResponse = fluentReadingModel?.answer_one;
                  if (userResponse != null) {
                    await updateUserResponse(userResponse);
                  } else {
                    // Manejar el caso de respuesta nula, por ejemplo, mostrando un mensaje al usuario
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, selecciona una respuesta')),
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
              ButtonActivities(
                text: fluentReadingModel?.answer_two ?? '',
                onPressed: () async{
                  String? userResponse = fluentReadingModel?.answer_two;
                  if (userResponse != null) {
                    await updateUserResponse(userResponse);
                  } else {
                    // Manejar el caso de respuesta nula, por ejemplo, mostrando un mensaje al usuario
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, selecciona una respuesta')),
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
              ButtonActivities(
                text: fluentReadingModel?.answer_three ?? '',
                onPressed: () async{
                  String? userResponse = fluentReadingModel?.answer_three;
                  if (userResponse != null) {
                    await updateUserResponse(userResponse);
                  } else {
                    // Manejar el caso de respuesta nula, por ejemplo, mostrando un mensaje al usuario
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, selecciona una respuesta')),
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
              if(microphone_active==false)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Responder',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                    SizedBox(
                    height: 60.0, // Aquí defines la altura deseada
                    child: IconButton(
                      icon: Image.asset('lib/img/microphone.png'),
                      onPressed: () async{                      
                        await startRecording();
                      },
                    ),
                  )
                  ],
                ),
              if(microphone_active==true) 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Grabando...',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                    SizedBox(
                    height: 60.0, // Aquí defines la altura deseada
                    child: IconButton(
                      icon: Image.asset('lib/img/stop_button_image.jpg'),
                      onPressed: () async{
                        await stopRecording();
                      },
                    ),
                  )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
