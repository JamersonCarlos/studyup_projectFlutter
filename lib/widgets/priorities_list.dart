import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPriorities extends StatefulWidget {
  const ListPriorities({super.key, required this.subjects, required this.uid});

  final Future<List<dynamic>> subjects;
  final String uid;

  @override
  State<ListPriorities> createState() => _ListPrioritiesState();
}

class _ListPrioritiesState extends State<ListPriorities> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.subjects,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          int count = snapshot.data!.length;
          List<dynamic>? list = snapshot.data;
          return ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final Map<dynamic, dynamic> item = list!.removeAt(oldIndex);
                list.insert(newIndex, item);
                db
                    .collection("users")
                    .doc(widget.uid)
                    .set({"disciplinas": list}, SetOptions(merge: true));
              });
            },
            padding: const EdgeInsets.all(8),
            itemCount: count,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                key: ValueKey(list![index]),
                child: Container(
                  height: 70,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    ),
                    color: Colors.blueAccent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(list[index]["nome"],
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                            Row(
                              children: [
                                const Icon(Icons.timelapse_sharp),
                                Text(
                                  "  ${list[index]["horas_dedicadas"]} horas",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
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
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  void addSubject(String nome, int number) {}
}
