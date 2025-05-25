class TamanoLetra {
  static const double tituloGrande = 24.0;
  static const double tituloMediano = 20.0;
  static const double textoNormal = 16.0;
  static const double textoPequeno = 14.0;
  static const double textoMuyPequeno = 12.0;
  static const double textoError = 11.0;
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
