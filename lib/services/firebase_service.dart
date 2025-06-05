import 'package:app_motoservice/models/mototaxis_modelo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class FirebaseService {
  static Future<List> getUser() async {
    List user = [];
    try {
      CollectionReference collectionReferenceUser = db.collection('mototaxis');
      QuerySnapshot queryUser = await collectionReferenceUser.get();
      for (var doc in queryUser.docs) {
        user.add(doc.data());
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<List<Mototaxi>> getMockData() async {
    await Future.delayed(Duration(milliseconds: 500));
    return users.map((u) => Mototaxi.fromMap(u)).toList();
  }
}
