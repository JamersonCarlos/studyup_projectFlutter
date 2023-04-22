import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/PageResults.dart';
import 'package:flutter_application_1/pages/calendar/calendar_page.dart';
import 'package:flutter_application_1/pages/pomodoro/pomodoro.dart';
import 'package:flutter_application_1/widgets/priorities_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubits/calendar/calendar_cubit.dart';
import '../cubits/metas/metas_cubit.dart';

class menuMain extends StatefulWidget {
  menuMain({super.key, required this.uid});

  String uid;

  @override
  State<menuMain> createState() => _menuMainState();
}

class _menuMainState extends State<menuMain> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Color primaryColor = Color(0xFFA973C5);
  List<dynamic> listSubjects = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          elevation: 10,
          backgroundColor: const Color(0xFF133262),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          leading: const Icon(
            Icons.account_circle_rounded,
            color: Colors.white,
            size: 50,
          ),
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          title: const Text(
            "Jamerson Carlos",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset('assets/img/icon_config.svg'),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Transform.translate(
              offset: const Offset(-27, 0),
              child: Transform.scale(
                scale: 0.7,
                child: Transform.rotate(
                  angle: 3.14 / 4,
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    crossAxisCount: 2,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ListPriorities(
                                    // subjects: getAllSubjects(),
                                    uid: widget.uid);
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor),
                          width: 125,
                          height: 125,
                          child: iconMenu(Icons.menu_book, "Disciplinas"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const ResultPage();
                            },
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor),
                          width: 125,
                          height: 125,
                          child: iconMenu(
                              Icons.pie_chart_outline_sharp, "Resultados"),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider(
                                    create: (context) => CalendarCubit(),
                                  ),
                                  BlocProvider(
                                    create: (context) => MetasCubit(),
                                  ),
                                ],
                                child: const CalendarPage(),
                              );
                            },
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor),
                          width: 125,
                          height: 125,
                          child: iconMenu(
                              Icons.calendar_month_outlined, "Calendário"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: primaryColor),
                        width: 125,
                        height: 125,
                        child:
                            iconMenu(Icons.sticky_note_2_outlined, "Anotações"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => CalendarCubit(),
                      ),
                      BlocProvider(
                        create: (context) => MetasCubit(),
                      ),
                    ],
                    child: const PomodoroPage(),
                  );
                },
              ));
            },
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: const Color(0xFF133262),
                  borderRadius: BorderRadius.circular(100)),
              child: Center(
                child: Text("Estudar",
                    style: GoogleFonts.balooPaaji2(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Future<List<dynamic>> getAllSubjects() async {
    DocumentSnapshot doc = await db.collection("users").doc(widget.uid).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    listSubjects = data["disciplinas"];
    return data["disciplinas"];
  }
}

Widget iconMenu(IconData value, String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 15, left: 15),
    child: Transform.rotate(
      angle: -3.14 / 4,
      child: Column(
        children: [
          Icon(
            shadows: const [
              Shadow(color: Colors.black, blurRadius: 2),
            ],
            value,
            color: Colors.black,
            size: 80,
          ),
          Text(
            text,
            style: GoogleFonts.lexendDeca(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
        ],
      ),
    ),
  );
}
