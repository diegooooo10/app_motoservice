import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/models/mototaxis_modelo.dart';

void mostrarModalEditarServicio({
  required BuildContext context,
  required Servicio servicio,
  required void Function(Servicio nuevoServicio) onGuardar,
}) {
  final _formKey = GlobalKey<FormBuilderState>();

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

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: ColoresApp.fondoTarjeta,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Editar Servicio',
                    style: GoogleFonts.montserrat(
                      fontSize: TamanoLetra.subtitulo,
                      fontWeight: FontWeight.bold,
                      color: ColoresApp.textoOscuro,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderDropdown<String>(
                    name: 'servicio',
                    initialValue: servicio.servicio,
                    decoration: _estiloDropDown(Icons.build),
                    items: serviciosDisponibles
                        .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  FormBuilderDropdown<String>(
                    name: 'zona',
                    initialValue: servicio.detalles,
                    decoration: _estiloDropDown(Icons.location_on),
                    items: zonasDisponibles
                        .map((z) => DropdownMenuItem(value: z, child: Text(z)))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  FormBuilderTextField(
                    name: 'comentarios',
                    initialValue: '',
                    maxLines: 3,
                    decoration: _estiloInput('Comentarios', Icons.comment),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancelar'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.saveAndValidate()) {
                            final data = _formKey.currentState!.value;
                            final nuevoServicio = Servicio(
                              fecha: servicio.fecha,
                              servicio: data['servicio'],
                              detalles: data['zona'] +
                                  (data['comentarios']?.isNotEmpty == true
                                      ? ' - ${data['comentarios']}'
                                      : ''),
                            );
                            Navigator.pop(context);
                            onGuardar(nuevoServicio);
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Guardar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColoresApp.primario,
                          foregroundColor: ColoresApp.primarioClaro,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

InputDecoration _estiloInput(String label, IconData icono) {
  return InputDecoration(
    prefixIcon: Icon(icono, color: ColoresApp.primario, size: TamanoIcono.grande),
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

InputDecoration _estiloDropDown(IconData icono) {
  return InputDecoration(
    prefixIcon: Icon(icono, color: ColoresApp.primario, size: TamanoIcono.grande),
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
