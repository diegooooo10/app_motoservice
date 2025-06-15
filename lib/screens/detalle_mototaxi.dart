import 'package:app_motoservice/screens/barra_navegacion.dart';
import 'package:app_motoservice/screens/pantallamodular.dart';
import 'package:app_motoservice/screens/pantallamodularservicio.dart';
import 'package:flutter/material.dart';
import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalleMototaxiScreen extends StatelessWidget {
  final Mototaxi mototaxi;

  const DetalleMototaxiScreen({super.key, required this.mototaxi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoresApp.fondoTarjeta,
      appBar: AppBar(
        title: Text(
          'Detalles',
          style: GoogleFonts.montserrat(
            fontSize: TamanoLetra.titulo,
            fontWeight: FontWeight.w600,
            color: ColoresApp.textoOscuro,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: ColoresApp.textoOscuro,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.directions_bike, color: Colors.blue),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mototaxi.placa,
                              style: GoogleFonts.montserrat(
                                fontSize: TamanoLetra.titulo,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              mototaxi.nombre,
                              style: GoogleFonts.inter(
                                fontSize: TamanoLetra.textoNormal,
                                color: ColoresApp.textoMedio,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        mostrarDialogoConfirmacion(
                          context: context,
                          titulo:
                              "¿Estas seguro de que deseas eliminar el mototaxi?",
                          mensaje:
                              "Escribe 'eliminar' para confirmar la eliminacion",
                          palabraClave: "eliminar",
                          onConfirmar: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Mototaxi eliminado"),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete, color: ColoresApp.error),
                      tooltip: 'Eliminar Mototaxi',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Servicios',
                  style: GoogleFonts.montserrat(
                    fontSize: TamanoLetra.titulo,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BarraNavegacion(selectedIndex: 1),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.add, color: ColoresApp.azulClaro),
                  label: Text(
                    'Agregar servicio',
                    style: GoogleFonts.montserrat(
                      color: ColoresApp.azulClaro,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: mototaxi.servicios.isEmpty
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
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          elevation: 2,
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: 5,
                                  decoration: BoxDecoration(
                                    color: ColoresApp.azulClaro,
                                    borderRadius : BorderRadius.circular(12),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                _getServiceIcon(
                                                    servicio.servicio),
                                                const SizedBox(width: 8),
                                                Text(
                                                  servicio.servicio,
                                                  style:
                                                      GoogleFonts.montserrat(
                                                    fontSize: TamanoLetra
                                                        .textoNormal,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              servicio.fecha,
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: ColoresApp.textoMedio,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          servicio.detalles,
                                          style: GoogleFonts.inter(
                                              fontSize: 13),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.hourglass_bottom,
                                              size: 16,
                                              color: ColoresApp.gris,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Pendiente',
                                              style: GoogleFonts.inter(
                                                fontSize: 12,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                mostrarModalEditarServicio(
                                                  context: context,
                                                  servicio: mototaxi
                                                      .servicios[index],
                                                  onGuardar: (nuevoServicio) {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          "Servicio editado",
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              style: TextButton.styleFrom(
                                                foregroundColor:
                                                    ColoresApp.azulClaro,
                                              ),
                                              child: const Text('Editar'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                mostrarDialogoConfirmacion(
                                                  context: context,
                                                  titulo:
                                                      "¿Estas seguro que deseas eliminar este servicio?",
                                                  mensaje:
                                                      'Escribe "eliminar" para confirmar la eliminacion',
                                                  palabraClave: 'eliminar',
                                                  onConfirmar: () {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          "Servicio eliminado",
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.red,
                                              ),
                                              child: const Text('Eliminar'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getServiceIcon(String tipo) {
    switch (tipo.toLowerCase()) {
      default:
        return const Icon(
          Icons.build_circle_outlined,
          color: ColoresApp.primario,
        );
    }
  }
}
