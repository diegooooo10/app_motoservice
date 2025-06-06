import 'package:flutter_screenutil/flutter_screenutil.dart';

class TamanoLetra {
  static double get tituloGrande    => 20.sp; 
  static double get titulo          => 18.sp; 
  static double get subtitulo       => 16.sp; 
  static double get textoNormal     => 14.sp;
  static double get textoPequeno    => 11.sp; 
  static double get textoError      => 11.sp; 
}
/*
Ejemplo de uso: 
Container(
  color: ColoresApp.gris,
  child: Text(
    'Hola mundo',
    style: GoogleFonts.inter(fontSize: TamanoLetra.tituloGrande),
  ),
);
*/
