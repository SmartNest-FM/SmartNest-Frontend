import 'package:flutter/material.dart';
import 'package:smartnest/config/theme/app_theme.dart';
import 'package:smartnest/screens/main_screens/main_login.dart';
import 'package:smartnest/widgets/button/button1.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _termsAndConditionsAccepted = false;

  void _showTermsAndConditionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.75),
          content: SingleChildScrollView(
            child: Card(
              color: Colors.black.withOpacity(0.75),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Términos y Condiciones',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Introducción\n'
                      'Bienvenido a SmartNest (en adelante, "el Aplicativo"). Al utilizar el Aplicativo, usted acepta estar sujeto a los siguientes términos y condiciones (en adelante, "los Términos"). Si no está de acuerdo con estos Términos, no debe utilizar el Aplicativo.\n\n'
                      '2. Descripción del Servicio\n'
                      'El Aplicativo utiliza inteligencia artificial (IA) para mejorar la comprensión lectora de los usuarios, especialmente niños con síndrome de Down, mediante ejercicios y análisis personalizados que incluyen el uso reconocimiento de voz y conversión de texto a voz.\n\n'
                      '3. Elegibilidad y Autorización de Padres\n'
                      'Para los usuarios menores de 18 años, se requiere el consentimiento explícito de los padres o tutores legales. Al aceptar estos Términos, los padres o tutores legales confirman que tienen la autoridad para permitir el uso del Aplicativo por parte del menor y que han leído y entendido estos Términos y la Política de Privacidad.\n\n'
                      '4. Uso Aceptable\n'
                      'Usted se compromete a utilizar el Aplicativo de manera responsable y a no:\n'
                      '• Utilizar el Aplicativo para cualquier propósito ilegal o no autorizado.\n'
                      '• Interferir o interrumpir el funcionamiento del Aplicativo.\n'
                      '• Intentar acceder sin autorización a otros sistemas informáticos a través del Aplicativo.\n\n'
                      '5. Propiedad Intelectual\n'
                      'Todos los contenidos, marcas registradas, logotipos y otros elementos del Aplicativo son propiedad de SmartNest o de sus respectivos propietarios. Usted no adquiere ningún derecho de propiedad intelectual al utilizar el Aplicativo.\n\n'
                      '6. Modificaciones\n'
                      'SmartNest se reserva el derecho de modificar estos Términos en cualquier momento. Las modificaciones serán efectivas una vez publicadas en el Aplicativo. Es su responsabilidad revisar periódicamente estos Términos.\n\n'
                      '7. Terminación\n'
                      'SmartNest puede suspender o terminar su acceso al Aplicativo en cualquier momento y por cualquier motivo, incluyendo pero no limitado a, el incumplimiento de estos Términos.\n\n'
                      'Política de Privacidad\n'
                      '1. Introducción\n'
                      'La privacidad de nuestros usuarios es de suma importancia para SmartNest. Esta Política de Privacidad describe cómo recopilamos, utilizamos y protegemos la información personal de los usuarios del Aplicativo.\n\n'
                      '2. Información Recopilada\n'
                      'Recopilamos información personal de los usuarios cuando se registran en el Aplicativo, incluyendo pero no limitado a:\n'
                      '• Nombres y apellidos del tutor a cargo del menor\n'
                      '• Nombres y apellidos del menor de edad\n'
                      '• Dirección de correo electrónico\n'
                      '• Edad\n'
                      '• Datos de uso del Aplicativo y rendimiento en los ejercicios de comprensión lectora\n\n'
                      '3. Uso de la Información\n'
                      'La información recopilada se utiliza para:\n'
                      '• Personalizar y mejorar la experiencia de aprendizaje.\n'
                      '• Analizar el rendimiento y proporcionar informes a los padres o tutores.\n'
                      '• Enviar comunicaciones relacionadas con el Aplicativo.\n\n'
                      '4. Compartición de la Información\n'
                      'No compartimos información personal con terceros, excepto en los siguientes casos:\n'
                      '• Con el consentimiento explícito de los padres o tutores legales.\n'
                      '• Para cumplir con requisitos legales o responder a procesos judiciales.\n\n'
                      '5. Seguridad\n'
                      'Implementamos medidas de seguridad técnicas y organizativas para proteger la información personal de los usuarios contra el acceso no autorizado, la pérdida o el uso indebido.\n\n'
                      '6. Derechos de los Usuarios\n'
                      'Los usuarios tienen derecho a:\n'
                      '• Acceder a su información personal.\n'
                      '• Solicitar la corrección de datos inexactos.\n'
                      '• Solicitar la eliminación de sus datos personales.\n'
                      '• Retirar el consentimiento para el tratamiento de sus datos.\n\n'
                      '7. Cumplimiento con Normativas\n'
                      'Nos comprometemos a cumplir con las leyes de protección de datos aplicables, incluyendo la Ley 29733 de Protección de Datos Personales y la Ley 29973 de Normativa para Personas con Discapacidad en Perú. Esto implica que tomaremos todas las medidas necesarias para asegurar la privacidad y seguridad de los datos personales de los usuarios.\n\n'
                      '8. Contacto\n'
                      'Si tiene alguna pregunta o inquietud sobre esta Política de Privacidad, puede contactarnos en:\n'
                      'smartnest@gmail.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _termsAndConditionsAccepted = true;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('Aceptar'),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.getColorThemes()[0],
              AppTheme.getColorThemes()[6],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            const Center(
              child: Text(
                'SmartNest',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Image.asset('lib/img/welcome_img.png', height: 237),
            const SizedBox(height: 70),
            if(_termsAndConditionsAccepted == true)
            Button1(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainLogin()),
                );
              },
              text: 'Comenzar',
            ),
            const SizedBox(height: 130),
            GestureDetector(
              onTap: _showTermsAndConditionsDialog,
              child: Container(
                width: 300,
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      ),
                      children: [
                        TextSpan(
                          text: 'Al usar SmartNest, acepto ',
                        ),
                        TextSpan(
                          text: 'términos de uso y políticas de privacidad',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
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
