import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PageAnotation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphic/graphic.dart';

class ListAnotations extends StatefulWidget {
  ListAnotations({super.key, required this.uid});

  String uid;

  @override
  State<ListAnotations> createState() => _ListAnotationsState();
}

class _ListAnotationsState extends State<ListAnotations> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Align(
            alignment: const Alignment(-0.8, 0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "ANOTAÇÕES",
                style: GoogleFonts.lexendDeca(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              color: Colors.black,
              height: 2,
              width: 334,
            ),
          ),
          FutureBuilder(
            future: getAllAnotations(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 12, left: 30),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Anotation(
                                    infoAnotation: snapshot.data![index],
                                  );
                                },
                              ));
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 2,
                                  color: Colors.black,
                                  width: 19,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${snapshot.data![index]["disciplina"]} ${snapshot.data![index]["title"]}",
                                    style: GoogleFonts.lexendDeca(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Future<List<dynamic>> getAllAnotations() async {
    DocumentSnapshot doc = await db.collection("users").doc(widget.uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data["anotations"];
  }
}
