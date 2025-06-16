import 'package:app_motoservice/screens/inicio.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'formulario_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:flutter/material.dart';

class BarraNavegacion extends StatefulWidget {
  final int selectedIndex;
  final int? formularioInitialTab;
  final String? mototaxiPlaca;

  const BarraNavegacion({
    super.key, 
    this.selectedIndex = 0,
    this.formularioInitialTab,
    this.mototaxiPlaca,
  });

  @override
  State<BarraNavegacion> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<BarraNavegacion> {
  int _selectedIndex = 0;
  int? _formularioInitialTab;
  String? _mototaxiPlaca;

  String _getAppBarTitle(int index) {
    if (index == 0) return 'Inicio';
    if (index == 1) return 'Formulario';
    return 'MotoService';
  }

  Widget _getPage(int index) {
    if (index == 0) return Mototaxis();
    if (index == 1) return FormularioScreen( initialTab: _formularioInitialTab ?? 0, mototaxiPlaca: _mototaxiPlaca,);
    return SizedBox();
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _formularioInitialTab = widget.formularioInitialTab;
    _mototaxiPlaca = widget.mototaxiPlaca;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(_selectedIndex),
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: ColoresApp.textoOscuro,
            fontSize: TamanoLetra.tituloGrande,
          ),
        ),
      ),
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColoresApp.fondo,
        elevation: 4,
        currentIndex: _selectedIndex,
        selectedItemColor: ColoresApp.primario,
        unselectedItemColor: ColoresApp.gris,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: TamanoIcono.mediano),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt, size: TamanoIcono.mediano),
            label: 'Formulario',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            if (index != 1) {
              _formularioInitialTab = null;
              _mototaxiPlaca = null;
            }
          });
        },
      ),
    );
  }
}