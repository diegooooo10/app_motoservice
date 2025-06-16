import 'package:app_motoservice/models/historial_modelo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/theme/typography.dart';

class ServicioHistorial extends StatelessWidget {
  final HistorialModelo item;
  const ServicioHistorial({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.servicio.servicio,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: TamanoLetra.subtitulo,
                    color: ColoresApp.textoOscuro,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: ColoresApp.primarioClaro,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    item.placa,
                    style: GoogleFonts.montserrat(
                      color: ColoresApp.primario,
                      fontWeight: FontWeight.w600,
                      fontSize: TamanoLetra.textoPequeno,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              item.servicio.detalles,
              style: GoogleFonts.inter(
                fontSize: TamanoLetra.textoPequeno,
                color: ColoresApp.textoMedio,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: TamanoIcono.mediano,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  '${item.servicio.fecha}',
                  style: GoogleFonts.inter(
                    fontSize: TamanoLetra.textoPequeno,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                Icon(Icons.person, size: 18, color: ColoresApp.textoMedio),
                const SizedBox(width: 4),
                Text(
                  item.nombre,
                  style: GoogleFonts.inter(
                    fontSize: TamanoLetra.textoPequeno,
                    color: ColoresApp.textoMedio,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
