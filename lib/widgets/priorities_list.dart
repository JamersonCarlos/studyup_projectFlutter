import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPriorities extends StatefulWidget {
  const ListPriorities({super.key, required this.subjects});

  final Future<List<dynamic>> subjects;

  @override
  State<ListPriorities> createState() => _ListPrioritiesState();
}

class _ListPrioritiesState extends State<ListPriorities> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.subjects,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          int count = snapshot.data!.length;
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: count,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.data![index]["nome"],
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        Row(
                          children: [
                            const Icon(Icons.timelapse_sharp),
                            Text(
                              "  ${snapshot.data![index]["horas_dedicadas"]} horas",
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
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
