import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/PageRegister.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

import '../cubits/calendar/calendar_cubit.dart';
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
  FirebaseFirestore db = FirebaseFirestore.instance;

  bool visibility_pass = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final CalendarCubit _cubit = context.read<CalendarCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          SvgPicture.asset('assets/img/top_background.svg'),
          Text(
            "Hello",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold,
              fontSize: 64,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 10),
            child: Material(
              borderRadius: BorderRadius.circular(50),
              elevation: 5.0,
              shadowColor: Color.fromARGB(134, 158, 158, 158),
              child: TextFormField(
                obscureText: false,
                autofocus: false,
                controller: email,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    label: Text(
                      'Username',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Color(0xFFC8C8C8),
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Material(
              borderRadius: BorderRadius.circular(50),
              elevation: 5.0,
              shadowColor: Color.fromARGB(134, 158, 158, 158),
              child: TextFormField(
                obscureText: !visibility_pass,
                autofocus: false,
                controller: senha,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      child: visibility_pass
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                      onTap: () {
                        setState(() {
                          visibility_pass = !visibility_pass;
                        });
                      },
                    ),
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: Colors.grey,
                    ),
                    label: Text(
                      'Password',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Color(0xFFC8C8C8),
                      ),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 25, bottom: 8),
            child: Container(
              alignment: Alignment.topRight,
              child: Text(
                "Forgot your password?",
                textAlign: TextAlign.right,
                style: GoogleFonts.lato(color: Color(0xFFBEBEBE)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Sign in",
                  textAlign: TextAlign.right,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      doLogin(context, _cubit);
                    },
                    iconSize: 45,
                    icon: SvgPicture.asset('assets/img/button.svg'))
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset('assets/img/bottom_background.svg'),
                Text(
                  "Don't have an account ? ",
                  style: GoogleFonts.lato(fontSize: 17),
                ),
                GestureDetector(
                  child: Text(
                    "Create",
                    style: GoogleFonts.lato(
                        fontSize: 17,
                        color: Color(0xFF3813C2),
                        decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void doLogin(BuildContext context, CalendarCubit _cubit) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.text, password: senha.text);
      if (user != null) {
        senha.clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return BlocProvider<CalendarCubit>.value(
            value: _cubit,
            child: const CalendarPage(),
          );
        }), (Route<dynamic> route) => false);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xFF3813C2),
            content: Text(
              textAlign: TextAlign.center,
              'Usuário não encontrado! Cadastra-se ',
              style: GoogleFonts.lato(fontSize: 18),
            ),
          ),
        );
      }
    }
  }
}
