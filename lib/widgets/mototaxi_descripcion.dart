import 'package:app_motoservice/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:app_motoservice/widgets/actualizar_servicio.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/theme/typography.dart';

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
    // Formato de fecha en español
    final DateFormat formato = DateFormat("d MMMM y 'a las' HH:mm", 'es_ES');

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- fila servicio + fecha ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.build_circle_outlined,
                          color: ColoresApp.primario,
                          size: TamanoIcono.mediano,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Tooltip(
                            message: servicio.servicio,
                            child: Text(
                              servicio.servicio,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: GoogleFonts.montserrat(
                                fontSize: TamanoLetra.textoNormal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    formato.format(servicio.fecha),
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: ColoresApp.textoMedio,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              // ---------- detalles ----------
              Text(servicio.detalles, style: GoogleFonts.inter(fontSize: 13)),
              const SizedBox(height: 8),
              // ---------- zona + botones ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: TamanoIcono.mediano,
                          color: ColoresApp.textoMedio,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Tooltip(
                            message: servicio.zona,
                            child: Text(
                              servicio.zona,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: false,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: ColoresApp.textoMedio,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          _mostrarEditar(context);
                        },
                        child: Text(
                          'Editar',
                          style: GoogleFonts.inter(color: ColoresApp.primario),
                        ),
                      ),
                      // ------------ botón eliminar ------------
                      TextButton(
                        onPressed: () => _confirmarEliminar(context),
                        style: TextButton.styleFrom(
                          foregroundColor: ColoresApp.error,
                        ),
                        child: const Text('Eliminar'),
                      ),
                    ],
                  ),

                  // ------------ botón editar ------------
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- diálogos auxiliares -----------------
  void _mostrarEditar(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 40,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: ColoresApp.fondo,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
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
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 10),
                  Flexible(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ActualizarServicio(
                        mototaxi: mototaxi,
                        comentario: servicio.detalles,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _confirmarEliminar(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            backgroundColor: ColoresApp.fondoTarjeta,
            title: Text(
              'Eliminar servicio',
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
                  final messenger = ScaffoldMessenger.of(context);
                  Navigator.of(context).pop();
                  final resultado = await _eliminarServicio(context);
                  if (resultado) {
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Servicio eliminado correctamente'),
                        backgroundColor: ColoresApp.exito,
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Eliminar'),
              ),
            ],
          ),
    );
  }

  Future<bool> _eliminarServicio(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      final resultado = await ServicioFirebase.deleteService(
        servicio.detalles,
        mototaxi.placa,
      );

      if (resultado.contains('correctamente')) {
        return true;
      } else {
        messenger.showSnackBar(
          SnackBar(
            content: Text(resultado),
            backgroundColor: ColoresApp.error,
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        return false;
      }
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Error al eliminar: ${e.toString()}'),
          backgroundColor: ColoresApp.error,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return false;
    }
  }
}
