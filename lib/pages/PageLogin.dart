import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/notifications.dart';
import 'package:flutter_application_1/pages/PageRegister.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/services/authetication_service.dart';
import 'package:flutter_application_1/pages/PageMain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';

import '../cubits/calendar/calendar_cubit.dart';
import '../cubits/nofications/notifications_cubit.dart';
import 'calendar/calendar_page.dart';

class AutheticationPage extends StatefulWidget {
  const AutheticationPage({super.key});

  @override
  State<AutheticationPage> createState() => _AutheticationPageState();
}

class _AutheticationPageState extends State<AutheticationPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  double heightContainer = 530;
  double aligmentContainer = -1;
  double paddinTopContainer = 100;

  bool visibility_pass = false;
  final recorder = FlutterSoundRecorder();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {});

    // FirebaseAuth.instance.authStateChanges().listen((User? event) {
    //   if (event != null) {
    //     firebaseMessaging.getToken().then((token) => db
    //         .collection("users")
    //         .doc(event.uid)
    //         .set(
    //             {"TokenMessaging": token.toString()}, SetOptions(merge: true)));
    //     Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => menuMain(
    //                   uid: event.uid,
    //                 )),
    //         (route) => false);
    //   }
    // });
  }

  
  @override
  Widget build(BuildContext context) {
    final ServiceAuthentication service = ServiceAuthentication();
    final CalendarCubit _cubit = context.read<CalendarCubit>();
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedContainer(
            padding: EdgeInsets.only(top: paddinTopContainer),
            duration: const Duration(seconds: 1, milliseconds: 500),
            alignment: Alignment(aligmentContainer, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    "Olá",
                    style: GoogleFonts.balooPaaji2(
                      fontWeight: FontWeight.bold,
                      fontSize: 64,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Vamos trabalhar a mente hoje ?",
                      style: GoogleFonts.lexendDeca(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(seconds: 1, milliseconds: 100),
            height: heightContainer,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF9756B9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 55),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF6CC2DB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 105),
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
                                    heightContainer = 650;
                                    paddinTopContainer = 30;
                                    aligmentContainer = 10;
                                  });
                                },
                                onTapOutside: (event) {
                                  setState(() {
                                    heightContainer = 530;
                                    aligmentContainer = -1;
                                    paddinTopContainer = 100;
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
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                  label: Text(
                                    'Email',
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
                      const SizedBox(
                        height: 37,
                      ),
                      Row(
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
                                  heightContainer = 650;
                                  paddinTopContainer = 30;
                                  aligmentContainer = 10;
                                });
                              },
                              onTapOutside: (event) {
                                setState(() {
                                  heightContainer = 530;
                                  aligmentContainer = -1;
                                  paddinTopContainer = 100;
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  currentFocus.unfocus();
                                });
                              },
                              obscureText: false,
                              autofocus: false,
                              controller: senha,
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
                                    color: const Color(0xFFC8C8C8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 70, top: 8),
                            child: Text(
                              "Esqueceu a sua senha ?",
                              style: GoogleFonts.lexendDeca(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: GestureDetector(
                          onTap: () {
                            // // FocusScope.of(context).requestFocus(FocusNode());
                            // service.signUp(context, _cubit, email.text, pass.text,
                            //     username.text);
                            print("Cliquei");
                            service.doLogin(
                                context, _cubit, email.text, senha.text);
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
                                "Entrar",
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
                              "Ainda não tem conta? ",
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
                                    return RegisterScreen();
                                  },
                                ), (route) => false);
                              },
                              child: Text(
                                "CRIAR",
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
            ),
          ),
          // Padding(
          //   padding:
          //       const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
          //   child: Material(
          //     borderRadius: BorderRadius.circular(50),
          //     elevation: 5.0,
          //     shadowColor: Color.fromARGB(134, 158, 158, 158),
          //     child: TextFormField(
          //       obscureText: false,
          //       autofocus: false,
          //       controller: email,
          //       keyboardType: TextInputType.emailAddress,
          //       cursorColor: Colors.grey,
          //       decoration: InputDecoration(
          //           border: InputBorder.none,
          //           prefixIcon: const Icon(
          //             Icons.person,
          //             color: Colors.grey,
          //           ),
          //           label: Text(
          //             'Username',
          //             style: GoogleFonts.lato(
          //               fontWeight: FontWeight.normal,
          //               fontSize: 15,
          //               color: Color(0xFFC8C8C8),
          //             ),
          //           )),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(25.0),
          //   child: Material(
          //     borderRadius: BorderRadius.circular(50),
          //     elevation: 5.0,
          //     shadowColor: Color.fromARGB(134, 158, 158, 158),
          //     child: TextFormField(
          //       obscureText: !visibility_pass,
          //       autofocus: false,
          //       controller: senha,
          //       keyboardType: TextInputType.emailAddress,
          //       cursorColor: Colors.grey,
          //       decoration: InputDecoration(
          //           suffixIcon: GestureDetector(
          //             child: visibility_pass
          //                 ? const Icon(
          //                     Icons.visibility,
          //                     color: Colors.grey,
          //                   )
          //                 : const Icon(
          //                     Icons.visibility_off,
          //                     color: Colors.grey,
          //                   ),
          //             onTap: () {
          //               setState(() {
          //                 visibility_pass = !visibility_pass;
          //               });
          //             },
          //           ),
          //           border: InputBorder.none,
          //           prefixIcon: const Icon(
          //             Icons.lock,
          //             color: Colors.grey,
          //           ),
          //           label: Text(
          //             'Password',
          //             style: GoogleFonts.lato(
          //               fontWeight: FontWeight.normal,
          //               fontSize: 15,
          //               color: Color(0xFFC8C8C8),
          //             ),
          //           )),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 8, right: 25, bottom: 8),
          //   child: Container(
          //     alignment: Alignment.topRight,
          //     child: Text(
          //       "Forgot your password?",
          //       textAlign: TextAlign.right,
          //       style: GoogleFonts.lato(color: Color(0xFFBEBEBE)),
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(25.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Text(
          //         "Sign in",
          //         textAlign: TextAlign.right,
          //         style: GoogleFonts.lato(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 25,
          //         ),
          //       ),
          //       IconButton(
          //           onPressed: () {
          //             service.doLogin(context, _cubit, email.text, senha.text);
          //           },
          //           iconSize: 45,
          //           icon: SvgPicture.asset('assets/img/button.svg'))
          //     ],
          //   ),
          // ),
          // Expanded(
          //   child: Row(
          //     children: [
          //       SvgPicture.asset('assets/img/bottom_background.svg'),
          //       Text(
          //         "Don't have an account ? ",
          //         style: GoogleFonts.lato(fontSize: 17),
          //       ),
          //       GestureDetector(
          //         child: Text(
          //           "Create",
          //           style: GoogleFonts.lato(
          //               fontSize: 17,
          //               color: Color(0xFF3813C2),
          //               decoration: TextDecoration.underline),
          //         ),
          //         onTap: () {
          //           Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => const RegisterScreen()));
          //         },
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
