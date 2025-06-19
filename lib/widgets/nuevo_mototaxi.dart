import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_motoservice/theme/colors.dart';
import 'package:app_motoservice/theme/iconos.dart';
import 'package:app_motoservice/theme/typography.dart';
import 'package:app_motoservice/services/firebase_service.dart';

class NuevoMototaxi extends StatefulWidget {
  const NuevoMototaxi({super.key});

  @override
  State<NuevoMototaxi> createState() => _NuevoMototaxiState();
}

class _NuevoMototaxiState extends State<NuevoMototaxi> {
  final _formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode _autoValidate = AutovalidateMode.onUserInteraction;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColoresApp.fondo,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: _autoValidate,
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: _estiloInput(
                  'Número telefónico',
                  Icons.phone_outlined,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: 'El número es obligatorio',
                  ),
                  FormBuilderValidators.numeric(errorText: 'Solo números'),
                  FormBuilderValidators.equalLength(
                    10,
                    errorText: 'Debe tener 10 dígitos',
                  ),
                ]),
              ),
              const SizedBox(height: 12),
              FormBuilderTextField(
                name: 'placa',
                maxLength: 6,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                  UpperCaseTextFormatter(),
                ],
                decoration: _estiloInput('Placa', Icons.article_outlined),
                validator: (valueCandidate) {
                  final value = (valueCandidate ?? '').trim().toUpperCase();
                  if (value.isEmpty) return 'La placa es obligatoria';
                  if (value.length > 6) return 'Máximo 6 caracteres';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed:
                      _isSubmitting
                          ? null
                          : () async {
                            final messenger = ScaffoldMessenger.of(context);
                            if (!(_formKey.currentState?.saveAndValidate() ??
                                false)) {
                              return;
                            }
                            setState(() {
                              _isSubmitting = true;
                            });

                            final data = _formKey.currentState!.value;
                            final placa =
                                (data['placa'] as String).toUpperCase();

                            final mototaxiData = {
                              'nombre': data['nombre'].trim(),
                              'numero': data['numero'].trim(),
                              'placa': placa,
                              'servicios': <Map<String, dynamic>>[],
                            };

                            final respuesta = await FirebaseService.addMototaxi(
                              mototaxiData,
                              placa,
                            );

                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(respuesta),
                                backgroundColor:
                                    respuesta.startsWith('Error') ||
                                            respuesta.contains('existe')
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

                            if (!respuesta.startsWith('Error') &&
                                !respuesta.contains('existe')) {
                              _formKey.currentState?.reset();
                              setState(() {
                                _autoValidate = AutovalidateMode.disabled;
                              });
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
                            'Agregar mototaxi',
                            style: GoogleFonts.inter(
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
    );
  }
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

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
