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

  const DetalleMototaxiScreen({super.key, required this.mototaxi});

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

          if (!snapshot.hasData) {
            Future.microtask(() {
              if (context.mounted) {
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const BarraNavegacion(selectedIndex: 0),
                  ),
                  (_) => false,
                );
              }
            });

            return const SizedBox.shrink();
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
                            showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return AlertDialog(
                                  backgroundColor: ColoresApp.fondoTarjeta,
                                  title: Text(
                                    'Eliminar mototaxi',
                                    style: GoogleFonts.inter(
                                      fontSize: TamanoLetra.titulo,
                                    ),
                                  ),
                                  content: Text(
                                    '¿Estás seguro? Esta acción no se puede deshacer.',
                                    style: GoogleFonts.montserrat(
                                      fontSize: TamanoLetra.textoPequeno,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () =>
                                              Navigator.of(dialogContext).pop(),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: ColoresApp.error,
                                      ),
                                      onPressed: () async {
                                        Navigator.of(dialogContext).pop();
                                        final messenger = ScaffoldMessenger.of(
                                          context,
                                        );

                                        final String resultado =
                                            await FirebaseService.deleteMototaxi(
                                              mototaxi.placa,
                                            );
                                        messenger.showSnackBar(
                                          SnackBar(
                                            content: Text(resultado),
                                            backgroundColor:
                                                resultado.startsWith('Error') ||
                                                        resultado.contains(
                                                          'existe',
                                                        )
                                                    ? ColoresApp.error
                                                    : ColoresApp.exito,
                                            duration: Duration(seconds: 2),
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Eliminar'),
                                    ),
                                  ],
                                );
                              },
                            );
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
}
