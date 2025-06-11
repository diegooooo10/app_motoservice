import 'package:flutter/material.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:google_fonts/google_fonts.dart';
import 'nuevo_mototaxi.dart';
import 'nuevo_servicio.dart';

class FormularioScreen extends StatelessWidget {
  const FormularioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColoresApp.fondo,
        appBar: AppBar(
          backgroundColor: ColoresApp.fondo,
          elevation: 0,
          title: Text(
            'Formulario',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: TamanoLetra.tituloGrande,
              color: ColoresApp.textoOscuro,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: ColoresApp.fondo,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: ColoresApp.gris.withOpacity(0.10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: ColoresApp.primario,
                unselectedLabelColor: ColoresApp.textoMedio,
                labelStyle: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: TamanoLetra.textoNormal,
                ),
                tabs: const [
                  Tab(text: 'Nuevo mototaxi'),
                  Tab(text: 'Nuevo servicio'),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            NuevoMototaxi(),
            NuevoServicio(),
          ],
        ),
      ),
    );
  }
}
