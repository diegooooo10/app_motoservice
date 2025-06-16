import 'package:cloud_firestore/cloud_firestore.dart';

class Servicio {
  final DateTime fecha;
  final String servicio;
  final String detalles;
  final String zona;

  Servicio({
    required this.fecha,
    required this.servicio,
    required this.detalles,
    required this.zona
  });

  factory Servicio.fromMap(Map<String, dynamic> map) {
    return Servicio(
      fecha: (map['fecha'] as Timestamp).toDate(),
      zona: map['zona'],
      servicio: map['servicio'],
      detalles: map['detalles'],
    );
  }
    Map<String, dynamic> toMap() {
    return {'fecha': fecha, 'servicio': servicio, 'detalles': detalles, 'zona': zona};
  }
}

class Mototaxi {
  final String nombre;
  final String placa;
  final String numero;
  final List<Servicio> servicios;

  Mototaxi({
    required this.nombre,
    required this.placa,
    required this.numero,
    required this.servicios,
  });

  factory Mototaxi.fromMap(Map<String, dynamic> map) {
    var serviciosFromMap = map['servicios'] as List<dynamic>;
    List<Servicio> serviciosList =
        serviciosFromMap.map((s) => Servicio.fromMap(s)).toList();

    return Mototaxi(
      nombre: map['nombre'],
      placa: map['placa'],
      numero: map['numero'],
      servicios: serviciosList,
    );
  }
}
