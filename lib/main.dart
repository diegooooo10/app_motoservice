import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:app_motoservice/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motoservice',
      theme: ThemeData(useMaterial3: true),
      home: pruebaDeFuncionFirebase(),
    );
  }

  Scaffold pruebaDeFuncionFirebase() {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: getUser(),
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
                      fontSize: TamanoLetra.tituloMediano,
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
