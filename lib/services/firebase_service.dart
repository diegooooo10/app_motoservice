import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUser() async {
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
