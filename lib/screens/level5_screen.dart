import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/levels_screen.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'package:smartnest/widgets/button/button_activities.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smartnest/widgets/button/button_correct.dart';
import 'package:smartnest/widgets/button/button_error.dart';

class Level5Screen extends StatefulWidget {
  const Level5Screen({super.key});

  @override
  State<Level5Screen> createState() => _Level5ScreenState();
}

class _Level5ScreenState extends State<Level5Screen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuthServices _auth = FirebaseAuthServices();

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
        title: const Text('Actividad 1', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
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
            const UserAccountsDrawerHeader(
              accountName: Text("José Perez Mansilla"),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('lib/img/img_user.jpg'),
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
                    onPressed: () {
                      // Aquí va la lógica para reproducir el enunciado
                    },
                  ),
                )
                ],
              ),
              const SizedBox(height: 60),
              
              CarouselSlider(
                options: CarouselOptions(
                  height: 150,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: [
                  'lib/img/level_1/img_cat.png',
                  'lib/img/level_1/img_cat.png',
                  'lib/img/level_1/img_cat.png',
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Image.asset(i, fit: BoxFit.cover);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  '¿Cuál es la oración correcta para estas imagenes?',
                  textAlign: TextAlign.center, // Asegura el centrado del texto
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              ButtonActivities(
                text: 'El gato esta comiendo',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              ButtonActivities(
                text: 'El gato esta llorando',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              ButtonActivities(
                text: 'El gato esta corriendo',
                onPressed: () {},
              ),
              const SizedBox(height: 30),
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
                    onPressed: () {
                      // Aquí va la lógica para reproducir el enunciado
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
