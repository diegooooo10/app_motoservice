import 'package:app_motoservice/screens/inicio.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:flutter/material.dart';

class BarraNavegacion extends StatefulWidget {
  const BarraNavegacion({super.key});

  @override
  State<BarraNavegacion> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<BarraNavegacion> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[Mototaxis(), Ejemplo()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColoresApp.fondo,
        elevation: 5,
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


class Ejemplo extends StatelessWidget {
  const Ejemplo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}