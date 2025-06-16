import 'package:app_motoservice/models/mototaxis_modelo.dart';

class HistorialModelo {
  final Servicio servicio;
  final String nombre;
  final String placa;

  HistorialModelo({
    required this.servicio,
    required this.nombre,
    required this.placa,
  });
factory HistorialModelo.fromMap(Map<String, dynamic> map) {
    return HistorialModelo(
      servicio: Servicio.fromMap(map),
      nombre: map['nombre'],
      placa: map['mototaxi'],
    );
  }
}
