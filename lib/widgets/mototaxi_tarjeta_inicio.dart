import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MototaxiTarjetaInicio extends StatelessWidget {
  final Mototaxi mototaxi;
  const MototaxiTarjetaInicio({super.key, required this.mototaxi});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColoresApp.fondoTarjeta,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EjemploDescripcion()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.tag, size: TamanoIcono.mediano),
                      SizedBox(width: 4),
                      Text(
                        mototaxi.placa,
                        style: GoogleFonts.inter(
                          color: ColoresApp.textoOscuro,
                          fontSize: TamanoLetra.textoNormal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: ColoresApp.primarioClaro,
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Text(
                      '${mototaxi.servicios.length} servicios',
                      style: GoogleFonts.montserrat(
                        color: ColoresApp.primario,
                        fontWeight: FontWeight.w500,
                        fontSize: TamanoLetra.textoPequeno,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: TamanoIcono.pequeno),
                      SizedBox(width: 4),
                      Text(
                        mototaxi.nombre,
                        style: GoogleFonts.montserrat(
                          color: ColoresApp.textoMedio,
                          fontSize: TamanoLetra.textoPequeno,
                        ),
                      ),
                    ],
                  ),

                  Icon(Icons.arrow_forward_ios, size: TamanoIcono.pequeno),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EjemploDescripcion extends StatelessWidget {
  const EjemploDescripcion({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
