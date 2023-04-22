import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/metas/metas_cubit.dart';
import 'package:flutter_application_1/models/disciplinas.dart';
import 'package:flutter_application_1/pages/calendar/calendar_page.dart';
import 'package:flutter_application_1/pages/pomodoro/pomodoro.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../cubits/calendar/calendar_cubit.dart';
import '../cubits/nofications/notifications_cubit.dart';
import '../models/notifications.dart';
import '../widgets/priorities_list.dart';
import 'PageMain.dart';

class HomeApp extends StatefulWidget {
  HomeApp({super.key, required this.user, required this.pagelocal});

  late int pagelocal;
  final String user;

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<dynamic> listSubjects = [];
  TextEditingController name_subject = TextEditingController();

  var time_selected;
  TextEditingController time_subject = TextEditingController();
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    permissionAudio();
    print(widget.user);
    // checkNotification();
  }

  Future permissionAudio() async {
    await Permission.microphone.request();
  }

  var time_selected;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(
      initialPage: widget.pagelocal,
      keepPage: true,
    );
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: AppBar(
            elevation: 10,
            backgroundColor: const Color(0xFF03045E),
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
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset('assets/img/icon_config.svg'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CircleNavBar(
          activeIcons: [
            const Icon(FontAwesomeIcons.calendarDays, color: Color(0xFF03045E)),
            GestureDetector(
              child: const Icon(FontAwesomeIcons.add, color: Color(0xFF03045E)),
              onTap: () {
                addSubjectDatabase(widget.pagelocal);
              },
            ),
            const Icon(FontAwesomeIcons.clipboardList,
                color: Color(0xFF03045E)),
          ],
          inactiveIcons: const [
            Icon(
              FontAwesomeIcons.calendarDays,
              color: Colors.white,
            ),
            Icon(
              Icons.home,
              color: Colors.white,
              size: 25,
            ),
            Icon(
              FontAwesomeIcons.clipboardUser,
              color: Colors.white,
            ),
          ],
          color: Color(0xFF03045E),
          circleColor: Colors.white,
          height: 60,
          circleWidth: 60,
          activeIndex: widget.pagelocal,
          onTap: (index) {
            setState(() {
              widget.pagelocal = index;
  
            });
            pageController.animateToPage(widget.pagelocal,
                duration: Duration(milliseconds: 400), curve: Curves.ease);
          },
          // tabCurve: ,
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
          cornerRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
            bottomLeft: Radius.circular(24),
          ),
          shadowColor: Color(0xFF03045E),
          circleShadowColor: Color(0xFF03045E),
          elevation: 10,
        ),
        backgroundColor: Colors.white,
        body: PageView(
          controller: pageController,
          children: [
            MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => CalendarCubit(),
                ),
                BlocProvider(
                  create: (context) => MetasCubit(),
                ),
              ],
              child: const CalendarPage(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: ListPriorities(
                  subjects: getAllSubjects(),
                  uid: widget.user,
                )),
              ],
            ),
            BlocProvider(
              create: (context) => MetasCubit(),
              child: const PomodoroPage(),
            ),
          ],
        ));
  }

  Future<List<dynamic>> getAllSubjects() async {
    DocumentSnapshot doc = await db.collection("users").doc(widget.user).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    listSubjects = data["disciplinas"];
    return data["disciplinas"];
  }

  void addSubjectDatabase(int index) {
    if (widget.pagelocal == 2) {
      showDialog(
          context: context,
          builder: ((BuildContext context) {
            return AlertDialog(
                backgroundColor: Color.fromARGB(160, 3, 5, 94),
                elevation: 10,
                shadowColor: Color(0xFF03045E),
                content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState1) {
                    return Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Adicionar Disciplina",
                                  style: GoogleFonts.roboto(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    maxLength: 16,
                                    controller: name_subject,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      labelText: "Nome da Disciplina",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8, left: 8, right: 8, bottom: 20),
                                  child: TextFormField(
                                    maxLength: 2,
                                    cursorColor: Colors.white,
                                    controller: time_subject,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      labelText: "Horas Dedicação",
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        name_subject.clear();
                                        time_subject.clear();
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      child: Text(
                                        "Cancelar",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        int lengthListBack =
                                            listSubjects.length;
                                        if (name_subject.text.isNotEmpty &&
                                            time_subject.text.isNotEmpty) {
                                          //define new subject using subject model
                                          Map<String, dynamic> newSubject =
                                              Disciplinas(
                                                  title: name_subject.text,
                                                  initial: DateTime.now(),
                                                  horas_dedicadas_por_semana:
                                                      int.parse(
                                                          time_subject.text),
                                                  label: "",
                                                  anotation: []).toMap();
                                          name_subject.clear();
                                          time_selected.clear();
                                          //send data of firestore database
                                          setState(
                                            () {
                                              db
                                                  .collection("users")
                                                  .doc(widget.user)
                                                  .update(
                                                {
                                                  "disciplinas":
                                                      FieldValue.arrayUnion(
                                                    [newSubject],
                                                  )
                                                },
                                              );
                                              listSubjects.add(newSubject);
                                            },
                                          );
                                          if (listSubjects.length ==
                                              lengthListBack + 1) {
                                            print(
                                                "A disciplina foi adicionada com sucesso");
                                          } else {
                                            print("Disciplina não adicionada");
                                          }
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.greenAccent),
                                      child: Text(
                                        "Adicionar",
                                        style: GoogleFonts.roboto(
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ));
          }));
    }
  }

  checkNotification() async {
    print('emitindo notificacao');
    final notificationWelcome = ReceivedNotification(
        id: 1,
        title: 'Bem vindo ao Study UP',
        body: 'Agende suas disciplinas agora',
        payload: 'payload');

    final managerNotification = context.read<NotificationsCubit>();
    managerNotification.initialize();
    managerNotification.notificationsService
        .showNotfication(notificationWelcome);
    await managerNotification.notificationsService.checkForNotifications();
  }

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
      // bottomNavigationBar: CircleNavBar(
      //   activeIcons: [
      //     const Icon(
      //       Icons.home,
      //       color: Color(0xFF03045E),
      //     ),
      //     const Icon(FontAwesomeIcons.calendarDays, color: Color(0xFF03045E)),
      //     GestureDetector(
      //       child: const Icon(FontAwesomeIcons.add, color: Color(0xFF03045E)),
      //       onTap: () {
      //         addSubjectDatabase(widget.pagelocal);
      //       },
      //     ),
      //     const Icon(FontAwesomeIcons.clipboardList,
      //         color: Color(0xFF03045E)),
      //   ],
      //   inactiveIcons: const [
      //     Icon(
      //       Icons.home,
      //       color: Colors.white,
      //     ),
      //     Icon(
      //       FontAwesomeIcons.calendarDays,
      //       color: Colors.white,
      //     ),
      //     Icon(
      //       Icons.bookmark,
      //       color: Colors.white,
      //       size: 25,
      //     ),
      //     Icon(
      //       FontAwesomeIcons.clipboardUser,
      //       color: Colors.white,
      //     ),
      //   ],
      //   color: Color(0xFF133262),
      //   circleColor: Colors.white,
      //   height: 60,
      //   circleWidth: 60,
      //   activeIndex: widget.pagelocal,
      //   onTap: (index) {
      //     setState(() {
      //       widget.pagelocal = index;
      //     });
      //     pageController.animateToPage(widget.pagelocal,
      //         duration: Duration(milliseconds: 400), curve: Curves.ease);
      //   },
      //   // tabCurve: ,
      //   padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
      //   cornerRadius: const BorderRadius.only(
      //     topLeft: Radius.circular(24),
      //     topRight: Radius.circular(24),
      //     bottomRight: Radius.circular(24),
      //     bottomLeft: Radius.circular(24),
      //   ),
      //   shadowColor: Color(0xFF03045E),
      //   circleShadowColor: Color(0xFF03045E),
      //   elevation: 10,
      // ),
      backgroundColor: Colors.white,
      body: PageView(
        controller: pageController,
        children: [
          menuMain(
            uid: widget.user,
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CalendarCubit(),
              ),
              BlocProvider(
                create: (context) => MetasCubit(),
              ),
            ],
            child: const CalendarPage(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: ListPriorities(
                uid: widget.user,
              )),
            ],
          ),
          BlocProvider(
            create: (context) => MetasCubit(),
            child: const PomodoroPage(),
          ),
        ],
      ),
    );
  }
}
