// import 'package:app_motoservice/services/firebase_service.dart';
import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:app_motoservice/screens/historial.dart';
import 'package:app_motoservice/services/firebase_service.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:app_motoservice/widgets/mototaxi_tarjeta_inicio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mototaxis extends StatefulWidget {
  const Mototaxis({super.key});

  @override
  State<Mototaxis> createState() => _MototaxisState();
}

class _MototaxisState extends State<Mototaxis> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {});
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
        title: Text(
          'Mototaxis',
          style: GoogleFonts.inter(
            fontSize: TamanoLetra.tituloGrande,
            fontWeight: FontWeight.bold,
            color: ColoresApp.textoOscuro,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistorialPage()),
              );
            },
            icon: SizedBox(
              width: TamanoIcono.grande + 12,
              height: TamanoIcono.grande + 12,

              child: Container(
                decoration: BoxDecoration(
                  color: ColoresApp.fondoTarjeta,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      offset: Offset(0, 4),
                      blurRadius: 12,
                      spreadRadius: 1,
                    ),
                  ],
                ),

                child: Icon(
                  Icons.history,
                  color: ColoresApp.primario,
                  size: TamanoIcono.grande,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              style: GoogleFonts.montserrat(
                fontSize: TamanoLetra.textoPequeno,
                color: ColoresApp.textoOscuro,
              ),
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Buscar mototaxi por placa o conductor',
                hintStyle: GoogleFonts.montserrat(
                  fontSize: TamanoLetra.textoPequeno,
                  color: ColoresApp.textoMedio,
                  fontStyle: FontStyle.italic,
                ),
                labelText: 'Buscar Mototaxi',
                labelStyle: GoogleFonts.montserrat(
                  fontSize: TamanoLetra.textoPequeno,
                  color: ColoresApp.primario,
                  fontStyle: FontStyle.italic,
                ), 
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
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
          SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<List<Mototaxi>>(
              stream: FirebaseService.getMototaxisStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('No se encontraron resultados'),
                  );
                }

                final datosFiltrados =
                    snapshot.data!.where((item) {
                      final q = _controller.text.toLowerCase();
                      return item.placa.toLowerCase().contains(q) ||
                          item.nombre.toLowerCase().contains(q);
                    }).toList();
                if (datosFiltrados.isEmpty) {
                  return const Center(
                    child: Text('No se encontraron resultados'),
                  );
                }
                return ListView.builder(
                  itemCount: datosFiltrados.length,
                  itemBuilder: (context, index) {
                    final mototaxi = datosFiltrados[index];
                    return MototaxiTarjetaInicio(mototaxi: mototaxi);
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
