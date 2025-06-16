import 'package:app_motoservice/screens/inicio.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'formulario_screen.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:flutter/material.dart';

class BarraNavegacion extends StatefulWidget {
  final int? selectedIndex;
  final int? formularioInitialTab;
  final String? mototaxiPlaca;

  const BarraNavegacion({
    super.key,
    this.selectedIndex,
    this.formularioInitialTab,
    this.mototaxiPlaca,
  });

  @override
  State<BarraNavegacion> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<BarraNavegacion> {
  late int _selectedIndex;
  late int _formularioInitialTab;
  late String? _mototaxiPlaca;

  Widget _getPage(int index) {
    if (index == 0) return Mototaxis();
    if (index == 1) {
      return FormularioScreen(
        initialTab: _formularioInitialTab,
        mototaxiPlaca: _mototaxiPlaca,
      );
    }
    return Mototaxis();
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex ?? 0;
    _mototaxiPlaca = widget.mototaxiPlaca ?? '';
    _formularioInitialTab = widget.formularioInitialTab ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            if (index == 1) {
              _mototaxiPlaca = null;
            }
          });
        },
      ),
    );
  }
}
