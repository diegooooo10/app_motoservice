import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:google_fonts/google_fonts.dart';

class NuevoMototaxi extends StatelessWidget {
  const NuevoMototaxi({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Scaffold(
      backgroundColor: ColoresApp.fondo,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'nombre',
                  decoration: _estiloInput('Nombre', Icons.person_outline),
                  validator: FormBuilderValidators.required(
                    errorText: 'El nombre es obligatorio',
                  ),
                ),
                const SizedBox(height: 12),
                FormBuilderTextField(
                  name: 'numero',
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: _estiloInput('Número (10 dígitos)', Icons.phone_outlined),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'El número es obligatorio'),
                    FormBuilderValidators.numeric(errorText: 'Solo números'),
                    FormBuilderValidators.equalLength(10, errorText: 'Debe tener 10 dígitos'),
                  ]),
                ),
                const SizedBox(height: 12),
                FormBuilderTextField(
                  name: 'placa',
                  maxLength: 6,
                  decoration: _estiloInput('Placa (6 caracteres)', Icons.article_outlined),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(errorText: 'La placa es obligatoria'),
                    FormBuilderValidators.maxLength(6, errorText: 'Máximo 6 caracteres'),
                  ]),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final data = formKey.currentState!.value;
                        print('Datos del mototaxi: $data');
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
                      'Dar de alta',
                      style: TextStyle(fontSize: TamanoLetra.textoNormal, color: ColoresApp.fondo),
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
    prefixIcon: Icon(icono, color: ColoresApp.primario, size: TamanoIcono.grande),
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
}
