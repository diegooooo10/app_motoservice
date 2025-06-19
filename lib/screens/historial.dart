import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:app_motoservice/models/historial_modelo.dart';
import 'package:app_motoservice/services/firebase_service.dart';
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
  String _busqueda = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _busqueda = _controller.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                prefixIcon: Icon(Icons.search, size: TamanoIcono.mediano),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
            child: StreamBuilder<List<HistorialModelo>>(
              stream: FirebaseService.getServices(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay historial registrado.'));
                }

                final datos = snapshot.data!;
                final filtrados = datos.where((item) {
                  return item.placa.toLowerCase().contains(_busqueda) ||
                      item.nombre.toLowerCase().contains(_busqueda) ||
                      item.servicio.servicio.toLowerCase().contains(_busqueda);
                }).toList();

                if (filtrados.isEmpty) {
                  return const Center(child: Text('No hay resultados.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: filtrados.length,
                  itemBuilder: (context, index) {
                    final item = filtrados[index];
                    final formato = DateFormat("d 'de' MMMM 'de' y 'a las' HH:mm", 'es_ES');
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
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                                  formato.format(item.servicio.fecha),
                                  style: GoogleFonts.montserrat(
                                    fontSize: TamanoLetra.textoPequeno,
                                    color: ColoresApp.textoMedio,
                                    fontWeight: FontWeight.w500,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
