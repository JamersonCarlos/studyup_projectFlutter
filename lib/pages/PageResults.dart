import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphic/graphic.dart';

class ResultPage extends StatefulWidget {
  ResultPage({super.key, required this.uid});

  String uid;
  // ignore: prefer_typing_uninitialized_variables

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> getRestHours() async {
    double hoursStudy = await getAllHoursStudy();
    double totalHouras = 0;
    DocumentSnapshot doc = await db.collection("users").doc(widget.uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    for (var i = 0; i < data["metas"].length; i++) {
      if (data["metas"][i]["recompensa"] == -2) {
        totalHouras += 1;
      }
    }
    double restTime = totalHouras - hoursStudy;
    int hours = restTime.toInt();
    int minutes = ((restTime * 60) - (hours * 60)).toInt();
    if (minutes == 0) {
      return "falta ${hours} hora(s)";
    } else {
      return "falta ${hours} hora(s) e ${minutes} minuto(s)";
    }
  }

  Future<double> getAllHoursStudy() async {
    double sumTotalHours = 0;
    DocumentSnapshot doc = await db.collection("users").doc(widget.uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    for (var i = 0; i < data["metas"].length; i++) {
      if (data["metas"][i]["recompensa"] != 0) {
        sumTotalHours += data["metas"][i]["horasEstudadas"];
      }
    }
    return sumTotalHours;
  }

  Future<int> getPercentHoursStudy() async {
    double hoursStudy = await getAllHoursStudy();
    double totalHouras = 0;
    DocumentSnapshot doc = await db.collection("users").doc(widget.uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    for (var i = 0; i < data["metas"].length; i++) {
      if (data["metas"][i]["recompensa"] == -2) {
        totalHouras += 1;
      }
    }
    int percentHours = ((hoursStudy / totalHouras) * 100).toInt();
    return percentHours;
  }

  Future<List<dynamic>> getAllMetas() async {
    DocumentSnapshot doc = await db.collection("users").doc(widget.uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data["metas"];
  }

  Future<List<Map<String, dynamic>>> getAllSubjectStudent() async {
    List<Map<String, dynamic>> subjectsStudent = [];
    List<dynamic> listMetas = await getAllMetas();
    for (int i = 0; i < listMetas.length; i++) {
      print("--------${listMetas[i]}--------");
      if (listMetas[i]["recompensa"] != null) {
        if (listMetas[i]["recompensa"] > 0) {
          subjectsStudent.add({
            "genre": listMetas[i]["disciplina"],
            "sold": listMetas[i]["horasEstudadas"] * 10,
          });
        }
      }
    }
    if (subjectsStudent.isEmpty) {
      subjectsStudent.add({"genre": "nada", "sold": 100});
    }

    return subjectsStudent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(
              "Resultados",
              style: GoogleFonts.balooPaaji2(
                fontSize: 50,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          Center(
            child: Text(
              "Você estudou por",
              style: GoogleFonts.balooPaaji2(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Stack(children: [
            FutureBuilder(
              future: getAllSubjectStudent(),
              builder: (context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var basicData = snapshot.data;
                  return Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 260,
                    height: 300,
                    child: Chart(
                      data: basicData!,
                      variables: {
                        'genre': Variable(
                          accessor: (Map map) => map["genre"] as String,
                        ),
                        'sold': Variable(
                          accessor: (Map map) => map['sold'] as num,
                        ),
                      },
                      transforms: [
                        Proportion(
                          variable: 'sold',
                          as: 'percent',
                        )
                      ],
                      marks: [
                        IntervalMark(
                          position: Varset('percent') / Varset("genre"),
                          color: ColorEncode(
                              variable: 'genre', values: Defaults.colors10),
                          modifiers: [StackModifier()],
                        )
                      ],
                      coord: PolarCoord(
                        transposed: true,
                        dimCount: 1,
                        startRadius: 0.8,
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            FutureBuilder(
              future: getAllHoursStudy(),
              builder: (context, AsyncSnapshot<double> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  int hours = snapshot.data!.toInt();
                  int minutes = ((snapshot.data! * 60) - (hours * 60)).toInt();
                  return minutes == 0
                      ? Transform.translate(
                          offset: Offset(
                              MediaQuery.of(context).size.width / 2 - 130,
                              MediaQuery.of(context).size.height / 2 - 255),
                          child: Text(
                            "${hours} hora(s)",
                            style: GoogleFonts.balooPaaji2(
                                fontSize: 34, fontWeight: FontWeight.bold),
                          ))
                      : Transform.translate(
                          offset: Offset(
                              MediaQuery.of(context).size.width / 2 - 135,
                              MediaQuery.of(context).size.height / 2 - 265),
                          child: Text(
                            "   ${hours} hora(s) e\n ${minutes} minuto(s)",
                            style: GoogleFonts.balooPaaji2(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        );
                } else {
                  return Transform.translate(
                    offset: Offset(MediaQuery.of(context).size.width / 2 - 30,
                        MediaQuery.of(context).size.height / 2 - 250),
                    child: const CircularProgressIndicator(),
                  );
                }
              },
            ),
          ]),
          Expanded(
            child: FutureBuilder(
              future: getAllSubjectStudent(),
              builder: (context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data![0]["genre"] != "nada") {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 60),
                          child: Row(
                            children: [
                              Container(
                                height: 20,
                                width: 20,
                                color: ColorEncode(
                                        variable: 'genre',
                                        values: Defaults.colors10)
                                    .values!
                                    .toList()[index],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  snapshot.data![index]["genre"],
                                  style: GoogleFonts.balooPaaji2(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 43),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Meta Semanal",
                style: GoogleFonts.balooPaaji2(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                height: 35,
                width: 320,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
              ),
              FutureBuilder(
                future: getPercentHoursStudy(),
                builder: (context, AsyncSnapshot<int> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AnimatedContainer(
                      duration: const Duration(seconds: 1),
                      height: 35,
                      width: (snapshot.data! / 100) * 320,
                      decoration: const BoxDecoration(
                        color: Color(0xFF9756B9),
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${snapshot.data!}%",
                          style: GoogleFonts.balooPaaji2(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      height: 20,
                      width: 20,
                      child: const CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 45, bottom: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: FutureBuilder(
                future: getRestHours(),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.data!,
                      style: GoogleFonts.balooPaaji2(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
