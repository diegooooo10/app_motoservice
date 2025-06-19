import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:app_motoservice/services/firebase_service.dart';

class NuevoServicio extends StatefulWidget {
  final String? mototaxiPlaca;
  const NuevoServicio({super.key, this.mototaxiPlaca});

  @override
  State<NuevoServicio> createState() => _NuevoServicioState();
}

class _NuevoServicioState extends State<NuevoServicio> {
  final _formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode _autoValidate = AutovalidateMode.onUserInteraction;
  bool _isSubmitting = false;

  final _servicios = const [
    'Mantenimiento',
    'Electrica',
    'Cambio de llantas',
    'Revisión y ajuste de frenos',
    'Cambio de aceite',
    'Lavado y estética',
    'Lubricación de cadena',
  ];

  final _zonas = const [
    'Selene',
    'Las Arboledas',
    'El triángulo',
    'San Francisco Tlaltenco',
    'Ojo de Agua',
    'San Miguel (Tláhuac)',
    'Quiahutla',
    'La Ciénega',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoresApp.fondo,
      body: SafeArea(
        child: StreamBuilder<List<Mototaxi>>(
          stream: FirebaseService.getMototaxisStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error al cargar mototaxis',
                  style: TextStyle(color: ColoresApp.error),
                ),
              );
            }

            final mototaxis = snapshot.data ?? [];
            final mototaxisByPlaca = {for (var m in mototaxis) m.placa: m};

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: FormBuilder(
                key: _formKey,
                autovalidateMode: _autoValidate,
                child: Column(
                  children: [
                    FormBuilderDropdown<String>(
                      name: 'placa',
                      hint: const Text('Elige un mototaxi'),
                      initialValue: widget.mototaxiPlaca,
                      decoration: _estiloInput('Placa', Icons.article_outlined),
                      validator: FormBuilderValidators.required(
                        errorText: 'La placa es obligatoria',
                      ),
                      isExpanded: true,
                      dropdownColor: ColoresApp.fondoTarjeta,
                      style: GoogleFonts.montserrat(
                        color: ColoresApp.textoOscuro,
                        fontSize: TamanoLetra.textoPequeno,
                        fontWeight: FontWeight.w500,
                      ),
                      items:
                          mototaxis
                              .map(
                                (m) => DropdownMenuItem<String>(
                                  value: m.placa,
                                  child: Text('${m.nombre}  •  ${m.placa}'),
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 12),
                    FormBuilderDropdown<String>(
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
                          _servicios
                              .map(
                                (serv) => DropdownMenuItem<String>(
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
                    FormBuilderDropdown<String>(
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
                          _zonas
                              .map(
                                (zona) => DropdownMenuItem<String>(
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
                        errorText: 'Máximo 150 caracteres',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed:
                            _isSubmitting
                                ? null
                                : () async {
                                  final messenger = ScaffoldMessenger.of(
                                    context,
                                  );
                                  if (!(_formKey.currentState
                                          ?.saveAndValidate() ??
                                      false)) {
                                    return;
                                  }

                                  setState(() {
                                    _isSubmitting = true;
                                  });
                                  final data = _formKey.currentState!.value;
                                  final placa = data['placa'];
                                  final mototaxiSel = mototaxisByPlaca[placa];

                                  if (mototaxiSel == null) {
                                    messenger.showSnackBar(
                                      SnackBar(
                                        content: Text('Mototaxi no encontrada'),
                                        backgroundColor: ColoresApp.error,
                                        duration: Duration(seconds: 2),
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    );
                                    setState(() => _isSubmitting = false);
                                    return;
                                  }
                                  final nuevoServicio = Servicio(
                                    fecha: DateTime.now().toUtc(),
                                    servicio: data['servicio'],
                                    detalles:
                                        (data['comentarios'] ?? '').trim(),
                                    zona: data['zona'],
                                  );

                                  final respuesta =
                                      await FirebaseService.addService(
                                        nuevoServicio,
                                        placa,
                                        mototaxiSel.nombre,
                                      );

                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(respuesta),
                                      backgroundColor:
                                          respuesta.startsWith('Error')
                                              ? ColoresApp.error
                                              : ColoresApp.exito,
                                      duration: Duration(seconds: 2),
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.all(16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                  if (!respuesta.startsWith('Error')) {
                                    _formKey.currentState?.reset();
                                    setState(() {
                                      _autoValidate = AutovalidateMode.disabled;
                                    });

                                    if (widget.mototaxiPlaca != null) {
                                      _formKey.currentState?.fields['placa']
                                          ?.didChange(widget.mototaxiPlaca);
                                    }
                                  } else {
                                    setState(() {
                                      _autoValidate =
                                          AutovalidateMode.onUserInteraction;
                                    });
                                  }

                                  setState(() {
                                    _isSubmitting = false;
                                  });
                                },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColoresApp.primario,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 3,
                        ),
                        child:
                            _isSubmitting
                                ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: ColoresApp.fondo,
                                    strokeWidth: 2,
                                  ),
                                )
                                : Text(
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
            );
          },
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
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
