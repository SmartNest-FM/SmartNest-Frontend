import 'package:flutter/material.dart';

class ButtonGoogle extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String imageAsset;

  const ButtonGoogle({
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
      color: const Color(0xFFF04635),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              width: 20, 
              height: 20,
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