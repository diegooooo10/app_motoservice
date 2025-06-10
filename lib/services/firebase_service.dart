// import 'package:app_motoservice/models/historial_modelo.dart';
import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final String uid = FirebaseAuth.instance.currentUser!.uid;

class FirebaseService {

  static Future<List<Mototaxi>> getMockData() async {
    await Future.delayed(Duration(milliseconds: 500));
    return users.map((u) => Mototaxi.fromMap(u)).toList();
  }
  
  // static Stream<List<Mototaxi>> getMototaxisStream() {
  //   final CollectionReference userMototaxisCollection = db
  //       .collection('usuarios')
  //       .doc(uid)
  //       .collection('mototaxis');

  //   return userMototaxisCollection.snapshots().map((querySnapshot) {
  //     return querySnapshot.docs.map((doc) {
  //       return Mototaxi.fromMap(doc.data() as Map<String, dynamic>);
  //     }).toList();
  //   });
  // }

  // static Stream<Mototaxi> streamMototaxi(String placa) {
  //   return db
  //       .collection('usuarios')
  //       .doc(uid)
  //       .collection('mototaxis')
  //       .doc(placa)
  //       .snapshots()
  //       .map(
  //         (docSnapshot) =>
  //             Mototaxi.fromMap(docSnapshot.data() as Map<String, dynamic>),
  //       );
  // }

  // static Stream<List<HistorialModelo>> getServices() {
  //   final Query userServicesQuery = db
  //       .collection('usuarios')
  //       .doc(uid)
  //       .collection('servicios')
  //       .orderBy('fecha');

  //   return userServicesQuery.snapshots().map((querySnapshot) {
  //     return querySnapshot.docs.map((doc) {
  //       return HistorialModelo.fromMap(doc.data() as Map<String, dynamic>);
  //     }).toList();
  //   });
  // }

  // static Future<String> addMototaxi(
  //   Map<String, dynamic> mototaxiData,
  //   String placa,
  // ) async {
  //   try {
  //     final docRef = db
  //         .collection('usuarios')
  //         .doc(uid)
  //         .collection('mototaxis')
  //         .doc(placa);

  //     final docSnapshot = await docRef.get();

  //     if (docSnapshot.exists) {
  //       return "Mototaxi con placa '$placa' ya existe";
  //     } else {
  //       await docRef.set(mototaxiData);
  //       return "Mototaxi agregado exitosamente";
  //     }
  //   } catch (e) {
  //     return "Error al agregar mototaxi";
  //   }
  // }

  // static Future<String> addService(
  //   Servicio servicio,
  //   String placa,
  //   String nombre,
  // ) async {
  //   try {
  //     final servicioMap = servicio.toMap();
  //     servicioMap['mototaxi'] = placa;
  //     servicioMap['nombre'] = nombre;

  //     await db
  //         .collection('usuarios')
  //         .doc(uid)
  //         .collection('mototaxis')
  //         .doc(placa)
  //         .update({
  //           'servicios': FieldValue.arrayUnion([servicio.toMap()]),
  //         });

  //     await db
  //         .collection('usuarios')
  //         .doc(uid)
  //         .collection('servicios')
  //         .add(servicioMap);

  //     return 'Servicio agregado correctamente';
  //   } catch (e) {
  //     return 'Error al agregar servicio';
  //   }
  // }

  // static Future<String> deleteMototaxi(String placa) async {
  //   try {
  //     await db
  //         .collection('usuarios')
  //         .doc(uid)
  //         .collection('mototaxis')
  //         .doc(placa)
  //         .delete();

  //     final querySnapshot =
  //         await db
  //             .collection('usuarios')
  //             .doc(uid)
  //             .collection('servicios')
  //             .where('mototaxi', isEqualTo: placa)
  //             .get();

  //     if (querySnapshot.docs.isNotEmpty) {
  //       final batch = db.batch();
  //       for (var doc in querySnapshot.docs) {
  //         batch.delete(doc.reference);
  //       }
  //       await batch.commit();
  //     }

  //     return 'Mototaxi y servicios eliminados correctamente';
  //   } catch (e) {
  //     return 'Error al eliminar mototaxi, $e';
  //   }
  // }
}

// class ServicioFirebase {
//   static Future<String> updateService(
//     String placa,
//     String comentario,
//     Servicio newServicio,
//   ) async {
//     try {
//       final docRefMototaxi = db
//           .collection('usuarios')
//           .doc(uid)
//           .collection('mototaxis')
//           .doc(placa);

//       final docSnapshotMototaxi = await docRefMototaxi.get();
//       final dataMototaxi = docSnapshotMototaxi.data();
//       final servicios = dataMototaxi?['servicios'] as List<dynamic>?;

//       if (servicios == null || servicios.isEmpty) {
//         return 'No hay servicios para esta mototaxi';
//       }

//       List<Map<String, dynamic>> nuevosServicios =
//           servicios.map((s) => Map<String, dynamic>.from(s)).toList();

//       final index = nuevosServicios.indexWhere(
//         (s) => s['detalles'] == comentario,
//       );

//       if (index == -1) {
//         return 'No se encontró el servicio en la mototaxi';
//       }

//       nuevosServicios[index] = newServicio.toMap();

//       await docRefMototaxi.update({'servicios': nuevosServicios});

//       final querySnapshotServicios =
//           await db
//               .collection('usuarios')
//               .doc(uid)
//               .collection('servicios')
//               .where('detalles', isEqualTo: comentario)
//               .get();

//       if (querySnapshotServicios.docs.isNotEmpty) {
//         for (final doc in querySnapshotServicios.docs) {
//           await doc.reference.update(newServicio.toMap());
//         }
//       } else {
//         return 'No se encontró el servicio en la colección general';
//       }
//       return 'Servicio actualizado correctamente';
//     } catch (e) {
//       return 'Error al actualizar';
//     }
//   }

//   static Future<String> deleteService(String comentario, String placa) async {
//     try {
//       final querySnapshot =
//           await db
//               .collection('usuarios')
//               .doc(uid)
//               .collection('servicios')
//               .where('detalles', isEqualTo: comentario)
//               .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         final batch = db.batch();
//         for (var doc in querySnapshot.docs) {
//           batch.delete(doc.reference);
//         }
//         await batch.commit();
//       } else {
//         return 'No se encontró el servicio.';
//       }

//       final docRef = db
//           .collection('usuarios')
//           .doc(uid)
//           .collection('mototaxis')
//           .doc(placa);

//       final docSnapshot = await docRef.get();
//       if (!docSnapshot.exists) return 'No existe la mototaxi asociada.';

//       final servicios = List<Map<String, dynamic>>.from(
//         docSnapshot.get('servicios') ?? [],
//       );

//       final serviciosFiltrados =
//           servicios.where((servicio) {
//             return servicio['detalles'] != comentario;
//           }).toList();

//       await docRef.update({'servicios': serviciosFiltrados});
//       return 'Servicio eliminado correctamente!';
//     } catch (e) {
//       return 'Error inesperado al eliminar servicio.';
//     }
//   }
// }
