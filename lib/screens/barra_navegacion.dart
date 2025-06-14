import 'package:app_motoservice/screens/inicio.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'formulario_screen.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:flutter/material.dart';

class BarraNavegacion extends StatefulWidget {
  final int selectedIndex;
  const BarraNavegacion({super.key, this.selectedIndex = 0});

  @override
  State<BarraNavegacion> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<BarraNavegacion> {
  int _selectedIndex = 0;
  Widget _getPage(int index) {
    if (index == 0) return Mototaxis();
    if (index == 1) return FormularioScreen();
    return SizedBox();
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
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
          });
        },
      ),
    );
  }
}
