import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/widgets/actualizar_servicio.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

class MototaxiDescripcion extends StatelessWidget {
  final Servicio servicio;
  final Mototaxi mototaxi;
  final int index;

  const MototaxiDescripcion({
    super.key,
    required this.servicio,
    required this.mototaxi,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // final DateFormat formato = DateFormat("d MMMM y 'a las' HH:mm", 'es_ES');
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: ColoresApp.primario, width: 5.0),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 3,
        color: ColoresApp.fondoTarjeta,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 14,
            bottom: 8,
            left: 20,
            right: 20,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.build_circle_outlined,
                        color: ColoresApp.primario,
                        size: TamanoIcono.mediano,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        servicio.servicio,
                        style: GoogleFonts.montserrat(
                          fontSize: TamanoLetra.textoNormal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'servicio.fecha',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: ColoresApp.textoMedio,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(servicio.detalles, style: GoogleFonts.inter(fontSize: 13)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: TamanoIcono.mediano,
                    color: ColoresApp.textoMedio,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Pendiente',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: ColoresApp.textoMedio,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 40,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: ColoresApp.fondo,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Editar Servicio',
                                        style: GoogleFonts.montserrat(
                                          fontSize: TamanoLetra.titulo,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  const SizedBox(height: 10),
                                  Flexible(
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: ActualizarServicio(
                                        mototaxi: mototaxi,
                                        comentario: servicio.detalles,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'Editar',
                      style: GoogleFonts.inter(color: ColoresApp.primario),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: ColoresApp.fondoTarjeta,
                            title: Text(
                              'Eliminar servicio',
                              style: GoogleFonts.inter(
                                fontSize: TamanoLetra.titulo,
                              ),
                            ),
                            content: Text(
                              '¿Estás seguro que quieres eliminar este servicio? Esta acción no se puede deshacer.',
                              style: GoogleFonts.montserrat(
                                fontSize: TamanoLetra.textoPequeno,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed:
                                    () => Navigator.of(context).pop(false),
                                child: Text(
                                  'Cancelar',
                                  style: GoogleFonts.montserrat(
                                    fontSize: TamanoLetra.textoPequeno,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Eliminado correctamente'),
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 3),
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );

                                  if (!context.mounted) return;

                                  Navigator.of(context).pop(true);
                                },

                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: Text(
                                  'Eliminar',
                                  style: GoogleFonts.montserrat(
                                    fontSize: TamanoLetra.textoPequeno,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
