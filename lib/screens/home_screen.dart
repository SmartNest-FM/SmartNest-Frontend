import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/firebase_auth_project/firebase_auth_services.dart';
import 'package:smartnest/screens/main_screens/welcome_screen.dart';
import 'package:smartnest/widgets/button/button_primary.dart';
import 'package:smartnest/widgets/button/button_secondary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FirebaseAuthServices _auth = FirebaseAuthServices();


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.getColorThemes()[0],
              AppTheme.getColorThemes()[6]
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ), 
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('SmartNest', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
              const SizedBox(height: 30, width: 420),
              /* ButtonPrimary(onPressed: (){
                _signOut();
                
              }, text: 'Salir de sesión') */
               GestureDetector(
                onTap: () {
                  // Llevar al screen de niveles
                },
                child: Container(
                  width: 365,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D4F7C),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Hora de aprender',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Image.asset(
                                'lib/img/welcome_img.png',
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              'Inicia aquí tus ejercicios de lectura',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          
                        ),
                                              
                      ],
                    ),
                  ),
                  
                ),
              ),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  // Llevar al screen de progreso de aprendizaje
                },
                child: Container(
                  width: 365,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D4F7C),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Progreso de\nAprendizaje',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Image.asset(
                                'lib/img/percentage.png',
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              'Mire su proceso de aprendizaje de los ejercicios',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                         // Espacio entre el texto y la imagen
                        
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  // Llevar al screen de guia de uso
                },
                child: Container(
                  width: 365,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D4F7C),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Guia de Uso',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Image.asset(
                                'lib/img/youtube_icon.png',
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  'Vea los videos guia referentes al uso del aplicativo',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                         // Espacio entre el texto y la imagen
                        
                      ],
                    ),
                  ),
                ),
              ),
            ],
            
          ),
        
      ),
    );
  }
}