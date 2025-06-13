import 'package:flutter/material.dart';
import 'package:app_motoservice/models/historial_modelo.dart';
import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HistorialModelo> historialCompleto = [];

    for (var mototaxi in mototaxis) {
      for (var servicio in mototaxi.servicios) {
        historialCompleto.add(HistorialModelo(
          servicio: servicio,
          nombre: mototaxi.nombre,
          placa: mototaxi.placa,
        ));
      }
    }

    return Scaffold(
      backgroundColor: ColoresApp.fondo,
      appBar: AppBar(
        backgroundColor: ColoresApp.fondoTarjeta,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'Historial de Servicios',
          style: GoogleFonts.inter(
            fontSize: TamanoLetra.tituloGrande,
            fontWeight: FontWeight.bold,
            color: ColoresApp.textoOscuro,
          ),
        ),
        iconTheme: const IconThemeData(color: ColoresApp.textoOscuro),
      ),
      body: historialCompleto.isEmpty
          ? Center(
              child: Text(
                'No hay servicios registrados.',
                style: GoogleFonts.inter(
                  fontSize: TamanoLetra.textoNormal,
                  color: ColoresApp.textoMedio,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: historialCompleto.length,
              itemBuilder: (context, index) {
                final item = historialCompleto[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ColoresApp.fondoTarjeta,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.servicio.servicio,
                        style: GoogleFonts.inter(
                          fontSize: TamanoLetra.titulo,
                          fontWeight: FontWeight.w600,
                          color: ColoresApp.primario,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Cliente: ${item.nombre}',
                        style: GoogleFonts.inter(
                          fontSize: TamanoLetra.textoNormal,
                          color: ColoresApp.textoOscuro,
                        ),
                      ),
                      Text(
                        'Placa: ${item.placa}',
                        style: GoogleFonts.inter(
                          fontSize: TamanoLetra.textoNormal,
                          color: ColoresApp.textoMedio,
                        ),
                      ),
                      Text(
                        'Fecha: ${item.servicio.fecha}',
                        style: GoogleFonts.inter(
                          fontSize: TamanoLetra.textoNormal,
                          color: ColoresApp.textoMedio,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        item.servicio.detalles,
                        style: GoogleFonts.inter(
                          fontSize: TamanoLetra.textoPequeno,
                          color: ColoresApp.textoOscuro,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
