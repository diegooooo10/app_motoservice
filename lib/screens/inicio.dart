// import 'package:app_motoservice/services/firebase_service.dart';
import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:app_motoservice/services/firebase_service.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mototaxis extends StatefulWidget {
  const Mototaxis({super.key});

  @override
  State<Mototaxis> createState() => _MototaxisState();
}

class _MototaxisState extends State<Mototaxis> {
  List<Mototaxi> allData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final data = allData = await FirebaseService.getMockData();

      setState(() {
        setState(() {
          allData = data;
        });
      });
    } catch (e) {
      debugPrint('Error cargando datos: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mototaxis',
          style: GoogleFonts.inter(
            fontSize: TamanoLetra.tituloGrande,
            fontWeight: FontWeight.bold,
            color: ColoresApp.textoOscuro,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : allData.isEmpty
                    ? const Center(child: Text('No se encontraron resultados'))
                    : ListView.builder(
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        final item = allData[index];
                        return ListTile(
                          leading: Icon(Icons.person),
                          title: Text(
                            'Placa: ${item.placa}',
                            style: GoogleFonts.montserrat(
                              fontSize: TamanoLetra.tituloGrande,
                              color: ColoresApp.textoOscuro,
                            ),
                          ),
                          subtitle: Text(
                            item.nombre,
                            style: GoogleFonts.inter(
                              fontSize: TamanoLetra.subtitulo,
                              color: ColoresApp.textoMedio,
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {},
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
