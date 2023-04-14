import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

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
}
