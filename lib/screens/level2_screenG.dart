import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:smartnest/config/api.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/env/env.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/fluent_reading.dart';
import 'package:smartnest/model/user.dart';

import 'package:smartnest/screens/activities2.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/levels_screen.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'package:smartnest/utils/celebration_helper.dart';

import 'package:smartnest/widgets/button/button_activities.dart';
import 'package:smartnest/widgets/button/button_primary2.dart';

class Level2ScreenG extends StatefulWidget {
  final int activityId; // 1..10
  const Level2ScreenG({super.key, required this.activityId});

  @override
  State<Level2ScreenG> createState() => _Level2ScreenGState();
}

class _Level2ScreenGState extends State<Level2ScreenG> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  UserModel? _user;
  FluentReadingModel? fluentReadingModel;

  String feedbackImageG = '';
  String feedbackMessageG = '';

  final FlutterSoundRecorder _soundRecorder = FlutterSoundRecorder();
  bool _recorderReady = false;

  bool microphoneActive = false;
  String gosuPath = '';

  final FlutterTts flutterTts = FlutterTts();

  late CelebrationHelper _celebration;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _celebration = CelebrationHelper();

    fetchFluentReading(widget.activityId);
    fetchFeedback(widget.activityId);

    requestPermissions();

    speak(
      'Actividad ${widget.activityId}. Responde cuál es la respuesta correcta. Presiona el botón de reproducir enunciado.',
    );
  }

  @override
  void dispose() {
    _celebration.dispose();
    super.dispose();
  }

  // =======================
  //         TTS
  // =======================
  Future<void> speak(String text) async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  // =======================
  //    PERMISOS/RECORDER
  // =======================
  Future<void> requestPermissions() async {
    final mic = await Permission.microphone.request();
    final storage = await Permission.storage.request();

    if (mic.isGranted && storage.isGranted) {
      await _initRecorderIfNeeded();
    }
  }

  Future<void> _initRecorderIfNeeded() async {
    if (_recorderReady) return;
    try {
      await _soundRecorder.openRecorder();
      _recorderReady = true;
    } catch (e) {}
  }

  // =======================
  //   SPEECH -> TEXT (WHISPER)
  // =======================
  Future<String> convertSpeechToText(String filePath) async {
    const apiKey = apiKeyWhisper;
    final url = Uri.https("api.openai.com", "/v1/audio/transcriptions");

    final request = http.MultipartRequest('POST', url);
    request.headers.addAll({"Authorization": "Bearer $apiKey"});
    request.fields["model"] = "whisper-1";
    request.fields["language"] = "es";
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    final response = await request.send();
    final newResponse = await http.Response.fromStream(response);
    final responseData = json.decode(newResponse.body);

    return responseData['text'] ?? '';
  }

  Future<void> startRecording() async {
    await _initRecorderIfNeeded();
    final tempDir = (await getTemporaryDirectory()).path;
    final audioFilePath = '$tempDir/audio_level2_${widget.activityId}.wav';

    try {
      await _soundRecorder.startRecorder(
        toFile: audioFilePath,
        codec: Codec.pcm16WAV,
      );

      gosuPath = audioFilePath;

      setState(() {
        microphoneActive = true;
      });
    } catch (e) {}
  }

  Future<void> stopRecording() async {
    try {
      final path = await _soundRecorder.stopRecorder();

      setState(() {
        microphoneActive = false;
      });

      if (path == null) return;

      final transcribedText = await convertSpeechToText(gosuPath);
      final correctAnswerRaw = fluentReadingModel?.correct_answer ?? '';

      final ok = fuzzyMatch(transcribedText, correctAnswerRaw);

      if (ok) {
        await updateUserResponse(transcribedText, fromVoice: true);
      } else {
        await _showRetryDialog();
      }

      final audioFile = File(gosuPath);
      if (await audioFile.exists()) {
        await audioFile.delete();
      }
    } catch (e) {}
  }

  // =======================
  //      NORMALIZE / FUZZY
  // =======================
  String normalizeText(String input) {
    String t = input.trim().toLowerCase();

    t = t
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u')
        .replaceAll('ñ', 'n');

    final reg = RegExp(r'[^a-zA-Z\s]');
    t = t.replaceAll(reg, '');

    t = t.replaceAll(RegExp(r'\s+'), ' ').trim();
    return t;
  }

  int levenshtein(String a, String b) {
    if (a == b) return 0;
    if (a.isEmpty) return b.length;
    if (b.isEmpty) return a.length;

    final dp = List.generate(
      a.length + 1,
      (_) => List<int>.filled(b.length + 1, 0),
    );

    for (int i = 0; i <= a.length; i++) dp[i][0] = i;
    for (int j = 0; j <= b.length; j++) dp[0][j] = j;

    for (int i = 1; i <= a.length; i++) {
      for (int j = 1; j <= b.length; j++) {
        final cost = a[i - 1] == b[j - 1] ? 0 : 1;
        dp[i][j] = [
          dp[i - 1][j] + 1,
          dp[i][j - 1] + 1,
          dp[i - 1][j - 1] + cost,
        ].reduce((x, y) => x < y ? x : y);
      }
    }
    return dp[a.length][b.length];
  }

  bool fuzzyMatch(String spokenRaw, String correctRaw) {
    final spoken = normalizeText(spokenRaw);
    final correct = normalizeText(correctRaw);

    if (spoken.isEmpty || correct.isEmpty) return false;
    if (spoken == correct) return true;

    final tokens = spoken.split(' ').where((t) => t.isNotEmpty).toList();

    int bestDist = levenshtein(spoken, correct);
    for (final t in tokens) {
      final d = levenshtein(t, correct);
      if (d < bestDist) bestDist = d;
    }

    final len = correct.length;
    final maxEdits = (len <= 3)
        ? 0
        : (len == 4)
            ? 1
            : (len <= 7)
                ? 2
                : 3;

    if (correct.length <= 4 && spoken.length <= 2) return false;

    return bestDist <= maxEdits;
  }

  // =======================
  //      FETCH ACTIVIDAD
  // =======================
  Future<void> fetchFluentReading(int id) async {
    try {
      final response = await http.get(Uri.parse(Api.fluentById(id)));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          fluentReadingModel = FluentReadingModel.fromMap(jsonResponse);
        });
      }
    } catch (e) {}
  }

  // =======================
  //        FEEDBACK
  // =======================
  Future<void> fetchFeedback(int activityId) async {
    try {
      final response =
          await http.get(Uri.parse(Api.fluentFeedback(activityId)));

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          final first = jsonResponse[0];
          setState(() {
            feedbackImageG = first['image'] ?? '';
            feedbackMessageG = first['feedback'] ?? '';
          });
        }
      }
    } catch (e) {}
  }

  // =======================
  //   UPDATE USER RESPONSE
  // =======================
  Future<void> updateUserResponse(
    String userResponse, {
    bool fromVoice = false,
  }) async {
    if (fluentReadingModel == null) return;

    final correct = fromVoice
        ? fuzzyMatch(userResponse, fluentReadingModel?.correct_answer ?? '')
        : normalizeText(userResponse) ==
            normalizeText(fluentReadingModel?.correct_answer ?? '');

    final update = FluentReadingModel(
      id: fluentReadingModel?.id ?? 0,
      main_image: fluentReadingModel?.main_image ?? '',
      question: fluentReadingModel?.question ?? '',
      statement: fluentReadingModel?.statement ?? '',
      user_response: userResponse,
      correct_answer: fluentReadingModel?.correct_answer ?? '',
      correct: correct,
      level_id: fluentReadingModel?.level_id ?? 0,
      answer_one: fluentReadingModel?.answer_one ?? '',
      answer_two: fluentReadingModel?.answer_two ?? '',
      answer_three: fluentReadingModel?.answer_three ?? '',
    );

    try {
      final response = await http.put(
        Uri.parse(Api.fluentById(fluentReadingModel?.id ?? widget.activityId)),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(update.toMap()),
      );

      if (response.statusCode == 200) {
        if (correct) {
          await saveProgress(score: 100);
          await _showSuccessDialog();
        } else {
          await _showRetryDialog();
        }
      }
    } catch (e) {}
  }

  // =======================
  //   GUARDAR PROGRESO REAL
  // =======================
  Future<void> saveProgress({required int score}) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final url =
        "${Api.saveFluentProgress(widget.activityId)}?uid=$uid&score=$score";

    try {
      await http.post(Uri.parse(url));
    } catch (e) {}
  }

  // =======================
  //        DIALOGS
  // =======================
  Future<void> _showSuccessDialog() async {
    await _celebration.celebrate();

    await speak('¡Genial!, ¡Lo hiciste fantástico ${_user?.nameuser ?? ""}!');

    if (!mounted) return;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(8),
                      child: const Center(
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
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/6142/6142783.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('¡Lo hiciste fantástico!',
                      style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonPrimary2(
                        onPressed: () {
                          Navigator.pop(context);

                          final nextId = widget.activityId + 1;
                          if (nextId <= 20) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    Level2ScreenG(activityId: nextId),
                              ),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Activities2Screen()),
                            );
                          }
                        },
                        text: 'Continuar',
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
            _celebration.buildConfetti(),
          ],
        );
      },
    );
  }

  Future<void> _showRetryDialog() async {
    await speak('¡Inténtalo de nuevo!. Te daré una pista. $feedbackMessageG');

    if (!mounted) return;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
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
                    padding: const EdgeInsets.all(8),
                    child: const Center(
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
                const SizedBox(height: 10),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    feedbackImageG,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        const Text('No se pudo cargar la imagen'),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Pista: $feedbackMessageG',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonPrimary2(
                      onPressed: () {
                        Navigator.pop(context);
                        fetchFluentReading(widget.activityId);
                        fetchFeedback(widget.activityId);
                      },
                      text: 'Reintentar',
                    ),
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  // =======================
  //        USER DATA
  // =======================
  Future<void> _loadUserData() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      final response = await http.get(Uri.parse(Api.userByUid(uid)));
      if (response.statusCode == 200) {
        final userData = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _user = UserModel.fromMap(userData);
        });
      }
    } catch (e) {}
  }

  Future<void> _signOut() async {
    try {
      await _auth.signOut();
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    } catch (e) {}
  }

  // =======================
  //         UI
  // =======================
  @override
  Widget build(BuildContext context) {
    final activityId = widget.activityId;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Actividad $activityId',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 40,
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Activities2Screen()),
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
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_user?.nameuser ?? "Nombre no disponible"),
              accountEmail: Text(_user?.emailuser ?? "Email no disponible"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: _user != null &&
                        _user!.photouser != null &&
                        File(_user!.photouser!).existsSync()
                    ? FileImage(File(_user!.photouser!))
                    : const AssetImage('lib/img/user_no_photo.png')
                        as ImageProvider,
              ),
              decoration: const BoxDecoration(color: Color(0xFF1D4F7C)),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.bar_chart),
              title: const Text('Niveles'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => LevelsScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.trending_up),
              title: const Text('Progreso de aprendizaje'),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PercentageScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configuración'),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
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
              // Reproducir enunciado
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Reproducir enunciado',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(
                    height: 60,
                    child: IconButton(
                      icon: Image.asset('lib/img/play_button_image.png'),
                      onPressed: () async {
                        await speak(
                          'Enunciado. ${fluentReadingModel?.statement ?? ''}. '
                          'Pregunta. ${fluentReadingModel?.question ?? ''}.',
                        );
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Statement
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  fluentReadingModel?.statement ?? '',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 20),

              // Imagen
              Image.network(
                fluentReadingModel?.main_image ?? '',
                width: 150,
                height: 150,
                errorBuilder: (_, __, ___) =>
                    const Text('No se pudo cargar la imagen'),
              ),

              const SizedBox(height: 20),

              // Pregunta
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  fluentReadingModel?.question ?? '',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

              // Respuestas
              ButtonActivities(
                text: fluentReadingModel?.answer_one ?? '',
                onPressed: () async {
                  final userResponse = fluentReadingModel?.answer_one ?? '';
                  if (userResponse.isNotEmpty) {
                    await updateUserResponse(userResponse);
                  }
                },
              ),
              const SizedBox(height: 10),
              ButtonActivities(
                text: fluentReadingModel?.answer_two ?? '',
                onPressed: () async {
                  final userResponse = fluentReadingModel?.answer_two ?? '';
                  if (userResponse.isNotEmpty) {
                    await updateUserResponse(userResponse);
                  }
                },
              ),
              const SizedBox(height: 10),
              ButtonActivities(
                text: fluentReadingModel?.answer_three ?? '',
                onPressed: () async {
                  final userResponse = fluentReadingModel?.answer_three ?? '';
                  if (userResponse.isNotEmpty) {
                    await updateUserResponse(userResponse);
                  }
                },
              ),

              const SizedBox(height: 30),

              // Micro
              if (!microphoneActive)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Responder',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    SizedBox(
                      height: 60,
                      child: IconButton(
                        icon: Image.asset('lib/img/microphone.png'),
                        onPressed: () async => startRecording(),
                      ),
                    ),
                  ],
                ),

              if (microphoneActive)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Grabando...',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    SizedBox(
                      height: 60,
                      child: IconButton(
                        icon: Image.asset('lib/img/stop_button_image.jpg'),
                        onPressed: () async => stopRecording(),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
