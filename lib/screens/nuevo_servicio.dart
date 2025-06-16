import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class NuevoServicio extends StatelessWidget {
  final String? mototaxiPlaca;
  const NuevoServicio({super.key, this.mototaxiPlaca});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;

    final servicios = [
      'Mantenimiento',
      'Electrica',
      'Cambio de llantas',
      'Revisión y ajuste de frenos',
      'Cambio de aceite',
      'Lavado y estética',
      'Lubricación de cadena',
    ];

    final zonas = [
      'Selene',
      'Las Arboledas',
      'El triángulo',
      'San Francisco Tlaltenco',
      'Ojo de Agua',
      'San Miguel (Tláhuac)',
      'Quiahutla',
      'La Ciénega',
    ];

    return Scaffold(
      backgroundColor: ColoresApp.fondo,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
            autovalidateMode: autoValidateMode,
            key: formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'placa',
                  initialValue: mototaxiPlaca,
                  readOnly: mototaxiPlaca != null,
                  maxLength: 6,
                  decoration: _estiloInput('Placa', Icons.article_outlined),
                  validator: FormBuilderValidators.required(
                    errorText: 'La placa es obligatoria',
                  ),
                ),
                const SizedBox(height: 12),
                FormBuilderDropdown(
                  name: 'servicio',
                  decoration: _estiloDropDown(Icons.build_outlined),
                  dropdownColor: ColoresApp.fondoTarjeta,
                  isExpanded: true,
                  hint: Text(
                    'Servicio',
                    style: TextStyle(
                      fontSize: TamanoLetra.textoNormal,
                      color: ColoresApp.textoMedio,
                    ),
                  ),
                  items:
                      servicios
                          .map(
                            (serv) => DropdownMenuItem(
                              value: serv,
                              child: Text(serv),
                            ),
                          )
                          .toList(),
                  validator: FormBuilderValidators.required(
                    errorText: 'Selecciona un servicio',
                  ),
                ),
                const SizedBox(height: 12),
                FormBuilderDropdown(
                  name: 'zona',
                  decoration: _estiloDropDown(Icons.location_on_outlined),
                  dropdownColor: ColoresApp.fondoTarjeta,
                  isExpanded: true,
                  hint: Text(
                    'Zona',
                    style: TextStyle(
                      fontSize: TamanoLetra.textoNormal,
                      color: ColoresApp.textoMedio,
                    ),
                  ),
                  items:
                      zonas
                          .map(
                            (zona) => DropdownMenuItem(
                              value: zona,
                              child: Text(zona),
                            ),
                          )
                          .toList(),
                  validator: FormBuilderValidators.required(
                    errorText: 'Selecciona una zona',
                  ),
                ),
                const SizedBox(height: 12),
                FormBuilderTextField(
                  name: 'comentarios',
                  maxLength: 150,
                  decoration: _estiloInput(
                    'Comentarios',
                    Icons.comment_outlined,
                  ),
                  validator: FormBuilderValidators.maxLength(
                    150,
                    errorText: "Máximo 150 caracteres",
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final data = formKey.currentState!.value;
                        // ignore: unused_local_variable
                        final placa = data['placa'];

                        // final existe = await _placaRegistrada(placa);

                        // if (!existe) {
                        //   messenger.showSnackBar(
                        //     const SnackBar(
                        //       content: Text('La placa no está registrada.'),
                        //       backgroundColor: Colors.red,
                        //     ),
                        //   );
                        //   return;
                        // }

                        // ignore: unused_local_variable
                        final servicioConHora = {
                          ...data,
                          'fecha': DateTime.now().toUtc(),
                        };
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('Servicio guardado correctamente.'),
                            backgroundColor: ColoresApp.exito,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColoresApp.primario,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      'Agregar servicio',
                      style: TextStyle(
                        fontSize: TamanoLetra.textoNormal,
                        color: ColoresApp.fondo,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _estiloInput(String label, IconData icono) {
    return InputDecoration(
      prefixIcon: Icon(
        icono,
        color: ColoresApp.primario,
        size: TamanoIcono.grande,
      ),
      labelText: label.isNotEmpty ? label : null,
      labelStyle: GoogleFonts.inter(
        fontSize: TamanoLetra.textoNormal,
        color: ColoresApp.textoMedio,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColoresApp.gris, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColoresApp.primario, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColoresApp.error, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColoresApp.error, width: 1.4),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    );
  }

  InputDecoration _estiloDropDown(IconData icono) {
    return InputDecoration(
      prefixIcon: Icon(
        icono,
        color: ColoresApp.primario,
        size: TamanoIcono.grande,
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: TamanoLetra.textoNormal,
        color: ColoresApp.textoMedio,
      ),
      filled: true,
      fillColor: ColoresApp.fondoTarjeta,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColoresApp.gris, width: 1.2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColoresApp.error, width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColoresApp.primario, width: 1.4),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColoresApp.gris, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: ColoresApp.error, width: 1.4),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}

class FirestoreService {
  Future<bool> _placaRegistrada(String placa) async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('mototaxis')
            .where('placa', isEqualTo: placa)
            .limit(1)
            .get();

    return snapshot.docs.isNotEmpty;
  }
}
