import 'package:flutter/material.dart';

class ButtonFb extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String imageAsset;

  const ButtonFb({
    required this.onPressed,
    required this.text,
    required this.imageAsset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 231,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF305790),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              width: 25, 
              height: 25,
            ),
            const SizedBox(width: 15),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ),
    );
  }
}