import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late String uid;
  FirebaseService._();

  static final FirebaseService instance = FirebaseService._();

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    var data = await db.collection("users").get();
    return data;
  }

  Future<List<dynamic>> getMetasByUidUser(String uid) async {
    var data = await db.collection("users").doc(uid).get();
    var subjectdata = data.data() as Map<String, dynamic>;
    return subjectdata['metas'] as List<dynamic>;
  }

  Future<void> updateEnvarimentIa(String uid, double reforco) async {
    // await db.collection("users").doc(uid).collection("QTable").add({
    //   "meta": meta,
    //   "status": false,
    // });
    print('updateEnvarimentIa');
    print('valor de reforco: $reforco');
  }
   Future<List<dynamic>> getAllSubjects() async {
    DocumentSnapshot doc = await db.collection("users").doc(uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data["disciplinas"];
  }

  Future<String> getNameUser() async {
    DocumentSnapshot doc = await db.collection("users").doc(uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data["username"];
  }
   Future<Map<String,dynamic>> getAllAnotations() async {
    DocumentSnapshot doc = await db.collection("users").doc(uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data["anotations"];
  }
}
