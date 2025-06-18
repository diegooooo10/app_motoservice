import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:app_motoservice/services/firebase_service.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:app_motoservice/widgets/mototaxi_descripcion.dart';
import 'package:app_motoservice/screens/barra_navegacion.dart';

class DetalleMototaxiScreen extends StatelessWidget {
  final Mototaxi mototaxi;

  const DetalleMototaxiScreen({Key? key, required this.mototaxi})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoresApp.fondo,
      appBar: AppBar(
        title: Text(
          'Detalles',
          style: GoogleFonts.inter(
            fontSize: TamanoLetra.tituloGrande,
            fontWeight: FontWeight.bold,
            color: ColoresApp.textoOscuro,
          ),
        ),
        elevation: 0,
        foregroundColor: ColoresApp.textoOscuro,
      ),
      body: StreamBuilder<Mototaxi>(
        stream: FirebaseService.streamMototaxi(mototaxi.placa),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Text(
                'Error al cargar datos',
                style: TextStyle(color: ColoresApp.error),
              ),
            );
          }
          final mototaxi = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: ColoresApp.fondoTarjeta,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // placa + nombre
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mototaxi.placa,
                              style: GoogleFonts.inter(
                                fontSize: TamanoLetra.subtitulo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              mototaxi.nombre,
                              style: GoogleFonts.montserrat(
                                fontSize: TamanoLetra.textoNormal,
                                color: ColoresApp.textoMedio,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          tooltip: 'Eliminar Mototaxi',
                          icon: const Icon(
                            Icons.delete,
                            color: ColoresApp.error,
                          ),
                          onPressed: () {
                            _confirmarEliminar(context, mototaxi.placa);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Servicios',
                      style: GoogleFonts.inter(
                        fontSize: TamanoLetra.titulo,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        // Navega al formulario de nuevo servicio
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => BarraNavegacion(
                                  selectedIndex: 1,
                                  formularioInitialTab: 1,
                                  mototaxiPlaca: mototaxi.placa,
                                ),
                          ),
                          (_) => false,
                        );
                      },
                      icon: const Icon(
                        Icons.add_circle_outline_outlined,
                        color: ColoresApp.primario,
                      ),
                      label: Text(
                        'Agregar servicio',
                        style: GoogleFonts.montserrat(
                          color: ColoresApp.primario,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child:
                      mototaxi.servicios.isEmpty
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
                            itemCount: mototaxi.servicios.length,
                            itemBuilder: (context, index) {
                              final servicio = mototaxi.servicios[index];
                              return MototaxiDescripcion(
                                index: index,
                                servicio: servicio,
                                mototaxi: mototaxi,
                              );
                            },
                          ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _confirmarEliminar(BuildContext context, String placa) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: ColoresApp.fondoTarjeta,
          title: Text(
            'Eliminar mototaxi',
            style: GoogleFonts.inter(fontSize: TamanoLetra.titulo),
          ),
          content: Text(
            '¿Estás seguro? Esta acción no se puede deshacer.',
            style: GoogleFonts.montserrat(fontSize: TamanoLetra.textoPequeno),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: ColoresApp.error),
              onPressed: () async {
                Navigator.of(context).pop();
                final mensaje = await FirebaseService.deleteMototaxi(placa);

                // feedback
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(mensaje),
                    backgroundColor:
                        mensaje.startsWith('Error')
                            ? ColoresApp.error
                            : ColoresApp.exito,
                  ),
                );
                if (!mensaje.startsWith('Error') && context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const BarraNavegacion(selectedIndex: 0),
                    ),
                    (_) => false,
                  );
                }
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}
