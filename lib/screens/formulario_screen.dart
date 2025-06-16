import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'nuevo_mototaxi.dart';
import 'nuevo_servicio.dart';

class FormularioScreen extends StatefulWidget {
  final int? initialTab;
  final String? mototaxiPlaca;

  const FormularioScreen({
    super.key,
    this.initialTab,
    this.mototaxiPlaca,
  });

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab ?? 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: ColoresApp.fondo,
        appBar: AppBar(
          title: Text(
            'Formulario',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: ColoresApp.textoOscuro,
              fontSize: TamanoLetra.tituloGrande,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight + 24),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE9E9E9),
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TabBar(
                  controller: _tabController,
                  labelColor: ColoresApp.primario,
                  unselectedLabelColor: ColoresApp.textoOscuro,
                  indicator: BoxDecoration(
                    color: ColoresApp.fondo,

                    borderRadius: BorderRadius.circular(30),
                  ),
                  dividerColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
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
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            const NuevoMototaxi(),
            NuevoServicio(mototaxiPlaca: widget.mototaxiPlaca),
          ],
        ),
      ),
    );
  }
    }