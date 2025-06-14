import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_motoservice/models/historial_modelo.dart';
import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/theme/typography.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  final TextEditingController _controller = TextEditingController();
  List<HistorialModelo> historialCompleto = [];
  List<HistorialModelo> historialFiltrado = [];

  @override
  void initState() {
    super.initState();
    cargarHistorial();
  }

  void cargarHistorial() {
    final List<HistorialModelo> temp = [];
    for (var mototaxi in mototaxis) {
      for (var servicio in mototaxi.servicios) {
        temp.add(
          HistorialModelo(
            servicio: servicio,
            nombre: mototaxi.nombre,
            placa: mototaxi.placa,
          ),
        );
      }
    }
    setState(() {
      historialCompleto = temp;
      historialFiltrado = List.from(historialCompleto);
    });
  }

  void filtrarHistorial(String query) {
    final filtro =
        historialCompleto.where((item) {
          final texto = query.toLowerCase();
          return item.placa.toLowerCase().contains(texto) ||
              item.nombre.toLowerCase().contains(texto) ||
              item.servicio.servicio.toLowerCase().contains(texto);
        }).toList();

    setState(() {
      historialFiltrado = filtro;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoresApp.fondo,
      appBar: AppBar(
        backgroundColor: ColoresApp.fondo,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: ColoresApp.textoOscuro),
        title: Text(
          'Historial de servicios',
          style: GoogleFonts.inter(
            fontSize: TamanoLetra.tituloGrande,
            fontWeight: FontWeight.bold,
            color: ColoresApp.textoOscuro,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              onChanged: filtrarHistorial,
              decoration: InputDecoration(
                hintText: 'Buscar por placa, conductor o servicio',
                hintStyle: GoogleFonts.montserrat(
                  fontSize: TamanoLetra.textoPequeno,
                  color: ColoresApp.textoMedio,
                  fontStyle: FontStyle.italic,
                ),
                labelText: 'Buscar Servicio',
                labelStyle: GoogleFonts.montserrat(
                  fontSize: TamanoLetra.textoPequeno,
                  color: ColoresApp.primario,
                  fontStyle: FontStyle.italic,
                ),
                prefixIcon:  Icon(Icons.search, size: TamanoIcono.mediano),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ColoresApp.primario, width: 1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: ColoresApp.gris, width: 1),
                ),
              ),
            ),
          ),
          Expanded(
            child:
                historialFiltrado.isEmpty
                    ? const Center(child: Text('No hay resultados.'))
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: historialFiltrado.length,
                      itemBuilder: (context, index) {
                        final item = historialFiltrado[index];
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                      item.servicio.fecha,
                                      style: GoogleFonts.inter(
                                        fontSize: TamanoLetra.textoPequeno,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Spacer(),
                                    Icon(
                                      Icons.person,
                                      size: 18,
                                      color: ColoresApp.textoMedio,
                                    ),
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
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
