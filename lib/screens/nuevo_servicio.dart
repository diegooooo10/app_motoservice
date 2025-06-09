import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class NuevoServicio extends StatelessWidget {
  const NuevoServicio({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final String hora = DateFormat.Hm().format(DateTime.now().toLocal());

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
            key: formKey,
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'placa',
                  decoration: _estiloInput('Placa', Icons.article_outlined),
                  validator: FormBuilderValidators.required(
                    errorText: 'La placa es obligatoria',
                  ),
                ),
                const SizedBox(height: 12),
                FormBuilderDropdown(
                  name: 'servicio',
                  decoration: _estiloInput('', Icons.build_outlined),
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
                  decoration: _estiloInput('', Icons.location_on_outlined),
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
                  validator: FormBuilderValidators.compose([FormBuilderValidators.maxLength(150,
                  errorText: "Máximo 150 caracteres")]),
                  maxLines: null,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.saveAndValidate() ?? false) {
                        final data = formKey.currentState!.value;
                        final servicioConHora = {...data, 'hora': hora};
                        print(servicioConHora);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColoresApp.primario,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 14.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      'Agregar servicio',
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
      icon: Icon(icono, color: ColoresApp.primario, size: TamanoIcono.grande),
      labelText: label.isNotEmpty ? label : null,
      labelStyle: TextStyle(
        fontSize: TamanoLetra.textoNormal,
        color: ColoresApp.textoMedio,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(
          color: ColoresApp.gris, 
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(
          color: ColoresApp.primario,
          width: 1.4,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
    );
  }
}
