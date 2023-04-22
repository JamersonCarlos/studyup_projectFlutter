import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/calendar/calendar_cubit.dart';
import 'package:flutter_application_1/pages/PageLogin.dart';
import 'package:flutter_application_1/services/authetication_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../cubits/metas/metas_cubit.dart';
import '../cubits/nofications/notifications_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phone = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  final CalendarCubit _cubit = CalendarCubit();

  bool validator_email = false;
  bool validator_pass = false;
  bool exist_email = false;

  double heightContainer = 570;
  double dyOffset = 0;
  double dyOffset2 = 0;

  @override
  Widget build(BuildContext context) {
    ServiceAuthentication service = ServiceAuthentication();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSlide(
                duration: const Duration(seconds: 1),
                offset: Offset(0.2, dyOffset),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Crie a",
                      style: GoogleFonts.balooTamma2(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -25),
                      child: Text(
                        "sua conta",
                        style: GoogleFonts.balooTamma2(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -30),
                      child: Text(
                        "Bem vindo ao STUDYUP",
                        style: GoogleFonts.lexendDeca(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSlide(
                duration: const Duration(seconds: 1),
                offset: Offset(0, dyOffset2),
                child: Container(
                  height: 900,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9756B9),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 71),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 275,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(161, 0, 0, 0),
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                onTap: () {
                                  setState(() {
                                    dyOffset = -2;
                                    dyOffset2 = -0.2;
                                    heightContainer =
                                        MediaQuery.of(context).size.height;
                                  });
                                },
                                onTapOutside: (event) {
                                  setState(() {
                                    heightContainer = 570;
                                    dyOffset = 0;
                                    dyOffset2 = 0;
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    currentFocus.unfocus();
                                  });
                                },
                                obscureText: false,
                                autofocus: false,
                                controller: username,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    'Username',
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Color(0xFFC8C8C8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 275,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(161, 0, 0, 0),
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                onTap: () {
                                  setState(() {
                                    dyOffset = -2;
                                    dyOffset2 = -0.2;
                                    heightContainer =
                                        MediaQuery.of(context).size.height;
                                  });
                                },
                                onTapOutside: (event) {
                                  setState(() {
                                    heightContainer = 570;
                                    dyOffset = 0;
                                    dyOffset2 = 0;
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    currentFocus.unfocus();
                                  });
                                },
                                obscureText: false,
                                autofocus: false,
                                controller: pass,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.password,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    'Password',
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Color(0xFFC8C8C8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 275,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(161, 0, 0, 0),
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                onTap: () {
                                  setState(() {
                                    dyOffset = -2;
                                    dyOffset2 = -0.2;
                                    heightContainer =
                                        MediaQuery.of(context).size.height;
                                  });
                                },
                                onTapOutside: (event) {
                                  setState(() {
                                    heightContainer = 570;
                                    dyOffset = 0;
                                    dyOffset2 = 0;
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    currentFocus.unfocus();
                                  });
                                },
                                obscureText: false,
                                autofocus: false,
                                controller: email,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    'E-mail',
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Color(0xFFC8C8C8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 275,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(161, 0, 0, 0),
                                    blurRadius: 3,
                                    offset: Offset(0, 2),
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                onTap: () {
                                  setState(() {
                                    dyOffset = -2;
                                    dyOffset2 = -0.2;
                                    heightContainer =
                                        MediaQuery.of(context).size.height;
                                  });
                                },
                                onTapOutside: (event) {
                                  setState(() {
                                    heightContainer = 570;
                                    dyOffset = 0;
                                    dyOffset2 = 0;
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    currentFocus.unfocus();
                                  });
                                },
                                obscureText: false,
                                autofocus: false,
                                controller: phone,
                                keyboardType: TextInputType.emailAddress,
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: const Icon(
                                    Icons.phone_in_talk_outlined,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    'Phone',
                                    style: GoogleFonts.lato(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15,
                                      color: Color(0xFFC8C8C8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 41),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            service.signUp(context, _cubit, email.text,
                                pass.text, username.text);
                          },
                          child: Container(
                            width: 132,
                            height: 45,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(161, 0, 0, 0),
                                  blurRadius: 3,
                                  offset: Offset(0, 2),
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Center(
                              child: Text(
                                "Criar",
                                style: GoogleFonts.lexendDeca(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(41),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Já tem uma conta?",
                              style: GoogleFonts.lexendDeca(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushAndRemoveUntil(context,
                                    MaterialPageRoute(
                                  builder: (context) {
                                    return MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                            create: (context) =>
                                                CalendarCubit()),
                                        BlocProvider(
                                            create: (context) =>
                                                NotificationsCubit(context)),
                                        BlocProvider(
                                            create: (context) => MetasCubit()),
                                      ],
                                      child: const AutheticationPage(),
                                    );
                                  },
                                ), (route) => false);
                              },
                              child: Text(
                                "ACESSAR",
                                style: GoogleFonts.lexendDeca(
                                  color: Colors.black,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
