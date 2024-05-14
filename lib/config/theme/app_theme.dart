import 'package:flutter/material.dart';


const Color _customMainColor  = Color(0xFFFF4343);
const Color _customMainColor2 = Color(0xFFDA6773);
const Color _customMainColor3 = Color(0xFFB67A92);
const Color _customMainColor4 = Color(0xFF988BAC);
const Color _customMainColor5 = Color(0xFF7A9BC6);
const Color _customMainColor6 = Color(0xFF6AA3D3);
const Color _customMainColor7 = Color(0xFF4BB3EE);


class AppTheme {
  final int selectedColor;
  
  // Lista de colores disponibles
  static const List<Color> _colorThemes = [
    _customMainColor,
    _customMainColor2,
    _customMainColor3,
    _customMainColor4,
    _customMainColor5,
    _customMainColor6,
    _customMainColor7,
    
    Colors.blue,
    Colors.teal,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
  ];

  AppTheme({
    this.selectedColor = 0,
  }) : assert(selectedColor >= 0 && selectedColor < _colorThemes.length);

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
      brightness: Brightness.light,
    );
  }

  // Método estático para obtener la lista de colores
  static List<Color> getColorThemes() {
    return _colorThemes;
  }
}