import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/models/mototaxis_modelo.dart';

class ActualizarServicio extends StatefulWidget {
  final Mototaxi mototaxi;
  final String comentario;
  const ActualizarServicio({
    super.key,
    required this.mototaxi,
    required this.comentario,
  });

  @override
  State<ActualizarServicio> createState() => _ActualizarServicioState();
}

class _ActualizarServicioState extends State<ActualizarServicio> {
  AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction;

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final List<String> serviciosDisponibles = [
      'Mantenimiento',
      'Electrica',
      'Cambio de llantas',
      'Revisión y ajuste de frenos',
      'Cambio de aceite',
      'Lavado y estética',
      'Lubricación de cadena',
    ];

    final List<String> zonasDisponibles = [
      'Selene',
      'Las Arboledas',
      'El triángulo',
      'San Francisco Tlaltenco',
      'Ojo de Agua',
      'San Miguel (Tláhuac)',
      'Quiahutla',
      'La Ciénega',
    ];

    return Padding(
      padding: const EdgeInsets.all(20),

      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FormBuilder(
          autovalidateMode: autoValidateMode,

          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilderDropdown<String>(
                name: 'servicio',
                hint: Text('Tipo de servicio'),

                decoration: _estiloDropDown(Icons.build, 'Servicio'),
                items:
                    serviciosDisponibles
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                validator: FormBuilderValidators.required(
                  errorText: 'Seleccione un servicio',
                ),
              ),
              const SizedBox(height: 12),
              FormBuilderDropdown<String>(
                name: 'zona',
                hint: Text('Zona de servicio'),
                decoration: _estiloDropDown(Icons.location_on, 'Zona'),
                items:
                    zonasDisponibles
                        .map((z) => DropdownMenuItem(value: z, child: Text(z)))
                        .toList(),
                validator: FormBuilderValidators.required(
                  errorText: 'Seleccione una zona',
                ),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'comentarios',
                initialValue: '',
                maxLines: 3,
                maxLength: 150,
                decoration: _estiloInput('Comentarios ', Icons.comment),
                validator: FormBuilderValidators.required(
                  errorText: 'El comentario es obligatorio',
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: ColoresApp.textoOscuro),
                      foregroundColor: ColoresApp.textoOscuro,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('Cancelar'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (formKey.currentState!.saveAndValidate()) {
                        final data = formKey.currentState!.value;
                        // ignore: unused_local_variable
                        final nuevoServicio = Servicio(
                          fecha: DateTime.now().toUtc().toIso8601String(),
                          servicio: data['servicio'],
                          detalles:
                              data['zona'] +
                              (data['comentarios']?.isNotEmpty == true
                                  ? ' - ${data['comentarios']}'
                                  : ''),
                        );
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColoresApp.primario,
                      foregroundColor: ColoresApp.fondo,
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

InputDecoration _estiloInput(String label, IconData icono) {
  return InputDecoration(
    prefixIcon: Icon(
      icono,
      color: ColoresApp.primario,
      size: TamanoIcono.mediano,
    ),
    labelText: label,
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
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
  );
}

InputDecoration _estiloDropDown(IconData icono, String label) {
  return InputDecoration(
    prefixIcon: Icon(
      icono,
      color: ColoresApp.primario,
      size: TamanoIcono.mediano,
    ),
    label: Text(label),
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
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
}
