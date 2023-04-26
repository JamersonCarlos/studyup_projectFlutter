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

  Future<void> updateEnvarimentIa(String disciplina, String uid, double reforco,int minutosDeEstudo,String horaDeIncio) async {
    DocumentSnapshot doc = await db.collection("users").doc(uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    for(int i = 0 ; i < data["metas"].length; i++){
      if(data["metas"][i]["disciplina"] == disciplina && data["metas"][i]["horario_meta"] == horaDeIncio){
        data["metas"][i]["reforco"] += reforco;
        data["metas"][i]["horasEstudadas"] += minutosDeEstudo;
      }
    }
     db.collection("users").doc(uid).set(
      {
        "metas": data["metas"]
      }, SetOptions(merge: true)
    );
    print(data["metas"]);
  }

  Future<List<dynamic>> getAllSubjects() async {
    DocumentSnapshot doc = await db.collection("users").doc(uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data["disciplinas"];
  }

  DateTime _transformData(Map<String, dynamic> meta) {
    String dateString =
        "${meta['dataMeta'] + "T" + meta['horario_meta']}:00.000Z";
    try {
      DateTime date = DateTime.parse(dateString);
      return date;
    } catch (e) {
      return DateTime.now();
    }
  }

  Future<Map<String, dynamic>> getAllAnotations() async {
    DocumentSnapshot doc = await db.collection("users").doc(uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data["anotations"];
  }
}
