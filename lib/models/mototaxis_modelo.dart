final List<Map<String, dynamic>> users = [
  {
    "nombre": "Juan Carlos Ramírez",
    "placa": "MTX-789",
    "numero": "5551236789",
    "servicios": [
      {
        "fecha": "5 enero 2025",
        "servicio": "Cambio de batería",
        "detalles": "Se reemplazó la batería por una nueva de alta duración",
      },
      {
        "fecha": "12 febrero 2025",
        "servicio": "Ajuste de frenos",
        "detalles": "Se ajustaron y revisaron los frenos delanteros y traseros",
      },
      {
        "fecha": "20 marzo 2025",
        "servicio": "Cambio de aceite",
        "detalles": "Aceite de motor reemplazado por aceite sintético",
      },
      {
        "fecha": "15 abril 2025",
        "servicio": "Revisión de luces",
        "detalles": "Se revisaron todas las luces y se cambiaron dos focos",
      },
      {
        "fecha": "30 mayo 2025",
        "servicio": "Lavado completo",
        "detalles": "Lavado interior y exterior con encerado",
      },
    ],
  },
  {
    "nombre": "Luis Méndez",
    "placa": "MTX-457",
    "numero": "3216549870",
    "servicios": [],
  },
  {
    "nombre": "Carlos Jiménez",
    "placa": "MXT-889",
    "numero": "9876543210",
    "servicios": [
      {
        "fecha": "2 febrero 2025",
        "servicio": "Revisión general",
        "detalles": "Inspección de motor, luces y neumáticos",
      },
      {
        "fecha": "9 abril 2025",
        "servicio": "Cambio de batería",
        "detalles": "Se reemplazó la batería por una nueva de 12V",
      },
      {
        "fecha": "22 abril 2025",
        "servicio": "Alineación",
        "detalles": "Se alineó el eje frontal",
      },
      {
        "fecha": "10 mayo 2025",
        "servicio": "Cambio de bujías",
        "detalles": "Bujías reemplazadas para mejor rendimiento",
      },
    ],
  },
  {
    "nombre": "Mario Torres",
    "placa": "MTX-342",
    "numero": "4449873210",
    "servicios": [
      {
        "fecha": "8 marzo 2025",
        "servicio": "Cambio de aceite",
        "detalles": "Aceite convencional reemplazado",
      },
      {
        "fecha": "25 abril 2025",
        "servicio": "Revisión frenos",
        "detalles": "Pastillas y discos revisados",
      },
      {
        "fecha": "15 mayo 2025",
        "servicio": "Cambio de filtro de aire",
        "detalles": "Filtro reemplazado para mejorar la combustión",
      },
      {
        "fecha": "30 mayo 2025",
        "servicio": "Lavado y encerado",
        "detalles": "Lavado completo y encerado para proteger pintura",
      },
    ],
  },
];

class Servicio {
  final String fecha;
  final String servicio;
  final String detalles;

  Servicio({
    required this.fecha,
    required this.servicio,
    required this.detalles,
  });

  factory Servicio.fromMap(Map<String, dynamic> map) {
    return Servicio(
      fecha: map['fecha'],
      servicio: map['servicio'],
      detalles: map['detalles'],
    );
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

List<Mototaxi> mototaxis = users.map((u) => Mototaxi.fromMap(u)).toList();




// import 'package:cloud_firestore/cloud_firestore.dart';

// class Servicio {
//   final DateTime fecha;
//   final String servicio;
//   final String detalles;

//   Servicio({
//     required this.fecha,
//     required this.servicio,
//     required this.detalles,
//   });

//   factory Servicio.fromMap(Map<String, dynamic> map) {
//     return Servicio(
//       fecha: (map['fecha'] as Timestamp).toDate(),
//       servicio: map['servicio'],
//       detalles: map['detalles'],
//     );
//   }
//     Map<String, dynamic> toMap() {
//     return {'fecha': fecha, 'servicio': servicio, 'detalles': detalles};
//   }
// }

// class Mototaxi {
//   final String nombre;
//   final String placa;
//   final String numero;
//   final List<Servicio> servicios;

//   Mototaxi({
//     required this.nombre,
//     required this.placa,
//     required this.numero,
//     required this.servicios,
//   });

//   factory Mototaxi.fromMap(Map<String, dynamic> map) {
//     var serviciosFromMap = map['servicios'] as List<dynamic>;
//     List<Servicio> serviciosList =
//         serviciosFromMap.map((s) => Servicio.fromMap(s)).toList();

//     return Mototaxi(
//       nombre: map['nombre'],
//       placa: map['placa'],
//       numero: map['numero'],
//       servicios: serviciosList,
//     );
//   }
// }

