import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CelebrationHelper {
  final ConfettiController confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  CelebrationHelper({Duration duration = const Duration(seconds: 2)})
      : confettiController = ConfettiController(duration: duration);

  /// 🎉 Ejecuta confeti + sonido
  Future<void> celebrate() async {
    confettiController.play();
    await _audioPlayer.play(
      AssetSource('sounds/confetti.mp3'),
      volume: 0.6,
    );
  }

  /// 🧹 Limpieza
  void dispose() {
    confettiController.dispose();
    _audioPlayer.dispose();
  }

  /// 🎊 Widget para colocar encima del popup
  Widget buildConfetti() {
    return ConfettiWidget(
      confettiController: confettiController,
      blastDirectionality: BlastDirectionality.explosive,
      shouldLoop: false,
      emissionFrequency: 0.05,
      numberOfParticles: 25,
      gravity: 0.3,
      colors: const [
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.pink,
        Colors.purple,
      ],
    );
  }
}
