import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
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
          elevation: 1,
          title: Text(
            'Formulario',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: TamanoLetra.tituloGrande,
              color: ColoresApp.textoOscuro,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE9ECEF),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: ColoresApp.fondoTarjeta,
                  borderRadius: BorderRadius.circular(25.r),
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
                labelStyle: TextStyle(
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
