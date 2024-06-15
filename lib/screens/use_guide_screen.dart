import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/model/user.dart';
import 'package:smartnest/screens/home_screen.dart';
import 'package:smartnest/screens/levels_screen.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/screens/percentage_screen.dart';
import 'package:smartnest/screens/profile_screen.dart';
import 'package:smartnest/screens/settings_screen.dart';
import 'package:smartnest/widgets/button/button_primary2.dart';



import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:io';


class UseGuideScreen extends StatefulWidget {
  const UseGuideScreen({super.key});

  @override
  State<UseGuideScreen> createState() => _UseGuideScreenState();
  
}

class _UseGuideScreenState extends State<UseGuideScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuthServices _auth = FirebaseAuthServices();


  UserModel? _user;

  @override
  void initState() {
    super.initState();
    _loadUserData();

    
  }
  
  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
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
        title: const Text('Guia de Uso', style: TextStyle(color: Colors.white)),
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
                    const Text(
                      'Guía de Uso',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 312,
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130, 
                                    height: 150,
                                    child: Image.asset(
                                      'lib/img/youtube_icon.png', 
                                      fit: BoxFit.contain, 
                                    ),
                                  ),
                                  const SizedBox(width: 10), 
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Cómo iniciar sesión y registrarse',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ButtonPrimary2(onPressed: () async{
                                          const url = 'https://www.youtube.com/watch?v=g3BPbp1I3vY';
                                          _launchUrl(url);
                                        }, text: 'Ver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 312,
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130, 
                                    height: 150,
                                    child: Image.asset(
                                      'lib/img/youtube_icon.png', 
                                      fit: BoxFit.contain, 
                                    ),
                                  ),
                                  const SizedBox(width: 10), 
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Como restablecer contraseña',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ButtonPrimary2(onPressed: () async{
                                          const url = 'https://www.youtube.com/watch?v=Uu2xN3uHQ1I';
                                          _launchUrl(url);
                                        }, text: 'Ver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 312,
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130, 
                                    height: 150,
                                    child: Image.asset(
                                      'lib/img/youtube_icon.png', 
                                      fit: BoxFit.contain, 
                                    ),
                                  ),
                                  const SizedBox(width: 10), 
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Como acceder a la barra de navegación',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ButtonPrimary2(onPressed: () async{
                                          const url = 'https://www.youtube.com/watch?v=ioPsuz6z-zY';
                                          _launchUrl(url);
                                        }, text: 'Ver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 312,
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130, 
                                    height: 150,
                                    child: Image.asset(
                                      'lib/img/youtube_icon.png', 
                                      fit: BoxFit.contain, 
                                    ),
                                  ),
                                  const SizedBox(width: 10), 
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Como acceder a la guia de uso',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ButtonPrimary2(onPressed: () async{
                                          const url = 'https://www.youtube.com/watch?v=3oHk_4Mn-ac';
                                          _launchUrl(url);
                                        }, text: 'Ver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 312,
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130, 
                                    height: 150,
                                    child: Image.asset(
                                      'lib/img/youtube_icon.png', 
                                      fit: BoxFit.contain, 
                                    ),
                                  ),
                                  const SizedBox(width: 10), 
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Como acceder a la configuración',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ButtonPrimary2(onPressed: () async{
                                          const url = 'https://www.youtube.com/watch?v=rpmYr9iE4VU';
                                          _launchUrl(url);
                                        }, text: 'Ver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 312,
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130, 
                                    height: 150,
                                    child: Image.asset(
                                      'lib/img/youtube_icon.png', 
                                      fit: BoxFit.contain, 
                                    ),
                                  ),
                                  const SizedBox(width: 10), 
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Como acceder al progreso actual',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ButtonPrimary2(onPressed: () async{
                                          const url = 'https://www.youtube.com/watch?v=D9MUTgj_Lww';
                                         _launchUrl(url);
                                        }, text: 'Ver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 312,
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130, 
                                    height: 150,
                                    child: Image.asset(
                                      'lib/img/youtube_icon.png', 
                                      fit: BoxFit.contain, 
                                    ),
                                  ),
                                  const SizedBox(width: 10), 
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Como acceder a los niveles',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ButtonPrimary2(onPressed: () async{
                                          const url = 'https://www.youtube.com/watch?v=vyE0P5NSxLA';
                                          _launchUrl(url);
                                        }, text: 'Ver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 312,
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130, 
                                    height: 150,
                                    child: Image.asset(
                                      'lib/img/youtube_icon.png', 
                                      fit: BoxFit.contain, 
                                    ),
                                  ),
                                  const SizedBox(width: 10), 
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Como acceder al inicio',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ButtonPrimary2(onPressed: () async{
                                          const url = 'https://www.youtube.com/watch?v=MlKXBr_9NII';
                                          _launchUrl(url);
                                        }, text: 'Ver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 312,
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130, 
                                    height: 150,
                                    child: Image.asset(
                                      'lib/img/youtube_icon.png', 
                                      fit: BoxFit.contain, 
                                    ),
                                  ),
                                  const SizedBox(width: 10), 
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Como acceder al perfil de usuario',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ButtonPrimary2(onPressed: () async{
                                          const url = 'https://www.youtube.com/watch?v=ioIc9p21YJo';
                                         _launchUrl(url);
                                        }, text: 'Ver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Container(
                          width: 312,
                          height: 155,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130, 
                                    height: 150,
                                    child: Image.asset(
                                      'lib/img/youtube_icon.png', 
                                      fit: BoxFit.contain, 
                                    ),
                                  ),
                                  const SizedBox(width: 10), 
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Como resolver una actividad interactiva',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        ButtonPrimary2(onPressed: () async{
                                          const url = 'https://www.youtube.com/watch?v=7UHHam_QhAE';
                                         _launchUrl(url);
                                        }, text: 'Ver')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                      ],
                    ),
                    
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


