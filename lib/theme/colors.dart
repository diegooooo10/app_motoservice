import 'package:flutter/material.dart';

class ColoresApp {
  static const Color primario = Color(0xFF0077B6);
  static const Color primarioClaro = Color(0xFF00B4D8);
  static const Color primarioOscuro = Color(0xFF03045E);

  static const Color acento = Color(0xFFFF9900);
  static const Color acentoClaro = Color(0xFFFFB144);
  static const Color acentoOscuro = Color(0xFFE67700);

  static const Color exito = Color(0xFF10B981);
  static const Color advertencia = Color(0xFFFBBF24);
  static const Color error = Color(0xFFEF4444);

  static const Color textoOscuro = Color(0xFF111827);
  static const Color textoMedio = Color(0xFF4B5563);
  static const Color textoClaro = Color(0xFF9CA3AF);

  static const Color fondo = Color(0xFFF9FAFB);
  static const Color fondoTarjeta = Color(0xFFFFFFFF);

  static const Color borde = Color(0xFFE5E7EB);
  static const Color gris = Color(0xFF6B7280);
  static const Color divisor = Color(0xFFE5E7EB);
}

/*
Ejemplo de uso: 
Container(
  color: ColoresApp.gris,
  child: Text(
    'Hola mundo',
    style: TextStyle(color: ColoresApp.textoOscuro),
  ),
);
*/
