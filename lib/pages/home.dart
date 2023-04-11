import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/disciplinas.dart';
import 'package:flutter_application_1/pages/calendar/calendar_page.dart';
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

class HomeApp extends StatefulWidget {
  const HomeApp({super.key, required this.user});

  final String user;

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int _selectedIndex = 1;
  FirebaseFirestore db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController name_subject = TextEditingController();
  TextEditingController time_subject = TextEditingController();

  PageController pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );
  @override
  void initState() {
    super.initState();
    permissionAudio();
    // checkNotification();
  }

  Future permissionAudio() async {
    await Permission.microphone.request();
  }

  var time_selected;

  @override
  Widget build(BuildContext context) {
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
                addSubjectDatabase(_selectedIndex);
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
          activeIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            pageController.animateToPage(index,
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
            BlocProvider(
              create: (context) => CalendarCubit(),
              child: CalendarPage(),
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
            Container(),
          ],
        ));
  }

  Future<List<dynamic>> getAllSubjects() async {
    DocumentSnapshot doc = await db.collection("users").doc(widget.user).get();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return data["disciplinas"];
  }

  void addSubjectDatabase(int index) {
    if (_selectedIndex == 1) {
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
                                            },
                                          );
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
}
