import 'package:app_motoservice/services/firebase_service.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PruebaFirebase extends StatefulWidget {
  const PruebaFirebase({super.key});

  @override
  State<PruebaFirebase> createState() => _PruebaFirebaseState();
}

class _PruebaFirebaseState extends State<PruebaFirebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: FirebaseService.getUser(),
          builder: ((context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final item = snapshot.data?[index]['Placa'] ?? '';
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Placa: ${item.toString()}',
                    style: GoogleFonts.montserrat(
                      fontSize: TamanoLetra.tituloGrande,
                      color: ColoresApp.textoOscuro,
                    ),
                  ),
                  subtitle: Text(
                    item.toString(),
                    style: GoogleFonts.inter(
                      fontSize: TamanoLetra.subtitulo,
                      color: ColoresApp.textoMedio,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {},
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
