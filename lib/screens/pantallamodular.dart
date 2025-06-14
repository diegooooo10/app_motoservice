import 'package:app_motoservice/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> mostrarDialogoConfirmacion({
  required BuildContext context,
  required String titulo,
  required String mensaje,
  required String palabraClave,
  required VoidCallback onConfirmar,
}) async {
  final TextEditingController controller = TextEditingController();
  bool coincide = false;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              titulo,
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: TamanoLetra.textoNormal),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  mensaje,
                  style: GoogleFonts.inter(fontSize: TamanoLetra.textoPequeno),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,
                  onChanged: (value) {
                    setState(() => coincide = value.trim().toLowerCase() == palabraClave.toLowerCase());
                  },
                  decoration: InputDecoration(
                    hintText: 'Escribe "$palabraClave"',
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: coincide ? Colors.red : Colors.grey[300],
                  foregroundColor: coincide ? Colors.white : Colors.grey[600],
                ),
                onPressed: coincide ? () {
                  Navigator.of(context).pop();
                  onConfirmar();
                } : null,
                child: const Text("Eliminar"),
              ),
            ],
          );
        },
      );
    },
  );
}
