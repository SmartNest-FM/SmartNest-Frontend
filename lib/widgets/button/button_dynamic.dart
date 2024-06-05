import 'package:flutter/material.dart';

class ButtonDynamic extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final bool isCorrect;

  const ButtonDynamic({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isCorrect
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonColor = isCorrect ? Colors.green : Colors.red;
    return Container(
      width: 232,
      height: 60,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              // Cambia el color cuando el botón está presionado
              return buttonColor.withOpacity(0.8); // Opacidad reducida para dar retroalimentación visual
            }
            return buttonColor;
          }),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}