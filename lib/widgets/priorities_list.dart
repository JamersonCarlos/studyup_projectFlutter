import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/disciplinas.dart';
import '../pages/PageNewAnotations.dart';

class ListPriorities extends StatefulWidget {
  const ListPriorities({super.key, required this.uid});

  final String uid;

  @override
  State<ListPriorities> createState() => _ListPrioritiesState();
}

class _ListPrioritiesState extends State<ListPriorities> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool visibleTextForm = false;
  List<dynamic> listSubjects = [];
  TextEditingController subjectController = TextEditingController();
  Future<List<dynamic>>? subjects;

  Future<List<dynamic>> getAllSubjects() async {
    DocumentSnapshot doc = await db.collection("users").doc(widget.uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    listSubjects = data["disciplinas"];
    return data["disciplinas"];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future<List<dynamic>> subjects = getAllSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Disciplinas",
            style: GoogleFonts.balooPaaji2(
              color: Colors.black,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getAllSubjects(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  int count = snapshot.data!.length;
                  List<dynamic>? list = snapshot.data;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          child: ReorderableListView.builder(
                            onReorder: (oldIndex, newIndex) {
                              bool alterableList = false;
                              setState(() {
                                if (oldIndex < newIndex) {
                                  newIndex -= 1;
                                }
                                final Map<dynamic, dynamic> item =
                                    list!.removeAt(oldIndex);
                                list.insert(newIndex, item);
                                db.collection("users").doc(widget.uid).set(
                                    {"disciplinas": list},
                                    SetOptions(merge: true));
                                alterableList = true;
                              });
                              if (alterableList) {
                                print("A lista foi alterada com sucesso");
                              } else {
                                print('Erro! Ordem não alterada');
                              }
                            },
                            padding: const EdgeInsets.all(8),
                            itemCount: count,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                background: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: const Align(
                                      alignment: Alignment(-0.9, 0),
                                      child: Icon(Icons.delete,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                direction: DismissDirection.startToEnd,
                                key: Key(list![index]["title"]),
                                onDismissed: (direction) {
                                  setState(() {
                                    list.removeAt(index);
                                    db.collection("users").doc(widget.uid).set(
                                        {"disciplinas": list},
                                        SetOptions(merge: true));
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  key: ValueKey(list[index]),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Anotations(
                                              title: list[index]["title"],
                                              uid: widget.uid,
                                              index_disciplina: index,
                                            ),
                                          ));
                                    },
                                    child: Container(
                                      height: 70,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(24),
                                        ),
                                        color: Color(0xFF6CC2DB),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, bottom: 8, left: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(list[index]["title"],
                                                    style:
                                                        GoogleFonts.balooPaaji2(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20)),
                                              ],
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.menu,
                                                color: Colors.white,
                                                size: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          !visibleTextForm
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      visibleTextForm = true;
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xFF6CC2DB),
                            ),
                            height: 62,
                            child: Center(
                              child: Text(
                                "Adicionar Disciplina",
                                style: GoogleFonts.balooPaaji2(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF133262),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 62,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: GestureDetector(
                              onTap: () {
                                Map<String, dynamic> newSubject = Disciplinas(
                                    title: subjectController.text,
                                    initial: DateTime.now(),
                                    horas_dedicadas_por_semana: 0,
                                    label: "",
                                    anotation: []).toMap();
                                setState(
                                  () {
                                    visibleTextForm = false;
                                    if (subjectController.text.isNotEmpty) {
                                      db
                                          .collection("users")
                                          .doc(widget.uid)
                                          .update(
                                        {
                                          "disciplinas": FieldValue.arrayUnion(
                                            [newSubject],
                                          )
                                        },
                                      );
                                    }
                                  },
                                );
                                subjectController.clear();
                              },
                              child: const Icon(
                                Icons.add_circle_sharp,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          SizedBox(
                            width: 220,
                            child: Expanded(
                              child: Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    obscureText: false,
                                    autofocus: true,
                                    controller: subjectController,
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: Colors.grey,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      label: Center(
                                        child: Text(
                                          'Nome da disciplina',
                                          style: GoogleFonts.actor(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: const Color.fromARGB(
                                                157, 0, 0, 0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
